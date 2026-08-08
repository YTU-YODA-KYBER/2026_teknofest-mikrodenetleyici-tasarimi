# =====================================================================
#  scripts/yz_tflite  --  yazilim referansinin HOST derlemesi
#
#  Model kodu firmware/yz_model/ altindadir; burada sadece host surucusu
#  derlenir. Ayni .c dosyasi RV32'ye firmware/Makefile ile derlenir.
#
#  Hedefler:
#    make            -> ./ref_run
#    make data       -> .tflite'tan tflite_model_data.h uret + dogrula
#    make check-data -> sadece dogrula (uretme)
#    make clean
# =====================================================================

MODEL_DIR := ../../firmware/yz_model

#  -O2: baseline'in kasitli yavaslatilmadigi RV32 olcumuyle tutarli olsun.
CFLAGS := -std=c11 -O2 -Wall -Wextra -I$(MODEL_DIR)

SRCS := ref_run.c $(MODEL_DIR)/tflite_ref.c
HDRS := $(MODEL_DIR)/tflite_ref.h $(MODEL_DIR)/tflite_model_data.h

.PHONY: all data check-data clean

all: ref_run

ref_run: $(SRCS) $(HDRS)
	$(CC) $(CFLAGS) -o $@ $(SRCS)
	@echo "[OK] ./ref_run"

data:
	python3 gen_tflite_data.py

check-data:
	python3 gen_tflite_data.py --check

clean:
	rm -f ref_run
	@echo "[OK] Temizlendi"
