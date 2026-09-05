# Lint waiver'ları

**Bu teslimde lint waiver KULLANILMAMIŞTIR.** Dizin, şartname Tablo 8'de
`asic/reports/lint/waivers/` olarak listelendiği için yer tutucu olarak
bulunmaktadır.

Verilator lint adımı (`Verilator.Lint`) LibreLane varsayılan yapılandırmasıyla
koşar:

- `LINTER_ERROR_ON_LATCH` ve `LINTER_ERROR_ON_MULTIDRIVEN` **açıktır** ve açık
  bırakılmıştır.
- LibreLane'in varsayılan olarak bastırdığı uyarılar `DECLFILENAME`,
  `EOFNEWLINE` (genel) ile kara kutu makro modelleri için `UNDRIVEN` ve
  `UNUSEDSIGNAL`'dir. Bu varsayılanlar **değiştirilmemiştir**.
- Takım tarafından ek olarak **hiçbir uyarı bastırılmamış**, hiçbir waiver
  dosyası tanımlanmamıştır.

Kalan uyarıların niteliği ve neden kabul edildikleri `asic/README.md`
*Lint sonuçları ve istisnaları* bölümündedir. Tam çıktı:
[`../verilator_lint.log`](../verilator_lint.log).
