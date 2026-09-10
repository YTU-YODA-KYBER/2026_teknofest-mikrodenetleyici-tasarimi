#!/usr/bin/env python3
"""LibreLane'e teslim edilen post-route ECO adimini ve akisini kaydeder."""

import os
import pathlib

from librelane.common import TclUtils
from librelane.flows import Flow
from librelane.flows.builtins import Classic
from librelane.state import DesignFormat, State
from librelane.steps import Checker, KLayout, Magic, Misc, Netgen, Odb, OpenROAD, Yosys
from librelane.steps.openroad import OpenROADStep, RepairDesignPostGRT
from librelane.steps.step import Step


ASIC_DIR = pathlib.Path(__file__).resolve().parent.parent


@Step.factory.register()
class RepairDesignPostRoute(RepairDesignPostGRT):
    """Gercek RCX SPEF'leriyle stdcell-ag bazli slew/cap ECO'su yapar."""

    id = "OpenROAD.RepairDesignPostRoute"
    name = "Repair Design (Post-Route RCX ECO)"
    inputs = [DesignFormat.ODB, DesignFormat.SPEF]

    def get_script_path(self):
        return str(ASIC_DIR / "scripts" / "postroute_eco.tcl")

    def run(self, state_in: State, **kwargs):
        # Slew/cap icin dokuz signoff kosede daima max-RC ailesi kotudur.
        # Her kutuphane PVT'sini kendi max-RC SPEF'iyle birlikte yukleyerek
        # uc gercek worst-case'i tek onarim oturumunda hedefle.
        corners = [
            corner for corner in self.config["STA_CORNERS"]
            if str(corner).startswith("max_")
        ]
        if not corners:
            raise ValueError("STA_CORNERS icinde max_* post-route ECO kosesi yok")
        return OpenROADStep.run(self, state_in, corners=corners, **kwargs)

    def prepare_env(self, env: dict, state: State) -> dict:
        env = super().prepare_env(env, state)
        spefs = state.get(DesignFormat.SPEF)
        if not isinstance(spefs, dict) or not spefs:
            raise ValueError("Post-route ECO icin RCX SPEF eslemesi gerekli")
        env["POSTROUTE_SPEF_COUNT"] = str(len(spefs))
        for index, (corner_pattern, path) in enumerate(spefs.items()):
            env[f"POSTROUTE_SPEF_{index}"] = TclUtils.join(
                [corner_pattern, os.fspath(path)]
            )
        return env


@Flow.factory.register()
class ClassicPostRouteECO(Classic):
    """Classic signoff'tan sonra RCX tabanli ECO ve signoff'u yeniden kosar."""

    name = "Classic + Post-Route ECO"

    _classic_tail = [
        OpenROAD.GlobalRouting,
        OpenROAD.CheckAntennas,
        OpenROAD.RepairAntennas,
        OpenROAD.DetailedRouting,
        Odb.RemoveRoutingObstructions,
        OpenROAD.CheckAntennas,
        Checker.TrDRC,
        Odb.ReportDisconnectedPins,
        Checker.DisconnectedPins,
        Odb.ReportWireLength,
        Checker.WireLength,
        OpenROAD.FillInsertion,
        Odb.CellFrequencyTables,
        OpenROAD.RCX,
        OpenROAD.STAPostPNR,
        OpenROAD.IRDropReport,
        Magic.StreamOut,
        KLayout.StreamOut,
        KLayout.Render,
        Magic.WriteLEF,
        Odb.CheckDesignAntennaProperties,
        KLayout.XOR,
        Checker.XOR,
        Magic.DRC,
        KLayout.DRC,
        Checker.MagicDRC,
        Checker.KLayoutDRC,
        Magic.SpiceExtraction,
        Checker.IllegalOverlap,
        Netgen.LVS,
        Checker.LVS,
        Yosys.EQY,
        Checker.SetupViolations,
        Checker.HoldViolations,
        Checker.MaxSlewViolations,
        Checker.MaxCapViolations,
        Misc.ReportManufacturability,
    ]

    Steps = Classic.Steps + [RepairDesignPostRoute] + _classic_tail
