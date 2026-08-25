from dataclasses import dataclass, field
from datetime import datetime
from typing import List

@dataclass
class Operator:
    id: int
    callsign: str
    role: str
    active: bool = True

@dataclass
class Mission:
    id: int
    codename: str
    theater: str
    start_time: datetime
    status: str = "PLANNED"
    operators: List[Operator] = field(default_factory=list)

    def assign_operator(self, operator: Operator):
        self.operators.append(operator)
