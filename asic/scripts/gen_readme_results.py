#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_readme_results.py -- README.md'deki "Signoff sonuc ozeti" bolumunu
#  akisin URETTIGI metriklerden doldurur.
#
#  Sayilar elle yazilmaz: kaynak results/metrics/metrics.json'dur. Boylece
#  belgede yazan ile teslim edilen raporlar arasinda celiski olusamaz
#  (sartname Bolum 7 ve 9.13).
# ---------------------------------------------------------------------------
import json
import pathlib
import re
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent
BEGIN = "<!-- SONUC-OZETI-BASI -->"
END = "<!-- SONUC-OZETI-SONU -->"

# Corner listesi ELLE yazilmaz: metrics.json'daki "...__corner:<ad>" anahtar-
# larindan turetilir. DEDUPLICATE_CORNERS=false oldugu icin akis 9 corner
# uretir (nom/min/max x tt/ss/ff); sabit bir liste bunlarin bir kismini
# sessizce gizlerdi.
_CORNER_PRE = "timing__setup__ws__corner:"
_RC_ORDER = {"nom": 0, "min": 1, "max": 2}
_PV_ORDER = {"tt": 0, "ss": 1, "ff": 2}


def corners_of(m):
    """metrics.json'da gercekten bulunan corner adlari, okunakli sirada."""
    cs = [k[len(_CORNER_PRE):] for k in m if k.startswith(_CORNER_PRE)]

    def key(c):
        parts = c.split("_")
        rc = _RC_ORDER.get(parts[0], 9) if parts else 9
        pv = _PV_ORDER.get(parts[1], 9) if len(parts) > 1 else 9
        return (rc, pv, c)

    return sorted(set(cs), key=key)


def worst(m, base, cs):
    """Corner'lar arasi en kotu deger (WNS ve TNS icin ikisi de minimumdur)."""
    v = [m[f"{base}__corner:{c}"] for c in cs
         if m.get(f"{base}__corner:{c}") is not None]
    return min(v) if v else "—"


def tr_num(v, digits=0):
    """Turkce sayi bicimi: binlik ayiraci nokta, ondalik ayiraci virgul."""
    s = f"{v:,.{digits}f}"
    return s.replace(",", "\x00").replace(".", ",").replace("\x00", ".")


def fmt_area(v):
    """Alanlari hem um2 hem mm2 olarak verir; ham um2 tek basina okunaksiz."""
    if v == "—" or v is None:
        return "—"
    return f"{tr_num(v)} µm² ({tr_num(v / 1e6, 3)} mm²)"


def g(m, *keys, default="—"):
    for k in keys:
        if k in m and m[k] is not None:
            return m[k]
    return default


def fmt(v, unit="", digits=3):
    if v == "—" or v is None:
        return "—"
    if isinstance(v, float):
        return f"{v:.{digits}f}{unit}".replace(".", ",")
    return f"{v}{unit}"


