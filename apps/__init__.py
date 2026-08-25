"""
LegionOps Tracker
-----------------
Module pour le projet BasePJT.

Ce package fournit :
- Les modèles (Operator, Mission)
- Les services (MissionService)
- La CLI militaire
- Le point d'entrée principal

Auteur : Major Hamblin (Teremu)
"""

from .models import Operator, Mission
from .services import MissionService
from .cli import run_cli

__all__ = [
    "Operator",
    "Mission",
    "MissionService",
    "run_cli"
]

__version__ = "0.1.0"
