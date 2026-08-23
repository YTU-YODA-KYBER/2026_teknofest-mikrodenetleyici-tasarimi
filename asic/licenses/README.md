# Lisans metinleri

ASIC akışında kullanılan üçüncü taraf bileşenlerin lisans metinleri.
Hangi bileşenin hangi lisans altında olduğu `asic/THIRD_PARTY.md` içindedir.

| Dosya | Kapsadığı bileşenler |
|---|---|
| `SHL-0.51.txt` | CV32E40P çekirdeği, pulp-platform `common_cells`, OBI↔AXI köprüsü (`obi_to_axi`, `obi_pkg`, `axi_pkg`) |
| `Apache-2.0.txt` | SKY130 PDK (`sky130A`, `sky130_fd_sc_hd`), SKY130 SRAM makroları (OpenRAM), LibreLane, ciel |
| `MIT-YODA-KYBER.txt` | Takımın kendi kodu (çevre birimleri, ara bağlantı, YZ hızlandırıcı, ASIC bellek sarmalayıcıları, otomasyon betikleri) — depo kökündeki `LICENSE` dosyasının kopyası |

Depoya kopyalanan üçüncü taraf dosyalardaki mevcut lisans ve telif bildirimleri
kaynak dosyaların içinde korunmuştur.
