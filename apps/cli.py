from .services import MissionService
from .models import Mission, Operator
from datetime import datetime

service = MissionService()

def menu():
    print("\n=== LEGION OPS TRACKER ===")
    print("1. Ajouter un opérateur")
    print("2. Ajouter une mission")
    print("3. Lister les opérateurs")
    print("4. Lister les missions")
    print("5. Assigner opérateur à mission")
    print("0. Quitter")

def run_cli():
    while True:
        menu()
        choice = input("Choix: ")

        if choice == "1":
            callsign = input("Callsign: ")
            role = input("Rôle: ")
            operator = Operator(id=len(service._operators)+1, callsign=callsign, role=role)
            service.add_operator(operator)
            print("Opérateur ajouté.")

        elif choice == "2":
            codename = input("Nom de mission: ")
            theater = input("Théâtre: ")
            mission = Mission(
                id=len(service._missions)+1,
                codename=codename,
                theater=theater,
                start_time=datetime.now()
            )
            service.add_mission(mission)
            print("Mission ajoutée.")

        elif choice == "3":
            for op in service.list_operators():
                print(f"{op.id} - {op.callsign} ({op.role})")

        elif choice == "4":
            for m in service.list_missions():
                print(f"{m.id} - {m.codename} [{m.status}] - {len(m.operators)} opérateurs")

        elif choice == "5":
            mid = int(input("ID mission: "))
            oid = int(input("ID opérateur: "))
            service.assign_operator_to_mission(mid, oid)
            print("Assignation effectuée.")

        elif choice == "0":
            break

        else:
            print("Choix invalide.")
