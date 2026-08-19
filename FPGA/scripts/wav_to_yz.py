#!/usr/bin/env python3
# =====================================================================
#  wav_to_yz.py — WAV ses dosyasi -> YZ hizlandirici girdi hex'i
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  NE YAPAR
#  --------
#  1 saniyelik bir konusma kaydini (WAV), YZ hizlandiricisinin bekledigi
#  49x40 = 1960 baytlik ozellik (feature) haritasina cevirir ve
#  scripts/sound_outputs/<isim>.hex olarak yazar. Cikti dosyasi dogrudan
#  `send_data.py audio <dosya-yolu>` ile karta gonderilebilir.
#
#  Not: firmware/sound_samples/ klasorune DOKUNULMAZ; oradaki uc referans
#  dosya send_data.py'nin yes/no/sessizlik kisayollarina aittir.
#
#  Uretilen veri, TFLite Micro "micro_speech" on isleme hattinin
#  (microfrontend) BIT-EXACT Python portudur:
#
#     16 kHz mono int16  (1 s = 16000 ornek)
#       -> Hann penceresi   30 ms pencere / 20 ms adim  -> 49 kare
#       -> 512 noktali int16 sabit-nokta FFT (kissfft, FIXED_POINT=16)
#       -> 40 kanalli mel filtre bankasi + tam sayi karekok
#       -> gurultu azaltma (noise reduction)
#       -> PCAN otomatik kazanc kontrolu
#       -> tam sayi logaritma + olcekleme
#       -> int8 nicemleme:  q = (v*256 + 333) / 666 - 128
#       -> hex dosyaya uint8 olarak yazilir:  bayt = q + 128
#
#  Son satirdaki +128 kaymasi (offset-binary) hizlandiricinin bekledigi
#  bicimdir: conv_accelerator.v girdi zero-point'ini -128 kabul edip
#  RAM'den okudugu bayti dogrudan (q_in + 128) olarak kullanir, yani
#  ZP cikarma yapmaz. Bu yuzden dosyaya int8 degil uint8 yaziyoruz.
#
#  KULLANIM
#  --------
#      python3 wav_to_yz.py evet.wav
#          -> scripts/sound_outputs/evet.hex
#
#      python3 wav_to_yz.py kayit.wav -o /tmp/deneme.hex
#      python3 wav_to_yz.py *.wav                    # toplu donusum
#      python3 wav_to_yz.py kayit.wav --preview      # ASCII spektrogram bas
#      python3 wav_to_yz.py uzun.wav --auto-align    # en yuksek enerjili 1 s
#      python3 wav_to_yz.py kisik.wav --gain 6       # +6 dB kazanc
#
#  Sonra (dosya yolunu dogrudan vererek):
#      cd firmware
#      python3 scripts/send_data.py audio ../scripts/sound_outputs/evet.hex
#
#  GIRDI SESI
#  ----------
#  * Ideali: 16 kHz, mono, 16-bit PCM, tam 1 saniye.
#  * Farkli ornekleme frekansi / stereo / 8-24-32 bit PCM kabul edilir;
#    script mono'ya indirir ve 16 kHz'e dogrusal interpolasyonla cevirir.
#    Kalite icin kaydi bastan 16 kHz almak ya da once donusturmek daha iyi:
#        ffmpeg -i giris.mp3 -ac 1 -ar 16000 -sample_fmt s16 -t 1 cikis.wav
#  * 1 s'den kisa kayitlar sonuna sifir eklenerek uzatilir, uzun kayitlarda
#    ilk 1 saniye alinir (--offset / --auto-align ile degistirilebilir).
#
#  Bagimlilik yok — sadece Python 3 standart kutuphanesi.
# =====================================================================
"""1 saniyelik WAV kaydini YZ hizlandirici girdi hex'ine (1960 bayt) cevirir."""

import argparse
import math
import struct
import sys
import wave
from pathlib import Path

# =====================================================================
#  SABITLER
#  micro_model_settings.h + micro_features_generator.cc (TFLite Micro)
# =====================================================================
SAMPLE_RATE = 16000        # kAudioSampleFrequency
WINDOW_MS = 30             # kFeatureSliceDurationMs
STRIDE_MS = 20             # kFeatureSliceStrideMs
NUM_CHANNELS = 40          # kFeatureSliceSize   (mel kanali)
NUM_SLICES = 49            # kFeatureSliceCount  (zaman karesi)
FEATURE_LEN = NUM_CHANNELS * NUM_SLICES          # 1960  <- YZ RAM'e giden

LOWER_BAND_LIMIT = 125.0
UPPER_BAND_LIMIT = 7500.0
NR_SMOOTHING_BITS = 10
NR_EVEN_SMOOTHING = 0.025
NR_ODD_SMOOTHING = 0.06
NR_MIN_SIGNAL_REMAINING = 0.05
PCAN_STRENGTH = 0.95
PCAN_OFFSET = 80.0
PCAN_GAIN_BITS = 21
LOG_SCALE_SHIFT = 6

