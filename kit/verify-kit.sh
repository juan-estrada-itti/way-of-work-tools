#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
# verify-kit.sh · test de 5 min post-install
#
# Verifica que el kit quedó bien instalado:
#   · Claude Code funcional
#   · 10 skills presentes con SKILL.md válido
#   · Imprime OK o FAIL por cada check
#
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/ittidigital/way-of-work-tools/main/kit/verify-kit.sh | bash
# ──────────────────────────────────────────────────────────────────

set -u

GLOBAL_SKILLS="$HOME/.claude/skills"
REQUIRED_SKILLS=(office-hours create-prd rfc-builder rfc-to-adr story-to-plan contract-define user-story-builder task-dependency-analyzer code-review sdd-router)

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

OK=0
FAIL=0
WARN=0

check_ok()   { echo -e "  ${GREEN}✓${NC} $1"; OK=$((OK+1)); }
check_fail() { echo -e "  ${RED}✗${NC} $1"; FAIL=$((FAIL+1)); }
check_warn() { echo -e "  ${YELLOW}⚠${NC}  $1"; WARN=$((WARN+1)); }

echo "════════════════════════════════════════"
echo "Verify kit · 5 min test"
echo "════════════════════════════════════════"
echo ""

# 1 · Claude Code
echo "1 · Claude Code"
if command -v claude &>/dev/null; then
    VERSION=$(claude --version 2>/dev/null | head -1)
    check_ok "Claude Code instalado · $VERSION"
else
    check_fail "Claude Code no encontrado"
fi

# 2 · Directorio de skills
echo ""
echo "2 · Directorio ~/.claude/skills"
if [ -d "$GLOBAL_SKILLS" ]; then
    check_ok "Existe"
else
    check_fail "No existe · corré install-kit.sh"
fi

# 3 · Las 10 skills
echo ""
echo "3 · 10 skills del pipeline"
for skill in "${REQUIRED_SKILLS[@]}"; do
    if [ -f "$GLOBAL_SKILLS/$skill/SKILL.md" ]; then
        name=$(grep -m1 '^name:' "$GLOBAL_SKILLS/$skill/SKILL.md" 2>/dev/null | sed 's/name: *//')
        if [ -n "$name" ]; then
            check_ok "$skill (name: $name)"
        else
            check_warn "$skill (SKILL.md presente pero sin frontmatter name)"
        fi
    else
        check_fail "$skill · SKILL.md no encontrado"
    fi
done

# 4 · Symlinks vs copias
echo ""
echo "4 · Symlinks a repos clonados"
BROKEN_LINKS=0
for skill in "${REQUIRED_SKILLS[@]}"; do
    if [ -L "$GLOBAL_SKILLS/$skill" ]; then
        target=$(readlink "$GLOBAL_SKILLS/$skill")
        if [ ! -e "$GLOBAL_SKILLS/$skill" ]; then
            check_fail "$skill · symlink roto → $target"
            BROKEN_LINKS=$((BROKEN_LINKS+1))
        fi
    fi
done
[ $BROKEN_LINKS -eq 0 ] && check_ok "Todos los symlinks resolvibles"

# 5 · Skills propias del equipo · verifica que existen
echo ""
echo "5 · Skills propias del equipo (/.way-of-work-kit/)"
WORK_DIR="$HOME/.way-of-work-kit"
if [ -d "$WORK_DIR/way-of-work-tools" ]; then
    check_ok "Repo way-of-work-tools clonado"
else
    check_warn "$WORK_DIR/way-of-work-tools no existe · correr install-kit.sh"
fi

# ─── Resumen ───────────────────────────────────────────
echo ""
echo "════════════════════════════════════════"
echo "Resumen"
echo "════════════════════════════════════════"
echo -e "  ${GREEN}OK${NC}:   $OK"
echo -e "  ${YELLOW}WARN${NC}: $WARN"
echo -e "  ${RED}FAIL${NC}: $FAIL"
echo ""

if [ $FAIL -eq 0 ] && [ $WARN -le 1 ]; then
    echo -e "${GREEN}══════════════════════════════════════${NC}"
    echo -e "${GREEN}  ✓ Test pasado · estás listo para el viernes${NC}"
    echo -e "${GREEN}══════════════════════════════════════${NC}"
    exit 0
elif [ $FAIL -eq 0 ]; then
    echo -e "${YELLOW}══════════════════════════════════════${NC}"
    echo -e "${YELLOW}  ⚠  Test con warnings · revisá arriba${NC}"
    echo -e "${YELLOW}══════════════════════════════════════${NC}"
    exit 0
else
    echo -e "${RED}══════════════════════════════════════${NC}"
    echo -e "${RED}  ✗ Test falló · pedí ayuda en #way-of-work${NC}"
    echo -e "${RED}    O corré:  bash install-kit.sh${NC}"
    echo -e "${RED}══════════════════════════════════════${NC}"
    exit 1
fi
