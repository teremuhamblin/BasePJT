from typing import List
from .models import Mission, Operator

class MissionService:
    def __init__(self):
        self._missions: List[Mission] = []
        self._operators: List[Operator] = []

    # Operators
    def add_operator(self, operator: Operator):
        self._operators.append(operator)

    def list_operators(self):
        return self._operators

    # Missions
    def add_mission(self, mission: Mission):
        self._missions.append(mission)

    def list_missions(self):
        return self._missions

    def assign_operator_to_mission(self, mission_id: int, operator_id: int):
        mission = next((m for m in self._missions if m.id == mission_id), None)
        operator = next((o for o in self._operators if o.id == operator_id), None)

        if not mission:
            raise ValueError("Mission not found")
        if not operator:
            raise ValueError("Operator not found")

        mission.assign_operator(operator)
        return mission
