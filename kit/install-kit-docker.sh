#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
# install-kit-docker.sh · Kit Way of Work · tech emergentes · itti digital
#
# Instala las skills del kit en un setup de Claude Code con Docker
# (stack claude-code-docker u otro con ~/.claude montado como volumen).
#
# Clona adentro del volumen montado y crea symlinks RELATIVOS — así
# resuelven igual en el host y adentro del contenedor.
#
# Uso (desde tu Mac · UNA sola vez):
#   bash install-kit-docker.sh
#   bash install-kit-docker.sh /ruta/custom/claude-config   # si tu mount no es el default
#
# O directo:
#   curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/install-kit-docker.sh | bash
# ──────────────────────────────────────────────────────────────────

set -euo pipefail

# ─── Config ───────────────────────────────────────────────────────
CLAUDE_CONFIG="${1:-$HOME/claude-code-docker/claude-config}"
TOOLS_REPO_HTTPS="https://github.com/juan-estrada-itti/way-of-work-tools.git"
GSTACK_REPO="https://github.com/garrytan/gstack.git"

SKILLS=(
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
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "→ $1"; }
ok()  { echo -e "  ${GREEN}✓${NC} $1"; }
warn(){ echo -e "  ${YELLOW}⚠${NC}  $1"; }
err() { echo -e "  ${RED}✗${NC} $1"; }

# ─── Pre-checks ───────────────────────────────────────────────────
echo -e "${CYAN}━━━ Kit Docker · instalando en $CLAUDE_CONFIG ━━━${NC}"

if ! command -v git &>/dev/null; then
    err "git no instalado · instalalo y volvé a correr"
    exit 1
fi
ok "git presente"

if [ ! -d "$CLAUDE_CONFIG" ]; then
    err "No encuentro $CLAUDE_CONFIG"
    echo ""
    echo "Opciones:"
    echo "  · Corré primero el setup de claude-code-docker (crea claude-config/)"
    echo "  · O pasá tu mount como argumento:"
    echo "      bash install-kit-docker.sh /ruta/a/tu/claude-config"
    exit 1
fi
ok "Mount detectado"

# ─── Workspace ────────────────────────────────────────────────────
mkdir -p "$CLAUDE_CONFIG/skills" "$CLAUDE_CONFIG/way-of-work-kit"
ok "Directorios listos (skills/ · way-of-work-kit/)"

# ─── 1. Clonar way-of-work-tools ──────────────────────────────────
log "1/2 · way-of-work-tools"
TOOLS_DIR="$CLAUDE_CONFIG/way-of-work-kit/way-of-work-tools"

if [ -d "$TOOLS_DIR/.git" ]; then
    (cd "$TOOLS_DIR" && git pull --quiet 2>/dev/null) || warn "No pude actualizar · seguimos con lo que hay"
    ok "Actualizado"
else
    if git clone --quiet "$TOOLS_REPO_HTTPS" "$TOOLS_DIR" 2>/dev/null; then
        ok "Clonado"
    else
        err "No pude clonar $TOOLS_REPO_HTTPS · revisá tu conexión"
        exit 1
    fi
fi

# ─── 2. Clonar gstack (/office-hours) ─────────────────────────────
log "2/2 · gstack (/office-hours)"
GSTACK_DIR="$CLAUDE_CONFIG/way-of-work-kit/gstack"

if [ -d "$GSTACK_DIR/.git" ]; then
    (cd "$GSTACK_DIR" && git pull --quiet 2>/dev/null) || warn "No pude actualizar gstack · seguimos con lo que hay"
    ok "Actualizado"
else
    if git clone --quiet --depth 1 "$GSTACK_REPO" "$GSTACK_DIR" 2>/dev/null; then
        ok "Clonado"
    else
        warn "No pude clonar gstack · seguimos sin /office-hours"
    fi
fi

# ─── Symlinks RELATIVOS (clave para Docker) ───────────────────────
log "Creando symlinks relativos en $CLAUDE_CONFIG/skills/"
cd "$CLAUDE_CONFIG/skills"

for s in "${SKILLS[@]}"; do
    if [ -d "$TOOLS_DIR/skills/$s" ]; then
        ln -sfn "../way-of-work-kit/way-of-work-tools/skills/$s" "$s"
        ok "$s"
    else
        warn "$s no encontrado en $TOOLS_DIR/skills/"
    fi
done

if [ -d "$GSTACK_DIR/office-hours" ]; then
    ln -sfn "../way-of-work-kit/gstack/office-hours" office-hours
    ok "office-hours (gstack)"
fi

# ─── Verificar symlinks ───────────────────────────────────────────
echo ""
echo -e "${CYAN}━━━ Symlinks instalados ━━━${NC}"
ls -la "$CLAUDE_CONFIG/skills/" | grep -E "^l" || true

BROKEN=$(find "$CLAUDE_CONFIG/skills/" -type l ! -exec test -e {} \; -print 2>/dev/null || true)
if [ -n "$BROKEN" ]; then
    echo ""
    err "Symlinks rotos detectados:"
    echo "$BROKEN"
    exit 1
fi

echo ""
echo -e "${GREEN}━━━ Listo ━━━${NC}"
echo "Relanzá el contenedor para que cargue las skills."
echo "Adentro del contenedor, apretá '/' para ver /create-prd, /rfc-builder, /office-hours, etc."
echo ""
echo "Actualizar más adelante:"
echo "  cd $CLAUDE_CONFIG/way-of-work-kit/way-of-work-tools && git pull"
echo "  cd $CLAUDE_CONFIG/way-of-work-kit/gstack && git pull"