# Sabit-nokta olcek bitleri (microfrontend basliklarindaki k* sabitleri)
WINDOW_BITS = 12           # kFrontendWindowBits
FILTERBANK_BITS = 12       # kFilterbankBits
NOISE_BITS = 14            # kNoiseReductionBits
PCAN_SNR_BITS = 12         # kPcanSnrBits
PCAN_OUT_BITS = 6          # kPcanOutputBits
WIDE_DYN_BITS = 32         # kWideDynamicFunctionBits
LOG_SEGMENTS_LOG2 = 7      # kLogSegmentsLog2
LOG_SCALE = 65536          # kLogScale
LOG_SCALE_LOG2 = 16        # kLogScaleLog2
LOG_COEFF = 45426          # kLogCoeff

# log_lut.c — log2 kesirli kismi icin parcali dogrusal LUT
LOG_LUT = (
    0, 224, 442, 654, 861, 1063, 1259, 1450, 1636, 1817, 1992, 2163,
    2329, 2490, 2646, 2797, 2944, 3087, 3224, 3358, 3487, 3611, 3732, 3848,
    3960, 4068, 4172, 4272, 4368, 4460, 4549, 4633, 4714, 4791, 4864, 4934,
    5001, 5063, 5123, 5178, 5231, 5280, 5326, 5368, 5408, 5444, 5477, 5507,
    5533, 5557, 5578, 5595, 5610, 5622, 5631, 5637, 5640, 5641, 5638, 5633,
    5626, 5615, 5602, 5586, 5568, 5547, 5524, 5498, 5470, 5439, 5406, 5370,
    5332, 5291, 5249, 5203, 5156, 5106, 5054, 5000, 4944, 4885, 4825, 4762,
    4697, 4630, 4561, 4490, 4416, 4341, 4264, 4184, 4103, 4020, 3935, 3848,
    3759, 3668, 3575, 3481, 3384, 3286, 3186, 3084, 2981, 2875, 2768, 2659,
    2549, 2437, 2323, 2207, 2090, 1971, 1851, 1729, 1605, 1480, 1353, 1224,
    1094, 963, 830, 695, 559, 421, 282, 142, 0, 0,
)


# =====================================================================
#  TAM SAYI / SABIT-NOKTA YARDIMCILARI
#
#  Referans C kodu int16/uint32/uint64 uzerinde tasma (wrap) davranisiyla
#  calisir; Python tam sayilari sinirsiz oldugu icin her adimda ayni
#  genisliğe kirpmak zorundayiz. Aksi halde cikti C'den sapar.
# =====================================================================
def _f32(x):
    """Double -> float32 yuvarlama. C referansi float ile hesapliyor."""
    return struct.unpack("<f", struct.pack("<f", float(x)))[0]


def _i16(x):
    """int16'ya sar (C'de int16_t alanina atama)."""
    x &= 0xFFFF
    return x - 0x10000 if x & 0x8000 else x


def _u32(x):
    return x & 0xFFFFFFFF


def _msb(n):
    """MostSignificantBit32/64: 32 - clz(n). n=0 icin 0."""
    return n.bit_length()


# --- kissfft FIXED_POINT=16 makrolari (_kiss_fft_guts.h) ---
def _sround(x):
    """sround(x) = (int16_t)((x + (1<<14)) >> 15)"""
    return _i16((x + (1 << 14)) >> 15)


