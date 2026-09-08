#!/usr/bin/env python3
"""
cmp_trace.py — CV32E40P RTL trace'i ile Spike commit log'unu karşılaştırır.

Kullanım:
    python3 cmp_trace.py trace_core.log build/spike.log
    python3 cmp_trace.py trace_core.log build/spike.log --max-errors 20

Çıkış kodu: 0 = eşleşti, 1 = mismatch veya parse hatası
"""

import re
import sys
import argparse

# ---------------------------------------------------------------- regex'ler

# Spike --log-commits:
#   core   0: 3 0x10000000 (0x10002117) x2  0x20002000
SPIKE_INSN = re.compile(
    r'core\s+\d+:\s+(?:\d+\s+)?0x([0-9a-fA-F]+)\s+\(\s*0x([0-9a-fA-F]+)\s*\)(.*)')
SPIKE_REG = re.compile(r'\bx\s*(\d+)\s+0x([0-9a-fA-F]+)')

# CV32E40P tracer (v1.8.2 gercek cikti; "Ctx" kolonu bos gelebilir):
#       300.000 ns    5 10000000 10002117    auipc  x2, 0x10002000  x2=20002000
RTL_INSN = re.compile(
    r'^\s*[\d.]+\s*ns\s+\d+\s+([0-9a-fA-F]{8})\s+([0-9a-fA-F]{4,8})\s*(.*)$')
# '=' yazma, ':' okuma → sadece yazmaları alıyoruz.
# DIKKAT: tracer degerleri '0x' ONEKI OLMADAN basar (instr_trace.svh: "%s=%08x"),
# spike ise onekli basar. Oneki istege bagli tutup iki bicimi de kabul ediyoruz.
RTL_REG = re.compile(r'\bx(\d+)=(?:0x)?([0-9a-fA-F]+)')


def parse(path, insn_re, reg_re):
    """Log dosyasını (pc, encoding, {reg: deger}, satir_no) listesine çevirir."""
    out = []
    with open(path, encoding='utf-8', errors='replace') as f:
        for lineno, line in enumerate(f, 1):
            m = insn_re.match(line)
            if not m:
                continue                      # başlık, sembol işareti, boş satır
            pc   = int(m.group(1), 16)
            insn = int(m.group(2), 16)
            # x0 hardwired sıfır — yazma denemesi yok sayılır ama loglarda
            # görünme biçimi araçtan araca değişir. Sahte hata üretmesin.
            regs = {int(r): int(v, 16)
                    for r, v in reg_re.findall(m.group(3))
                    if int(r) != 0}
            out.append((pc, insn, regs, lineno))
    return out


def align(rtl, spike):
    """RTL'in baştaki reset artıklarını atlayıp iki listeyi hizalar.

    İki kademeli: önce (PC + kodlama) tam eşleşmesi aranır — aynı PC'ye
    birden fazla uğranabileceği için bu daha güvenli. Bulunamazsa yalnızca
    PC'ye bakılır: ilk komut sıkıştırılmış (RVC) ise kodlamalar zaten
    tutmaz (bkz. is_compressed açıklaması).
    """
    if not rtl or not spike:
        return rtl, spike
    target_pc, target_insn = spike[0][0], spike[0][1]

    for i, (pc, insn, _, _) in enumerate(rtl):
        if pc == target_pc and insn == target_insn:
            if i:
                print(f"[bilgi] RTL'in ilk {i} satırı atlandı (reset artığı)")
            return rtl[i:], spike

    for i, (pc, _, _, _) in enumerate(rtl):
        if pc == target_pc:
            print(f"[bilgi] Hizalama yalnızca PC ile yapıldı "
                  f"(ilk komut sıkıştırılmış olabilir), RTL'in ilk {i} satırı atlandı")
            return rtl[i:], spike

    print("[uyari] Hizalama noktası bulunamadı, listeler baştan eşleştiriliyor")
    return rtl, spike


