#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
# install-kit.sh · Kit Way of Work · tech emergentes · itti digital
#
# Instala 10 skills para el pipeline SDD en Claude Code:
#   · Skills propias del equipo (del repo way-of-work-tools)
#   · Skills del repo tech_emergentes_skills (main + branches PR)
#   · /office-hours de gstack (externa)
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
TOOLS_REPO="git@github.com:juan-estrada-itti/way-of-work-tools.git"
SKILLS_REPO="git@github.com:ittidigital/tech_emergentes_skills.git"
GSTACK_REPO="https://github.com/garrytan/gstack.git"

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

# ─── 1. Clonar way-of-work-tools (skills propias) ─────────────────
log "1/3 · Clonando skills propias del equipo"
TOOLS_DIR="$WORK_DIR/way-of-work-tools"

if [ -d "$TOOLS_DIR/.git" ]; then
    cd "$TOOLS_DIR"
    git pull --quiet
    ok "Actualizado"
else
    if ! git clone --quiet "$TOOLS_REPO" "$TOOLS_DIR" 2>/dev/null; then
        warn "Clone por SSH falló · intentando HTTPS"
        git clone --quiet "https://github.com/juan-estrada-itti/way-of-work-tools.git" "$TOOLS_DIR"
    fi
    ok "Clonado"
fi

# Instalar skills propias
for skill in rfc-to-adr story-to-plan sdd-router taller-participante facilitar-taller lessons-harvester; do
    if [ -d "$TOOLS_DIR/skills/$skill" ]; then
        ln -sfn "$TOOLS_DIR/skills/$skill" "$GLOBAL_SKILLS/$skill"
        ok "$skill"
    else
        warn "$skill no encontrado"
    fi
done

# ─── 2. Clonar tech_emergentes_skills (main + branches) ───────────
log "2/3 · Clonando skills del repo tech_emergentes_skills"
SKILLS_DIR="$WORK_DIR/tech_emergentes_skills"

if [ -d "$SKILLS_DIR/.git" ]; then
    cd "$SKILLS_DIR"
    git fetch --all --quiet
    ok "Repo actualizado"
else
    if ! git clone --quiet "$SKILLS_REPO" "$SKILLS_DIR" 2>/dev/null; then
        warn "Clone por SSH falló · intentando HTTPS"
        git clone --quiet "https://github.com/ittidigital/tech_emergentes_skills.git" "$SKILLS_DIR"
        cd "$SKILLS_DIR" && git fetch --all --quiet
    fi
    ok "Repo clonado"
fi

cd "$SKILLS_DIR"

# Skills en main
for skill in create-prd rfc-builder; do
    if [ -d "$SKILLS_DIR/skills/$skill" ]; then
        ln -sfn "$SKILLS_DIR/skills/$skill" "$GLOBAL_SKILLS/$skill"
        ok "$skill (main)"
    fi
done

# Skills en branches de PR
install_from_branch() {
    local skill=$1
    local branch=$2
    local wt="$WORK_DIR/wt-$skill"

    cd "$SKILLS_DIR"
    if git worktree list | grep -q "$wt"; then
        cd "$wt" && git pull --quiet 2>/dev/null || true
    elif git worktree add "$wt" "remotes/origin/$branch" --quiet 2>/dev/null; then
        :
    else
        warn "No pude crear worktree para $branch"
        return
    fi

    if [ -d "$wt/skills/$skill" ]; then
        ln -sfn "$wt/skills/$skill" "$GLOBAL_SKILLS/$skill"
        ok "$skill ($branch)"
    else
        warn "$skill no encontrado en branch $branch"
    fi
}

install_from_branch "contract-define"          "feature/contract-define"
install_from_branch "user-story-builder"       "feature/user-story-builder"
install_from_branch "task-dependency-analyzer" "feature/task-dependency-analyzer"
install_from_branch "code-review"              "feature/code-review-skill"

# ─── 3. /office-hours de gstack ───────────────────────────────────
log "3/3 · Instalando /office-hours de gstack (externa)"
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
ls -1 "$GLOBAL_SKILLS/" | grep -E "^(office-hours|create-prd|rfc-builder|rfc-to-adr|story-to-plan|contract-define|user-story-builder|task-dependency-analyzer|code-review|sdd-router)$" | sort
echo ""

INSTALLED_COUNT=$(ls -1 "$GLOBAL_SKILLS/" | grep -cE "^(office-hours|create-prd|rfc-builder|rfc-to-adr|story-to-plan|contract-define|user-story-builder|task-dependency-analyzer|code-review|sdd-router)$" || echo 0)

if [ "$INSTALLED_COUNT" -eq 10 ]; then
    echo -e "${GREEN}══════════════════════════════════════${NC}"
    echo -e "${GREEN}  ✓ 10/10 skills instaladas · estás listo${NC}"
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
