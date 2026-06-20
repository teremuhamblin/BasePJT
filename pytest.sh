#!/bin/bash
# ==========================================================
# BasePJT — Pytest Full Project Launcher
# Script militaire pour exécuter TOUS les tests du projet
# ==========================================================

set -e

echo "======================================="
echo "   🔵 BasePJT — Full Test Suite"
echo "======================================="

# Vérification de pytest
if ! command -v pytest >/dev/null 2>&1; then
    echo "[ERREUR] pytest n'est pas installé."
    echo "Installe-le avec : pip install pytest"
    exit 1
fi

# Options avancées
PYTEST_OPTS="
    -vv
    --color=yes
    --disable-warnings
    --maxfail=1
    --durations=10
"

# Cibles automatiques
TARGETS="
tests
src
config
"

echo "[INFO] Options : $PYTEST_OPTS"
echo "[INFO] Cibles  : $TARGETS"
echo "---------------------------------------"

pytest $PYTEST_OPTS $TARGETS

echo "======================================="
echo "   ✅ Full Test Suite terminée"
echo "======================================="
