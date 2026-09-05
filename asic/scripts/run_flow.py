#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  run_flow.py -- LibreLane Classic akisini asic/run/ altinda calistirir
#
#  NEDEN AYRI BIR SURUCU BETIGI?
#    `librelane` komut satiri araci calisma dizinini her zaman
#    <design-dir>/runs/<tag> olarak secer; sartname (Bolum 4) ise gecici
#    calisma alaninin asic/run/ olmasini istiyor. Bu betik LibreLane'in
#    KENDI genel Python API'sini kullanarak ayni Classic akisini calistirir,
#    yalnizca calisma dizinini asic/run/<tag> olarak sabitler.
#
#    Akis, adimlar ve yapilandirma DEGISTIRILMEZ: kullanilan akis
#    Flow.factory.get("Classic")'tir; ozel akis veya ozel adim YOKTUR.
#
#  Kullanim:
#     python3 scripts/run_flow.py                      # tam akis
#     python3 scripts/run_flow.py --to Yosys.Synthesis # belirli adima kadar
#     python3 scripts/run_flow.py --tag deneme --overwrite
# ---------------------------------------------------------------------------
import argparse
import os
import pathlib
import subprocess
import sys

ASIC_DIR = pathlib.Path(__file__).resolve().parent.parent


def main() -> int:
    ap = argparse.ArgumentParser(description="LibreLane Classic akisi (asic/run altinda)")
    ap.add_argument("--config", action="append", default=None,
                    help="yapilandirma dosyasi; birden cok kez verilirse sirayla bindirilir")
    ap.add_argument("--tag", default="rtl2gds", help="calisma etiketi -> asic/run/<tag>")
    ap.add_argument("--from", dest="frm", default=None, help="baslangic adimi (or. OpenROAD.Floorplan)")
    ap.add_argument("--to", default=None, help="bitis adimi (or. Yosys.Synthesis)")
    ap.add_argument("--only", default=None, help="tek adim")
    ap.add_argument("--initial-state", default=None,
                    help="deney/devam icin baslangic state_out.json dosyasi")
    ap.add_argument("--overwrite", action="store_true", help="varsa uzerine yaz")
    ap.add_argument("--last-run", action="store_true", dest="last_run")
    args = ap.parse_args()

    # run_flow.py dogrudan cagrilsa bile bayat yamali kopyalarin senteze
    # girmesine izin verme. `make asic_run` bunlari zaten prepare ile uretir.
    subprocess.run(
        [sys.executable, str(ASIC_DIR / "scripts" / "patch_rtl.py"), "--check"],
        cwd=ASIC_DIR,
        check=True,
    )

    from librelane.flows import Flow
    from librelane.logging import set_log_level
    from librelane.state import State

    set_log_level("VERBOSE")

    frm, to = args.frm, args.to
    if args.only:
        frm = to = args.only

    configs = args.config or [str(ASIC_DIR / "config.yaml")]

    ClassicFlow = Flow.factory.get("Classic")
    flow = ClassicFlow(
        configs,
        design_dir=str(ASIC_DIR),
        pdk_root=os.environ.get("PDK_ROOT"),
    )

    # Varsayilan calisma alani asic/run/ (goreli). ASIC_RUN_ROOT yalnizca
    # yerel bir yonlendirme kolayligidir; depoda mutlak yol tutulmaz.
    run_root = pathlib.Path(os.environ.get("ASIC_RUN_ROOT") or (ASIC_DIR / "run"))
    run_dir = run_root / args.tag
    run_dir.parent.mkdir(parents=True, exist_ok=True)

    print(f"[run_flow] akis      : Classic")
    print(f"[run_flow] config    : {', '.join(configs)}")
    print(f"[run_flow] calisma   : {run_dir}")
    if frm or to:
        print(f"[run_flow] adim araligi: {frm or 'basi'} .. {to or 'sonu'}")

    initial_state = None
    if args.initial_state:
        state_path = pathlib.Path(args.initial_state).resolve()
        initial_state = State.loads(state_path.read_text())
        print(f"[run_flow] ilk durum : {state_path}")

    flow.start(
        with_initial_state=initial_state,
        tag=args.tag,
        last_run=args.last_run,
        _force_run_dir=str(run_dir),
        overwrite=args.overwrite,
        frm=frm,
        to=to,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