def power_of(corner):
    """OpenSTA power.rpt icindeki Total satirini oku.

    LibreLane 3.0.6 dokuz corner icin ayri rapor yazar, fakat final
    metrics.json'a yalniz corner suffix'i olmayan son guc degerini tasir.
    Bu nedenle dokuzlu tabloyu kaynak raporlardan uretmek gerekir.
    """
    p = ASIC / "reports" / "power" / corner / "power.rpt"
    if not p.is_file():
        sys.exit(f"HATA: corner guc raporu yok: {p}")
    for line in p.read_text(errors="replace").splitlines():
        if line.lstrip().startswith("Total"):
            nums = re.findall(r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?", line)
            if len(nums) >= 4:
                return tuple(float(x) for x in nums[:4])
    sys.exit(f"HATA: power.rpt Total satiri okunamadi: {p}")


def main():
    mj = ASIC / "results" / "metrics" / "metrics.json"
    if not mj.is_file():
        sys.exit(f"HATA: {mj} yok -- once akisi calistirip collect.py ile toplayin")
    m = json.load(open(mj))

    L = []
    A = L.append
    A(BEGIN)
    A("## Signoff sonuç özeti")
    A("")
    A("Aşağıdaki sayılar akışın ürettiği")
    A("[`results/metrics/metrics.json`](results/metrics/metrics.json) ile corner bazlı")
    A("[`reports/power/`](reports/power/) raporlarından")
    A("`scripts/gen_readme_results.py` ile doldurulur; elle yazılmaz.")
    A("")
    A("### Alan ve kaynak kullanımı")
    A("")
    A("| Ölçüm | Değer |")
    A("|---|---|")
    A(f"| Die alanı | {fmt_area(g(m,'design__die__area'))} |")
    A(f"| Core alanı | {fmt_area(g(m,'design__core__area'))} |")
    # DIKKAT: design__instance__area MAKROLARI DA icerir (bu tasarimda 15 SRAM
    # = 4,17 mm²). Standart hucre alani icin ayri anahtar kullanilir; ikisini
    # karistirmak alani ~5 kat buyuk gosterirdi.
    A(f"| Standart hücre alanı | {fmt_area(g(m,'design__instance__area__stdcell'))} |")
    A(f"| Makro alanı (15 SRAM) | {fmt_area(g(m,'design__instance__area__macros'))} |")
    A(f"| Toplam yerleşim alanı (hücre + makro) | {fmt_area(g(m,'design__instance__area'))} |")
    A(f"| Core utilization | {fmt(g(m,'design__instance__utilization'),'',4)} |")
    ic = g(m, "design__instance__count")
    A(f"| Toplam hücre sayısı | {tr_num(ic) if ic != '—' else '—'} |")
    A(f"| SRAM makrosu sayısı | {fmt(g(m,'design__instance__count__class:macro', default=15))} |")
    # route__wirelength detayli yollamadan gelir; o adim yoksa GRT tahmini.
    wl = g(m, "route__wirelength", "route__wirelength__estimated")
    if wl != "—":
        A(f"| Toplam kablo uzunluğu | {tr_num(wl)} µm ({tr_num(wl / 1e6, 2)} m) |")
    A("")
    A("### Zamanlama (nihai post-PnR STA, parazitik çıkarım sonrası)")
    A("")
    A("| Corner | Setup WNS | Setup TNS | Hold WNS | Hold TNS |")
    A("|---|---|---|---|---|")
    cs = corners_of(m)
    for c in cs:
        A(f"| `{c}` | {fmt(g(m,f'timing__setup__ws__corner:{c}'),' ns')} "
          f"| {fmt(g(m,f'timing__setup__tns__corner:{c}'),' ns')} "
          f"| {fmt(g(m,f'timing__hold__ws__corner:{c}'),' ns')} "
          f"| {fmt(g(m,f'timing__hold__tns__corner:{c}'),' ns')} |")
    # Ozet satiri corner'lardan HESAPLANIR; akis "corner'siz" bir toplam
    # metrik yazmadigi icin hazir bir anahtar aramak bos satir uretiyordu.
    A(f"| **Tüm corner'lar (en kötü)** | {fmt(worst(m,'timing__setup__ws',cs),' ns')} "
      f"| {fmt(worst(m,'timing__setup__tns',cs),' ns')} "
      f"| {fmt(worst(m,'timing__hold__ws',cs),' ns')} "
      f"| {fmt(worst(m,'timing__hold__tns',cs),' ns')} |")
    A("")
    A("### Fiziksel signoff")
    A("")
    A("| Kontrol | İhlal sayısı |")
    A("|---|---|")
    for key, label in [
        ("magic__drc_error__count",         "Magic DRC"),
        ("klayout__drc_error__count",       "KLayout DRC"),
        ("design__lvs_error__count",        "Netgen LVS"),
        ("design__lvs_device_difference__count", "LVS cihaz sayısı farkı"),
        ("design__lvs_net_difference__count",  "LVS net sayısı farkı"),
        ("antenna__violating__nets",       "Anten ihlali (net)"),
        ("antenna__violating__pins",       "Anten ihlali (pin)"),
        ("route__drc_errors",               "Yollama DRC"),
        ("design__disconnected_pin__count", "Bağlantısız pin"),
        ("design__critical_disconnected_pin__count", "Kritik bağlantısız pin"),
        ("design__xor_difference__count",   "GDSII XOR farkı (Magic ↔ KLayout)"),
        ("timing__setup_vio__count", "Setup ihlali olan uç"),
        ("timing__hold_vio__count",         "Hold ihlali olan uç"),
        ("design__max_slew_violation__count", "Max slew ihlali"),
        ("design__max_cap_violation__count", "Max cap ihlali"),
        ("magic__illegal_overlap__count",   "Geçersiz örtüşme (illegal overlap)"),
        ("design__power_grid_violation__count", "Güç dağıtım ağı ihlali"),
        ("design__inferred_latch__count",   "Çıkarılan latch"),
        ("design__lint_error__count",       "Lint hatası"),
        ("design__lint_warning__count",     "Lint uyarısı"),
        ("synthesis__check_error__count",   "Sentez yapısal kontrol hatası"),
    ]:
        if key in m:
            A(f"| {label} | **{m[key]}** |")
    A("")
    A("### Güç (tahminî — açık switching activity girdisi kullanılmadı)")
    A("")
    A("| Corner | Internal | Switching | Leakage | Toplam |")
    A("|---|---|---|---|---|")
    for c in cs:
        internal, switching, leakage, total = power_of(c)
        A(f"| `{c}` | {fmt(internal,' W',5)} "
          f"| {fmt(switching,' W',5)} "
          f"| {fmt(leakage,' W',8)} "
          f"| {fmt(total,' W',5)} |")
    # ir__voltage__worst = en kotu dugum GERILIMI, ir__drop__worst = o dugumdeki
    # DUSUS. Ikisi farkli metriktir; tek satirda birlestirmek yanlis olurdu.
    irv = g(m, "ir__voltage__worst")
    ird = g(m, "ir__drop__worst")
    ira = g(m, "ir__drop__avg")
    if irv != "—" or ird != "—":
        A("")
        A("### IR-drop (statik güç dağıtım ağı analizi)")
        A("")
        A("| Ölçüm | Değer |")
        A("|---|---|")
        if irv != "—":
            A(f"| En kötü düğüm gerilimi | {fmt(irv,' V',4)} |")
        if ird != "—":
            A(f"| En kötü gerilim düşüşü | {fmt(ird,' V',4)} |")
        if ira != "—":
            A(f"| Ortalama gerilim düşüşü | {fmt(ira,' V',4)} |")
    A("")
    A(END)

    rd = ASIC / "README.md"
    t = rd.read_text()
    if BEGIN not in t or END not in t:
        sys.exit("HATA: README.md icinde sonuc ozeti isaretleri bulunamadi")
    new = t.split(BEGIN)[0] + "\n".join(L) + t.split(END, 1)[1]
    rd.write_text(new)
    print(f"README.md signoff ozeti guncellendi ({len(L)} satir)")


if __name__ == "__main__":
    main()
