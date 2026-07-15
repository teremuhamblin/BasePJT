#!/bin/bash
# ==========================================================
# BasePJT — Pytest ULTIMATE Launcher (MIL-PRO)
# Script militaire avancé pour exécuter TOUS les tests
# Compatible Termux / Linux — Sans dépendances externes
# ==========================================================

set -e

# --- Couleurs ---
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

# --- Bannière ---
echo -e "${BLUE}"
echo "==============================================="
echo "        🔵 BasePJT — Test Suite ULTIMATE"
echo "==============================================="
echo -e "${NC}"

# --- Vérification Python ---
if ! command -v python3 >/dev/null 2>&1; then
    echo -e "${RED}[ERREUR] Python3 introuvable.${NC}"
    exit 1
fi

# --- Vérification pytest ---
if ! command -v pytest >/dev/null 2>&1; then
    echo -e "${RED}[ERREUR] pytest n'est pas installé.${NC}"
    echo "Installe-le : pip install pytest"
    exit 1
fi

# --- Modes spéciaux ---
MODE="$1"

case "$MODE" in
    debug)
        echo -e "${YELLOW}[MODE] DEBUG activé${NC}"
        PYTEST_OPTS="-vv --color=yes --disable-warnings --maxfail=1 -s"
        ;;
    cov|coverage)
        echo -e "${YELLOW}[MODE] COVERAGE activé${NC}"
        PYTEST_OPTS="-vv --color=yes --disable-warnings --maxfail=1 --cov=."
        ;;
    clean)
        echo -e "${YELLOW}[MODE] Nettoyage des fichiers de tests${NC}"
        find . -type d -name "__pycache__" -exec rm -rf {} +
        find . -type f -name "*.pyc" -delete
        echo -e "${GREEN}[OK] Nettoyage terminé.${NC}"
        exit 0
        ;;
    *)
        PYTEST_OPTS="-vv --color=yes --disable-warnings --maxfail=1 --durations=10"
        ;;
esac

# --- Scan automatique des dossiers contenant des tests ---
echo -e "${BLUE}[SCAN] Recherche des dossiers de tests...${NC}"

TARGETS=$(find . -type d \( -name "tests" -o -name "test" -o -name "src" -o -name "config" \))

if [ -z "$TARGETS" ]; then
    echo -e "${RED}[ERREUR] Aucun dossier de tests trouvé.${NC}"
    exit 1
fi

echo -e "${GREEN}[OK] Dossiers détectés :${NC}"
echo "$TARGETS"
echo "---------------------------------------"

# --- Timer ---
START=$(date +%s)

# --- Exécution ---
echo -e "${YELLOW}[INFO] Options Pytest :${NC} $PYTEST_OPTS"
echo -e "${YELLOW}[INFO] Cibles :${NC}"
echo "$TARGETS"
echo "---------------------------------------"

pytest $PYTEST_OPTS $TARGETS

END=$(date +%s)
DURATION=$((END - START))

echo -e "${GREEN}"
echo "==============================================="
echo "   ✅ Full Test Suite terminée en ${DURATION}s"
echo "==============================================="
echo -e "${NC}"