def _divscalar(x, k):
    """DIVSCALAR(x,k) = sround(x * (SAMP_MAX/k)).  Dikkat: SAMP_MAX/k tam
    sayi bolmesidir (32767/4 = 8191), yani tam bir /k degildir."""
    return _sround(x * (32767 // k))


def _cmul(a, b):
    """C_MUL: (a.r*b.r - a.i*b.i, a.r*b.i + a.i*b.r), her biri sround'lu."""
    return [_sround(a[0] * b[0] - a[1] * b[1]),
            _sround(a[0] * b[1] + a[1] * b[0])]


def _cexp(phase):
    """kf_cexp: floor(0.5 + 32767*cos/sin(phase)) — double hassasiyetle."""
    return [int(math.floor(0.5 + 32767 * math.cos(phase))),
            int(math.floor(0.5 + 32767 * math.sin(phase)))]


# =====================================================================
#  kissfft int16 gercek-degerli FFT portu (kiss_fft.c + kiss_fftr.c, v130)
#
#  Neden birebir port? Sabit-nokta kissfft her kelebek asamasinda
#  C_FIXDIV ile bolme yapar, yani cikti "gercek FFT / N" degildir;
#  yuvarlama hatalari ozellik degerlerine dogrudan yansir. Float bir FFT
#  ile hesaplarsak degerler +-1 LSB sapar ve referans hex'lerle
#  karsilastirma yapilamaz hale gelir.
# =====================================================================
def _kf_factor(n):
    """kf_factor: 4'un, sonra 2'nin, sonra kalan asal carpanlarin ayrimi."""
    factors = []
    p = 4
    floor_sqrt = math.floor(math.sqrt(n))
    while True:
        while n % p:
            if p == 4:
                p = 2
            elif p == 2:
                p = 3
            else:
                p += 2
            if p > floor_sqrt:
                p = n
        n //= p
        factors.append(p)
        factors.append(n)
        if n <= 1:
            break
    return factors


class _KissFftR:
    """kiss_fftr(nfft) — nfft gercek ornek girer, nfft/2+1 kompleks cikar."""

    def __init__(self, nfft):
        if nfft & (nfft - 1):
            raise ValueError("FFT boyu 2'nin kuvveti olmali (bu SoC'de 512)")
        self.nfft = nfft
        self.ncfft = nfft // 2
        n = self.ncfft
        # kiss_fft_alloc: twiddle'lar
        self.twiddles = [_cexp(-2.0 * math.pi * i / n) for i in range(n)]
        self.factors = _kf_factor(n)
        # kiss_fftr_alloc: super twiddle'lar
        pi = 3.14159265358979323846264338327
        self.super_tw = [_cexp(-pi * ((i + 1) / n + 0.5)) for i in range(n // 2)]

    # ---- kelebekler ----
    def _bfly2(self, F, o, fstride, m):
        tw = self.twiddles
        for i in range(m):
            a = F[o + i]
            b = F[o + i + m]
            a = [_divscalar(a[0], 2), _divscalar(a[1], 2)]
            b = [_divscalar(b[0], 2), _divscalar(b[1], 2)]
            t = _cmul(b, tw[i * fstride])
            F[o + i + m] = [_i16(a[0] - t[0]), _i16(a[1] - t[1])]
            F[o + i] = [_i16(a[0] + t[0]), _i16(a[1] + t[1])]

    def _bfly4(self, F, o, fstride, m):
        tw = self.twiddles
        m2, m3 = 2 * m, 3 * m
        for k in range(m):
            f0 = F[o + k]
            f1 = F[o + k + m]
            f2 = F[o + k + m2]
            f3 = F[o + k + m3]
            f0 = [_divscalar(f0[0], 4), _divscalar(f0[1], 4)]
            f1 = [_divscalar(f1[0], 4), _divscalar(f1[1], 4)]
            f2 = [_divscalar(f2[0], 4), _divscalar(f2[1], 4)]
            f3 = [_divscalar(f3[0], 4), _divscalar(f3[1], 4)]

            s0 = _cmul(f1, tw[k * fstride])
            s1 = _cmul(f2, tw[2 * k * fstride])
            s2 = _cmul(f3, tw[3 * k * fstride])

            s5 = [_i16(f0[0] - s1[0]), _i16(f0[1] - s1[1])]
            f0 = [_i16(f0[0] + s1[0]), _i16(f0[1] + s1[1])]
            s3 = [_i16(s0[0] + s2[0]), _i16(s0[1] + s2[1])]
            s4 = [_i16(s0[0] - s2[0]), _i16(s0[1] - s2[1])]

            F[o + k + m2] = [_i16(f0[0] - s3[0]), _i16(f0[1] - s3[1])]
            F[o + k] = [_i16(f0[0] + s3[0]), _i16(f0[1] + s3[1])]
            # ileri FFT (inverse degil)
            F[o + k + m] = [_i16(s5[0] + s4[1]), _i16(s5[1] - s4[0])]
            F[o + k + m3] = [_i16(s5[0] - s4[1]), _i16(s5[1] + s4[0])]

    def _work(self, F, o, fin, foff, fstride, fi):
        p = self.factors[fi]
        m = self.factors[fi + 1]
        if m == 1:
            for i in range(p):
                s = fin[foff + fstride * i]
                F[o + i] = [s[0], s[1]]
        else:
            for i in range(p):
                self._work(F, o + i * m, fin, foff + fstride * i,
                           fstride * p, fi + 2)
        if p == 4:
            self._bfly4(F, o, fstride, m)
        elif p == 2:
            self._bfly2(F, o, fstride, m)
        else:
            raise NotImplementedError(f"radix-{p} kelebegi portlanmadi")

    def run(self, time_data):
        """time_data: nfft adet int16 -> [ [re,im], ... ] (ncfft+1 eleman)"""
        n = self.ncfft
        # Gercek dizi, kompleks dizi gibi yeniden yorumlanir (cift/tek ornekler)
        fin = [[time_data[2 * i], time_data[2 * i + 1]] for i in range(n)]
        tmp = [[0, 0] for _ in range(n)]
        self._work(tmp, 0, fin, 0, 1, 0)

        freq = [[0, 0] for _ in range(n + 1)]
        tdc = [_divscalar(tmp[0][0], 2), _divscalar(tmp[0][1], 2)]
        freq[0] = [_i16(tdc[0] + tdc[1]), 0]
        freq[n] = [_i16(tdc[0] - tdc[1]), 0]
        for k in range(1, n // 2 + 1):
            fpk = [_divscalar(tmp[k][0], 2), _divscalar(tmp[k][1], 2)]
            fpnk = [_divscalar(tmp[n - k][0], 2),
                    _divscalar(_i16(-tmp[n - k][1]), 2)]
            f1k = [_i16(fpk[0] + fpnk[0]), _i16(fpk[1] + fpnk[1])]
            f2k = [_i16(fpk[0] - fpnk[0]), _i16(fpk[1] - fpnk[1])]
            tw = _cmul(f2k, self.super_tw[k - 1])
            # HALF_OF: int toplamda kaydirma, sonra int16'ya atama
            freq[k] = [_i16((f1k[0] + tw[0]) >> 1), _i16((f1k[1] + tw[1]) >> 1)]
            freq[n - k] = [_i16((f1k[0] - tw[0]) >> 1),
                           _i16((tw[1] - f1k[1]) >> 1)]
        return freq


# =====================================================================
#  MICROFRONTEND
#  tensorflow/lite/experimental/microfrontend/lib/*.c portu
# =====================================================================
def _freq_to_mel(freq):
    """FreqToMel: 1127 * log1p(f/700), float32 hassasiyetle."""
    return _f32(_f32(1127.0) * _f32(math.log1p(_f32(freq / 700.0))))


def _sqrt32(num):
    """filterbank.c Sqrt32 — tam sayi karekok, yuvarlamali."""
    if num == 0:
        return 0
    res = 0
    max_bit_number = 32 - _msb(num)
    max_bit_number |= 1
    bit = 1 << (31 - max_bit_number)
    iterations = (31 - max_bit_number) // 2 + 1
    while iterations:
        iterations -= 1
        if num >= res + bit:
            num -= res + bit
            res = (res >> 1) + bit
        else:
            res >>= 1
        bit >>= 2
    if num > res and res != 0xFFFF:
        res += 1
    return res


def _sqrt64(num):
    """filterbank.c Sqrt64 — ust kelime bossa 32-bit yola sapar (referans
    kod da oyle yapiyor, 2^32 civarinda 1 fark verebilir; kasitli)."""
    if (num >> 32) == 0:
        return _sqrt32(num)
    res = 0
    max_bit_number = 64 - _msb(num)
    max_bit_number |= 1
    bit = 1 << (63 - max_bit_number)
    iterations = (63 - max_bit_number) // 2 + 1
    while iterations:
        iterations -= 1
        if num >= res + bit:
            num -= res + bit
            res = (res >> 1) + bit
        else:
            res >>= 1
        bit >>= 2
    if num > res and res != 0xFFFFFFFF:
        res += 1
    return res


class MicroFrontend:
    """TFLite Micro microfrontend'in bire bir Python karsiligi.

    process(samples) her cagrildiginda pencere doldugu surece bir kare
    (40 kanal, uint16) uretir; state (gurultu tahmini, pencere tamponu)
    kareler arasinda tasinir — bu yuzden ornekleri sirayla beslemek gerekir.
    """

    def __init__(self, sample_rate=SAMPLE_RATE):
        self.sample_rate = sample_rate
        self._init_window()
        self.fft_size = 1
        while self.fft_size < self.window_size:
            self.fft_size <<= 1
        self.fft = _KissFftR(self.fft_size)
        self.spectrum_size = self.fft_size // 2 + 1
        self._init_filterbank()
        self._init_noise_reduction()
        self._init_pcan()
        # frontend_util.c: correction bits = MSB(fft_size) - 1 - kFilterbankBits/2
        self.correction_bits = _msb(self.fft_size) - 1 - (FILTERBANK_BITS // 2)
        self.reset()

    # ---- window_util.c ----
    def _init_window(self):
        self.window_size = WINDOW_MS * self.sample_rate // 1000   # 480
        self.window_step = STRIDE_MS * self.sample_rate // 1000   # 320
        arg = _f32(_f32(_f32(math.pi) * 2.0) / _f32(self.window_size))
        self.window_coeff = []
        for i in range(self.window_size):
            v = _f32(math.cos(_f32(arg * _f32(i + 0.5))))
            fv = _f32(_f32(0.5) - _f32(_f32(0.5) * v))
            self.window_coeff.append(
                int(math.floor(_f32(_f32(fv * (1 << WINDOW_BITS)) + 0.5))))

    # ---- filterbank_util.c ----
    def _init_filterbank(self):
        num_ch = NUM_CHANNELS
        num_ch_p1 = num_ch + 1
        index_alignment = 2          # kFilterbankIndexAlignment(4) / sizeof(int16)
        block_size = 4               # kFilterbankChannelBlockSize

        mel_low = _freq_to_mel(LOWER_BAND_LIMIT)
        mel_hi = _freq_to_mel(UPPER_BAND_LIMIT)
        mel_span = _f32(mel_hi - mel_low)
        mel_spacing = _f32(mel_span / _f32(num_ch_p1))
        center_mel = [_f32(mel_low + _f32(mel_spacing * (i + 1)))
                      for i in range(num_ch_p1)]

        hz_per_sbin = _f32(_f32(_f32(0.5) * self.sample_rate) /
                           _f32(self.spectrum_size - 1))
        self.start_index = int(_f32(1.5 + _f32(LOWER_BAND_LIMIT / hz_per_sbin)))
        self.end_index = 0

        chan_freq_index_start = self.start_index
        weight_index_start = 0
        needs_zeros = False

        self.ch_freq_starts = [0] * num_ch_p1
        self.ch_weight_starts = [0] * num_ch_p1
        self.ch_widths = [0] * num_ch_p1
        actual_starts = [0] * num_ch_p1
        actual_widths = [0] * num_ch_p1

        for chan in range(num_ch_p1):
            freq_index = chan_freq_index_start
            while _freq_to_mel(_f32(freq_index * hz_per_sbin)) <= center_mel[chan]:
                freq_index += 1
            width = freq_index - chan_freq_index_start
            actual_starts[chan] = chan_freq_index_start
            actual_widths[chan] = width

            if width == 0:
                # Bu kanala hic frekans dusmuyor: sifir agirliklara yonlendir.
                self.ch_freq_starts[chan] = 0
                self.ch_weight_starts[chan] = 0
                self.ch_widths[chan] = block_size
                if not needs_zeros:
                    needs_zeros = True
                    for j in range(chan):
                        self.ch_weight_starts[j] += block_size
                    weight_index_start += block_size
            else:
                aligned_start = (chan_freq_index_start // index_alignment) * index_alignment
                aligned_width = chan_freq_index_start - aligned_start + width
                padded_width = ((aligned_width - 1) // block_size + 1) * block_size
                self.ch_freq_starts[chan] = aligned_start
                self.ch_weight_starts[chan] = weight_index_start
                self.ch_widths[chan] = padded_width
                weight_index_start += padded_width
            chan_freq_index_start = freq_index

        self.weights = [0] * weight_index_start
        self.unweights = [0] * weight_index_start

        for chan in range(num_ch_p1):
            frequency = actual_starts[chan]
            num_freqs = actual_widths[chan]
            freq_offset = frequency - self.ch_freq_starts[chan]
            weight_start = self.ch_weight_starts[chan]
            denom = mel_low if chan == 0 else center_mel[chan - 1]
            for j in range(num_freqs):
                w = _f32(_f32(center_mel[chan] -
                              _freq_to_mel(_f32(frequency * hz_per_sbin))) /
                         _f32(center_mel[chan] - denom))
                idx = weight_start + freq_offset + j
                self.weights[idx] = int(math.floor(
                    _f32(_f32(w * (1 << FILTERBANK_BITS)) + 0.5)))
                self.unweights[idx] = int(math.floor(
                    _f32(_f32(_f32(1.0 - w) * (1 << FILTERBANK_BITS)) + 0.5)))
                frequency += 1
            if frequency > self.end_index:
                self.end_index = frequency

        if self.end_index >= self.spectrum_size:
            raise RuntimeError("Filtre bankasi end_index spektrum boyunu asti")

    # ---- noise_reduction_util.c ----
    def _init_noise_reduction(self):
        self.nr_smoothing_bits = NR_SMOOTHING_BITS
        self.nr_even = int(NR_EVEN_SMOOTHING * (1 << NOISE_BITS))
        self.nr_odd = int(NR_ODD_SMOOTHING * (1 << NOISE_BITS))
        self.nr_min_signal = int(NR_MIN_SIGNAL_REMAINING * (1 << NOISE_BITS))

    # ---- pcan_gain_control_util.c ----
    def _pcan_gain_lookup(self, input_bits, x):
        x_as_float = _f32(x / float(1 << input_bits))
        gain = _f32(_f32(1 << PCAN_GAIN_BITS) *
                    _f32(math.pow(_f32(x_as_float + _f32(PCAN_OFFSET)),
                                  -PCAN_STRENGTH)))
        if gain > 0x7FFF:
            return 0x7FFF
        return int(_f32(gain + 0.5))

    def _init_pcan(self):
        correction_bits = _msb(self.fft_size) - 1 - (FILTERBANK_BITS // 2)
        self.pcan_snr_shift = PCAN_GAIN_BITS - correction_bits - PCAN_SNR_BITS
        input_bits = self.nr_smoothing_bits - correction_bits
        lut = [0] * (4 * WIDE_DYN_BITS - 3)
        lut[0] = self._pcan_gain_lookup(input_bits, 0)
        lut[1] = self._pcan_gain_lookup(input_bits, 1)
        # Referans kod lut isaretcisini 6 geri kaydirip 4*interval'e yaziyor;
        # duz dizide bu, base = 4*interval - 6 demek.
        for interval in range(2, WIDE_DYN_BITS + 1):
            x0 = 1 << (interval - 1)
            x1 = x0 + (x0 >> 1)
            x2 = (x0 + (x0 - 1)) if interval == WIDE_DYN_BITS else 2 * x0
            y0 = self._pcan_gain_lookup(input_bits, x0)
            y1 = self._pcan_gain_lookup(input_bits, x1)
            y2 = self._pcan_gain_lookup(input_bits, x2)
            diff1 = y1 - y0
            diff2 = y2 - y0
            a1 = 4 * diff1 - diff2
            a2 = diff2 - a1
            base = 4 * interval - 6
            lut[base] = y0
            lut[base + 1] = _i16(a1)
            lut[base + 2] = _i16(a2)
        self.pcan_lut = lut

    def _wide_dynamic_function(self, x):
        """pcan_gain_control.c WideDynamicFunction: parcali karesel LUT."""
        lut = self.pcan_lut
        if x <= 2:
            return lut[x]
        interval = _msb(x)
        base = 4 * interval - 6
        frac = ((x << (11 - interval)) if interval < 11
                else (x >> (interval - 11))) & 0x3FF
        result = (lut[base + 2] * frac) >> 5
        result += _u32(lut[base + 1] << 5)
        result *= frac
        result = (result + (1 << 14)) >> 15
        result += lut[base]
        return _i16(result)

    @staticmethod
    def _pcan_shrink(x):
        if x < (2 << PCAN_SNR_BITS):
            return _u32((x * x) >> (2 + 2 * PCAN_SNR_BITS - PCAN_OUT_BITS))
        return _u32((x >> (PCAN_SNR_BITS - PCAN_OUT_BITS)) - (1 << PCAN_OUT_BITS))

    # ---- log_scale.c ----
    @staticmethod
    def _log2_fraction_part(x, log2x):
        frac = x - (1 << log2x)
        if log2x < LOG_SCALE_LOG2:
            frac <<= LOG_SCALE_LOG2 - log2x
        else:
            frac >>= log2x - LOG_SCALE_LOG2
        base_seg = frac >> (LOG_SCALE_LOG2 - LOG_SEGMENTS_LOG2)
        seg_unit = (1 << LOG_SCALE_LOG2) >> LOG_SEGMENTS_LOG2
        c0 = LOG_LUT[base_seg]
        c1 = LOG_LUT[base_seg + 1]
        seg_base = seg_unit * base_seg
        rel_pos = ((c1 - c0) * (frac - seg_base)) >> LOG_SCALE_LOG2
        return _u32(frac + c0 + rel_pos)

    def _log(self, x, scale_shift):
        integer = _msb(x) - 1
        fraction = self._log2_fraction_part(x, integer)
        log2 = _u32((integer << LOG_SCALE_LOG2) + fraction)
        rnd = LOG_SCALE // 2
        loge = _u32((LOG_COEFF * log2 + rnd) >> LOG_SCALE_LOG2)
        return _u32(((loge << scale_shift) + rnd) >> LOG_SCALE_LOG2)

    # ---- durum ----
    def reset(self):
        self.win_input = [0] * self.window_size
        self.win_used = 0
        self.nr_estimate = [0] * NUM_CHANNELS

    # ---- frontend.c FrontendProcessSamples ----
    def _process_window(self):
        """Pencere tamponu dolu; bir kare (40 uint16) uret."""
        # window.c: pencereleme + maksimum genlik
        out = [0] * self.window_size
        max_abs = 0
        for i in range(self.window_size):
            v = _i16((self.win_input[i] * self.window_coeff[i]) >> WINDOW_BITS)
            out[i] = v
            # C'de max_abs_output_value int16'dir: -32768'in negatifi tasar ve
            # yine -32768 kalir, yani maksimumu asla guncellemez. Ayni davranis.
            a = _i16(-v) if v < 0 else v
            if a > max_abs:
                max_abs = a

        # fft.cc: girdi cozunurlugunu artirmak icin kaydirma
        input_shift = 15 - _msb(max_abs)
        fft_in = [_i16((out[i] & 0xFFFF) << input_shift)
                  for i in range(self.window_size)]
        fft_in += [0] * (self.fft_size - self.window_size)
        spectrum = self.fft.run(fft_in)

        # filterbank.c: |X|^2 -> ucgen agirlikli toplama -> karekok
        energy = [0] * self.spectrum_size
        for i in range(self.start_index, self.end_index):
            re = spectrum[i][0]
            im = spectrum[i][1]
            energy[i] = re * re + im * im

        work = [0] * (NUM_CHANNELS + 1)
        weight_acc = 0
        unweight_acc = 0
        for i in range(NUM_CHANNELS + 1):
            mag = self.ch_freq_starts[i]
            wstart = self.ch_weight_starts[i]
            for j in range(self.ch_widths[i]):
                e = energy[mag + j]
                weight_acc += self.weights[wstart + j] * e
                unweight_acc += self.unweights[wstart + j] * e
            work[i] = weight_acc
            weight_acc = unweight_acc
            unweight_acc = 0
        # FilterbankSqrt: work[1..num_channels] kullanilir (work[0] atilir)
        signal = [_u32(_sqrt64(work[i + 1]) >> input_shift)
                  for i in range(NUM_CHANNELS)]

        # noise_reduction.c
        for i in range(NUM_CHANNELS):
            smoothing = self.nr_even if (i & 1) == 0 else self.nr_odd
            one_minus = (1 << NOISE_BITS) - smoothing
            scaled_up = _u32(signal[i] << self.nr_smoothing_bits)
            estimate = _u32((scaled_up * smoothing +
                             self.nr_estimate[i] * one_minus) >> NOISE_BITS)
            self.nr_estimate[i] = estimate
            if estimate > scaled_up:
                estimate = scaled_up
            floor_v = _u32((signal[i] * self.nr_min_signal) >> NOISE_BITS)
            subtracted = _u32((scaled_up - estimate) >> self.nr_smoothing_bits)
            signal[i] = subtracted if subtracted > floor_v else floor_v

        # pcan_gain_control.c
        for i in range(NUM_CHANNELS):
            gain = _u32(self._wide_dynamic_function(self.nr_estimate[i]))
            snr = _u32((signal[i] * gain) >> self.pcan_snr_shift)
            signal[i] = self._pcan_shrink(snr)

        # log_scale.c
        frame = []
        for i in range(NUM_CHANNELS):
            value = signal[i]
            if self.correction_bits < 0:
                value >>= -self.correction_bits
            else:
                value = _u32(value << self.correction_bits)
            value = self._log(value, LOG_SCALE_SHIFT) if value > 1 else 0
            frame.append(value if value < 0xFFFF else 0xFFFF)
        return frame

    def process(self, samples):
        """Ornek dizisini bastan sona isle, kare listesi dondur."""
        frames = []
        pos = 0
        n = len(samples)
        while True:
            take = min(self.window_size - self.win_used, n - pos)
            self.win_input[self.win_used:self.win_used + take] = \
                samples[pos:pos + take]
            self.win_used += take
            pos += take
            if self.win_used < self.window_size:
                break
            frames.append(self._process_window())
            # window.c: tamponu adim kadar kaydir
            self.win_input = (self.win_input[self.window_step:] +
                              [0] * self.window_step)
            self.win_used -= self.window_step
        return frames


# =====================================================================
#  OZELLIK -> uint8 (micro_features_generator.cc)
# =====================================================================
def frames_to_bytes(frames):
    """Kare listesi -> hizlandiriciya giden uint8 dizisi (offset-binary).

    q = clamp((v*256 + 333) / 666 - 128, -128, 127)   [int8]
    bayt = q + 128                                    [uint8]
    """
    value_scale = 256
    value_div = int(25.6 * 26.0 + 0.5)      # 666
    out = bytearray()
    for frame in frames:
        for v in frame:
            q = (v * value_scale + value_div // 2) // value_div - 128
            q = -128 if q < -128 else (127 if q > 127 else q)
            out.append(q + 128)
    return bytes(out)


def wav_to_features(samples):
    """16 kHz mono int16 (16000 ornek) -> 1960 baytlik ozellik haritasi."""
    frames = MicroFrontend().process(samples)
    if len(frames) < NUM_SLICES:
        raise RuntimeError(f"Sadece {len(frames)} kare uretildi, "
                           f"{NUM_SLICES} gerekli (ses cok mu kisa?)")
    data = frames_to_bytes(frames[:NUM_SLICES])
    assert len(data) == FEATURE_LEN
    return data


# =====================================================================
#  WAV OKUMA / HAZIRLAMA
# =====================================================================
def read_wav(path):
    """WAV -> (mono int16 ornek listesi, ornekleme frekansi)."""
    try:
        with wave.open(str(path), "rb") as w:
            ch = w.getnchannels()
            width = w.getsampwidth()
            rate = w.getframerate()
            raw = w.readframes(w.getnframes())
    except wave.Error as e:
        sys.exit(f"HATA: {path} okunamadi ({e}).\n"
                 f"  Sikistirilmis/float WAV olabilir. Once cevir:\n"
                 f"    ffmpeg -i {path} -ac 1 -ar 16000 -sample_fmt s16 "
                 f"-t 1 cikis.wav")
    except OSError as e:
        sys.exit(f"HATA: {path} acilamadi ({e}).")

    n = len(raw) // width
    if width == 1:                       # unsigned 8-bit
        vals = [(b - 128) * 256 for b in raw]
    elif width == 2:                     # signed 16-bit little-endian
        vals = list(struct.unpack("<%dh" % n, raw[:n * 2]))
    elif width == 3:                     # signed 24-bit -> 16-bit
        vals = [int.from_bytes(raw[3 * i:3 * i + 3], "little", signed=True) >> 8
                for i in range(n)]
    elif width == 4:                     # signed 32-bit -> 16-bit
        vals = [v >> 16 for v in struct.unpack("<%di" % n, raw[:n * 4])]
    else:
        sys.exit(f"HATA: {width * 8} bitlik WAV desteklenmiyor.")

    if ch > 1:                           # kanallari ortala (mono'ya indir)
        vals = [sum(vals[i:i + ch]) // ch for i in range(0, len(vals) - ch + 1, ch)]
    return vals, rate


def resample(samples, src_rate, dst_rate=SAMPLE_RATE):
    """Dogrusal interpolasyonla yeniden orneklemi. Kaba ama 1 s konusma
    icin yeterli; en iyisi kaydi zaten 16 kHz almaktir."""
    if src_rate == dst_rate:
        return samples
    n_out = int(len(samples) * dst_rate / src_rate)
    ratio = src_rate / dst_rate
    out = []
    last = len(samples) - 1
    for i in range(n_out):
        p = i * ratio
        j = int(p)
        frac = p - j
        a = samples[j]
        b = samples[j + 1] if j < last else a
        out.append(int(a + (b - a) * frac))
    return out


def clamp16(samples):
    return [-32768 if v < -32768 else (32767 if v > 32767 else v)
            for v in samples]


def pick_window(samples, offset_s, auto_align, verbose=True):
    """1 saniyelik (16000 ornek) pencereyi sec / sifirla doldur."""
    need = SAMPLE_RATE
    if auto_align and len(samples) > need:
        # 10 ms adimlarla en yuksek enerjili 1 s penceresini bul
        step = SAMPLE_RATE // 100
        best, best_e = 0, -1
        for start in range(0, len(samples) - need + 1, step):
            e = sum(v * v for v in samples[start:start + need:4])
            if e > best_e:
                best_e, best = e, start
        if verbose:
            print(f"  --auto-align: en yuksek enerjili pencere "
                  f"{best / SAMPLE_RATE:.2f} s'den basliyor")
        return samples[best:best + need]

    start = int(offset_s * SAMPLE_RATE)
    if start < 0:
        start = 0
    chunk = samples[start:start + need]
    if len(chunk) < need:
        if verbose and len(chunk) < need:
            print(f"  uyari: kayit {len(chunk) / SAMPLE_RATE:.2f} s, "
                  f"sonuna sifir eklenerek 1 s'ye tamamlandi")
        chunk = chunk + [0] * (need - len(chunk))
    elif verbose and len(samples) > start + need:
        print(f"  uyari: kayit 1 s'den uzun, "
              f"{start / SAMPLE_RATE:.2f}-{(start + need) / SAMPLE_RATE:.2f} s "
              f"araligi kullanildi (--offset / --auto-align)")
    return chunk


def apply_gain(samples, gain_db):
    if not gain_db:
        return samples
    factor = 10.0 ** (gain_db / 20.0)
    return clamp16([int(round(v * factor)) for v in samples])


# =====================================================================
#  CIKTI
# =====================================================================
def write_hex(path, data):
    """send_data.py'nin bekledigi bicim: satir basina bir bayt, buyuk harf."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("".join(f"{b:02X}\n" for b in data))


def print_preview(data):
    """49x40 ozellik haritasini kabaca ASCII olarak bas (satir = kare)."""
    ramp = " .:-=+*#%@"
    print("  onizleme (satir = 20 ms'lik kare, sutun = mel kanali 0..39):")
    for t in range(NUM_SLICES):
        row = data[t * NUM_CHANNELS:(t + 1) * NUM_CHANNELS]
        line = "".join(ramp[min(len(ramp) - 1, b * len(ramp) // 256)]
                       for b in row)
        print(f"  {t:2d} |{line}|")


def summarize(data):
    nz = sum(1 for b in data if b)
    return (f"min={min(data)} max={max(data)} "
            f"ort={sum(data) / len(data):.1f} sifir-disi={nz}/{len(data)}")


# =====================================================================
#  CLI
# =====================================================================
HERE = Path(__file__).resolve().parent          # main_files/scripts
OUT_DIR = HERE / "sound_outputs"                # uretilen hex'ler buraya


def convert(wav_path, args):
    print(f"{wav_path}:")
    samples, rate = read_wav(wav_path)
    if not samples:
        sys.exit(f"HATA: {wav_path} bos.")
    print(f"  girdi: {rate} Hz, {len(samples) / rate:.2f} s")
    if rate != SAMPLE_RATE:
        print(f"  uyari: {rate} Hz -> {SAMPLE_RATE} Hz'e dogrusal "
              f"interpolasyon (kaydi 16 kHz almak daha iyi)")
        samples = resample(samples, rate)
    samples = apply_gain(samples, args.gain)
    samples = clamp16(pick_window(samples, args.offset, args.auto_align))

    data = wav_to_features(samples)

    out = Path(args.output) if args.output else OUT_DIR / f"{wav_path.stem}.hex"
    write_hex(out, data)
    print(f"  cikti: {out}  ({len(data)} bayt, {summarize(data)})")
    if all(b == 0 for b in data):
        print("  uyari: butun ozellikler 0 — kayit sessiz "
              "(veya cok kisik; --gain deneyin)")
    if args.preview:
        print_preview(data)
    return out


def main():
    ap = argparse.ArgumentParser(
        description="1 saniyelik WAV kaydini YZ hizlandirici girdi hex'ine "
                    "(49x40 = 1960 bayt) cevirir.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="ornek:\n"
               "  python3 scripts/wav_to_yz.py kayitlar/evet.wav\n"
               "  cd firmware && python3 scripts/send_data.py audio "
               "../scripts/sound_outputs/evet.hex\n")
    ap.add_argument("wav", nargs="+", type=Path, help="girdi WAV dosyalari")
    ap.add_argument("-o", "--output",
                    help="cikti hex yolu (tek girdi icin; verilmezse "
                         "scripts/sound_outputs/<wav-adi>.hex)")
    ap.add_argument("--offset", type=float, default=0.0, metavar="SN",
                    help="1 s'lik pencerenin baslangici [saniye] (varsayilan 0)")
    ap.add_argument("--auto-align", action="store_true",
                    help="1 s'den uzun kayitta en yuksek enerjili pencereyi sec")
    ap.add_argument("--gain", type=float, default=0.0, metavar="dB",
                    help="donusumden once uygulanacak kazanc [dB]")
    ap.add_argument("--preview", action="store_true",
                    help="ozellik haritasini ASCII spektrogram olarak bas")
    args = ap.parse_args()

    if args.output and len(args.wav) > 1:
        sys.exit("HATA: -o sadece tek girdi dosyasiyla kullanilabilir.")
    for path in args.wav:
        if not path.is_file():
            sys.exit(f"HATA: {path} yok.")
        convert(path, args)


if __name__ == "__main__":
    main()
