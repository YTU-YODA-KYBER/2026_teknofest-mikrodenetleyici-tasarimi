# `ant28_m3a015` — met3 kaynak cezasi %15 checkpoint kosumu

Tek degisken: `GRT_LAYER_ADJUSTMENTS` icindeki met3 degeri `0 -> 0.15`.
Checkpoint'lerle uretilen bu kosum tum signoff kontrollerini gecti ve anteni
955/1013'ten 940/990'a indirdi. Dört ayri `run_flow.py` cagrisi kullanildigi
icin teslim provenance kapisindaki iki-faz `flow.log` kosulunu karsilamaz;
bu nedenle ayni ayarla temiz `make asic_run` ayrica kosulmustur. Bu dizin
checkpoint deneyinin ham karar kanitidir.