def is_compressed(insn):
    """RISC-V: 32-bit komutların alt iki biti daima '11'; değilse 16-bit RVC.

    Spike bellekten okunan HAM kodlamayı basar (16-bit), CV32E40P tracer'ı ise
    ID stage'e giren GENİŞLETİLMİŞ 32-bit eşdeğeri basar — tracer'ın .instr
    portu compressed_decoder'dan SONRAKİ sinyale bağlı. İkisi de doğru, ama
    kodlama kolonu bu satırlarda karşılaştırılamaz.
    """
    return (insn & 0x3) != 0x3


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('rtl_log')
    ap.add_argument('spike_log')
    ap.add_argument('--max-errors', type=int, default=10,
                    help='bu kadar hatadan sonra dur (0 = sınırsız)')
    ap.add_argument('--no-align', action='store_true',
                    help='hizalamayı atla, baştan karşılaştır')
    args = ap.parse_args()

    rtl   = parse(args.rtl_log,   RTL_INSN,   RTL_REG)
    spike = parse(args.spike_log, SPIKE_INSN, SPIKE_REG)

    if not rtl:
        print(f"HATA: {args.rtl_log} içinden hiç komut ayrıştırılamadı "
              f"— regex uymuyor olabilir")
        return 1
    if not spike:
        print(f"HATA: {args.spike_log} içinden hiç komut ayrıştırılamadı "
              f"— --log-commits verildi mi?")
        return 1

    if not args.no_align:
        rtl, spike = align(rtl, spike)

    errors = 0
    rvc_skipped = 0            # kodlaması karşılaştırılamayan RVC komut sayısı
    n = min(len(rtl), len(spike))

    for i in range(n):
        r_pc, r_insn, r_regs, r_line = rtl[i]
        s_pc, s_insn, s_regs, s_line = spike[i]

        if r_pc != s_pc:
            print(f"[{i}] PC MISMATCH     "
                  f"rtl=0x{r_pc:08x} spike=0x{s_pc:08x}   "
                  f"(rtl satır {r_line}, spike satır {s_line})")
            errors += 1
            print("      → PC ayrıştıktan sonrası anlamsız, duruyorum")
            break

        if is_compressed(s_insn):
            # Kodlama kolonu atlanır; PC ve register yazmaları yine kontrol edilir.
            rvc_skipped += 1
        elif r_insn != s_insn:
            print(f"[{i}] INSN MISMATCH   @0x{r_pc:08x}  "
                  f"rtl=0x{r_insn:08x} spike=0x{s_insn:08x}")
            errors += 1

        if r_regs != s_regs:
            print(f"[{i}] GPR MISMATCH    @0x{r_pc:08x}  "
                  f"rtl={fmt(r_regs)} spike={fmt(s_regs)}")
            errors += 1

        if args.max_errors and errors >= args.max_errors:
            print(f"... {args.max_errors} hataya ulaşıldı, duruyorum")
            break

    print(f"\nKarşılaştırılan: {n} komut | "
          f"rtl={len(rtl)} spike={len(spike)} | hata={errors}")

    if rvc_skipped:
        print(f"[bilgi] {rvc_skipped} sıkıştırılmış (RVC) komutta kodlama kolonu "
              f"karşılaştırılmadı — spike 16-bit ham, tracer 32-bit genişletilmiş "
              f"kodlama basıyor. PC ve register yazmaları bu satırlarda da kontrol edildi.")

    if len(rtl) != len(spike):
        print("[bilgi] Komut sayıları farklı — Spike --instructions limitiyle "
              "fazla koşmuş veya RTL erken durmuş olabilir. "
              "İlk n komut eşleşiyorsa sorun yok.")

    return 1 if errors else 0


def fmt(regs):
    """{5: 128} → {x5=0x00000080}"""
    return '{' + ', '.join(f'x{k}=0x{v:08x}'
                           for k, v in sorted(regs.items())) + '}'


if __name__ == '__main__':
    sys.exit(main())
