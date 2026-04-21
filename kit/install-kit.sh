#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
# install-kit.sh · Kit Way of Work · tech emergentes · itti digital
#
# Instala 10 skills para el pipeline SDD en Claude Code:
#   · 9 skills propias del equipo (del repo way-of-work-tools, público)
#   · /office-hours de gstack (externa, pública)
#
# Seguro: no borra nada · respeta tus skills existentes ·
#         solo agrega symlinks a ~/.claude/skills/
#
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/install-kit.sh | bash
#
# O local:
#   bash install-kit.sh
# ──────────────────────────────────────────────────────────────────

set -euo pipefail

# ─── Config ───────────────────────────────────────────────────────
WORK_DIR="$HOME/.way-of-work-kit"
GLOBAL_SKILLS="$HOME/.claude/skills"
TOOLS_REPO_HTTPS="https://github.com/juan-estrada-itti/way-of-work-tools.git"
TOOLS_REPO_SSH="git@github.com:juan-estrada-itti/way-of-work-tools.git"
GSTACK_REPO="https://github.com/garrytan/gstack.git"

# Skills que se instalan desde way-of-work-tools/skills/
ALL_SKILLS=(
  rfc-to-adr
  story-to-plan
  sdd-router
  taller-participante
  facilitar-taller
  lessons-harvester
  create-prd
  rfc-builder
  contract-define
  user-story-builder
  task-dependency-analyzer
  code-review
)

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "→ $1"; }
ok()  { echo -e "  ${GREEN}✓${NC} $1"; }
warn(){ echo -e "  ${YELLOW}⚠${NC}  $1"; }
err() { echo -e "  ${RED}✗${NC} $1"; }

# ─── Pre-checks ───────────────────────────────────────────────────
log "Verificando pre-requisitos"

if ! command -v git &>/dev/null; then
    err "git no instalado · instalalo y volvé a correr"
    exit 1
fi
ok "git presente"

if ! command -v claude &>/dev/null; then
    err "Claude Code no instalado · seguí el Paso 1 de INSTALL.md"
    exit 1
fi
ok "Claude Code presente · $(claude --version 2>/dev/null | head -1)"

mkdir -p "$GLOBAL_SKILLS"
ok "Directorio $GLOBAL_SKILLS listo"

# ─── Workspace ────────────────────────────────────────────────────
log "Preparando workspace en $WORK_DIR"
mkdir -p "$WORK_DIR"

# ─── 1. Clonar way-of-work-tools (público · todas las skills) ─────
log "1/2 · Clonando way-of-work-tools"
TOOLS_DIR="$WORK_DIR/way-of-work-tools"

if [ -d "$TOOLS_DIR/.git" ]; then
    cd "$TOOLS_DIR"
    git pull --quiet 2>/dev/null || true
    ok "Actualizado"
else
    # HTTPS primero (siempre funciona porque es público)
    if git clone --quiet "$TOOLS_REPO_HTTPS" "$TOOLS_DIR" 2>/dev/null; then
        ok "Clonado (HTTPS)"
    elif git clone --quiet "$TOOLS_REPO_SSH" "$TOOLS_DIR" 2>/dev/null; then
        ok "Clonado (SSH)"
    else
        err "No pude clonar way-of-work-tools · revisá tu conexión"
        exit 1
    fi
fi

# Linkear todas las skills
log "Instalando las 9 skills del equipo"
for skill in "${ALL_SKILLS[@]}"; do
    if [ -d "$TOOLS_DIR/skills/$skill" ]; then
        ln -sfn "$TOOLS_DIR/skills/$skill" "$GLOBAL_SKILLS/$skill"
        ok "$skill"
    else
        warn "$skill no encontrado en $TOOLS_DIR/skills/"
    fi
done

# ─── 2. /office-hours de gstack (externa pública) ─────────────────
log "2/2 · Instalando /office-hours de gstack"
GSTACK_DIR="$WORK_DIR/gstack"

if [ -d "$GSTACK_DIR/.git" ]; then
    cd "$GSTACK_DIR" && git pull --quiet 2>/dev/null || true
else
    git clone --quiet --depth 1 "$GSTACK_REPO" "$GSTACK_DIR" 2>/dev/null || {
        warn "No pude clonar gstack · seguimos sin /office-hours"
    }
fi

if [ -d "$GSTACK_DIR/office-hours" ]; then
    ln -sfn "$GSTACK_DIR/office-hours" "$GLOBAL_SKILLS/office-hours"
    ok "office-hours (gstack)"
fi

# ─── Verificación final ───────────────────────────────────────────
echo ""
echo "════════════════════════════════════════════════════"
echo "Skills instaladas:"
echo "════════════════════════════════════════════════════"
ls -1 "$GLOBAL_SKILLS/" | grep -E "^(office-hours|create-prd|rfc-builder|rfc-to-adr|story-to-plan|contract-define|user-story-builder|task-dependency-analyzer|code-review|sdd-router|taller-participante|facilitar-taller|lessons-harvester)$" | sort
echo ""

INSTALLED_COUNT=$(ls -1 "$GLOBAL_SKILLS/" | grep -cE "^(office-hours|create-prd|rfc-builder|rfc-to-adr|story-to-plan|contract-define|user-story-builder|task-dependency-analyzer|code-review|sdd-router)$" || echo 0)

if [ "$INSTALLED_COUNT" -eq 10 ]; then
    echo -e "${GREEN}══════════════════════════════════════${NC}"
    echo -e "${GREEN}  ✓ 10/10 skills principales instaladas · estás listo${NC}"
    echo -e "${GREEN}══════════════════════════════════════${NC}"
else
    echo -e "${YELLOW}⚠  $INSTALLED_COUNT/10 skills instaladas${NC}"
    echo -e "${YELLOW}   Correlo de nuevo o pedí ayuda en #way-of-work${NC}"
fi

echo ""
echo "Próximos pasos:"
echo "  1. Reiniciá Claude Code si estaba abierto:"
echo "     pkill -f 'claude' 2>/dev/null ; claude"
echo "  2. Verificá con:"
echo "     curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/verify-kit.sh | bash"
echo "  3. Probá:"
echo "     cd /tmp && mkdir -p test && cd test && claude"
echo "     > /office-hours"
echo ""
