# Kit de instalación · Way of Work

**Para quién** · los 16 del equipo tech emergentes que arrancaron el taller SDD el 21/4
**Cuánto tarda** · 30-40 minutos
**Plazo** · antes del jueves a la noche (para llegar listo al viernes)
**Qué instalás** · Claude Code + 10 skills del pipeline SDD

---

## Qué vas a tener al terminar

Cuando apretes `/` en Claude Code vas a ver estas skills:

- `/office-hours` · discovery de 6 preguntas YC
- `/create-prd` · documento de requisitos
- `/rfc-builder` · propuesta técnica
- `/rfc-to-adr` · decisiones arquitectónicas
- `/contract-define` · contrato API FE/BE
- `/user-story-builder` · historias INVEST
- `/story-to-plan` · plan ejecutable por historia
- `/task-dependency-analyzer` · grafo de tareas
- `/code-review` · review estructurado
- `/sdd-router` · navegador del pipeline

Listas para usar en tus iniciativas reales.

---

## Paso 1 · Instalar Claude Code (5 min)

**Pre-requisito** · tener Node.js instalado (versión 18+).
Verificalo con:

```bash
node --version
```

Si no lo tenés · instalalo primero:
- **macOS** · `brew install node` (o bajá de `https://nodejs.org`)
- **Linux / WSL** · `curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs`
- **Windows** · bajá de `https://nodejs.org` · asegurate de incluir npm

### Instalación de Claude Code · misma para todos los sistemas

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

Si da error de permisos en macOS/Linux, usá:
```bash
sudo npm install -g @anthropic-ai/claude-code
```

### Windows sin WSL
Claude Code funciona nativamente en Windows con Node · no necesitás WSL obligatoriamente.
Si preferís WSL (recomendado si vas a usar `git` + `bash`), instalá WSL 2 con Ubuntu 22.04 y seguí los mismos pasos.

---

## Paso 2 · Generar tu API Key (5 min)

Usamos API keys del workspace compartido del equipo · **no** OAuth personal.

### Paso a paso

1. Abrí en tu navegador:
   **https://platform.claude.com/settings/workspaces/default/keys**

2. Login con tu cuenta itti (Google SSO · `@itti.digital`)

3. Clickeá **`+ Create key`** (arriba a la derecha)

4. Nombrala siguiendo la convención del equipo:
   - Formato · `{nombre}-{apellido}-itti` o `{nombre}-key`
   - Ejemplos que ya existen · `leo-villa-itti` · `joan-aliberti-key` · `avivas-key`

5. Copiá la key completa (formato `sk-ant-api03-...`) · **se muestra una sola vez**

6. Pegala en tu terminal en el `~/.zshrc` (macOS/Linux · zsh) o `~/.bashrc` (bash):

```bash
echo 'export ANTHROPIC_API_KEY="sk-ant-api03-TU-KEY-COMPLETA"' >> ~/.zshrc
source ~/.zshrc
```

7. Verificá:
```bash
echo $ANTHROPIC_API_KEY
# Debería imprimir tu key · si no imprime nada, abrí terminal nueva
```

### ⚠️ Importante
- La key queda **solo en tu compu** · no se commitea a ningún repo
- Si la perdés · generás una nueva en el mismo panel y revocás la vieja
- Los costos van al workspace del equipo · usá con criterio

---

## Paso 3 · SSH a GitHub · pre-requisito para clonar skills privadas (5-10 min)

⚠️ **Importante** · algunas skills vienen del repo privado `ittidigital/tech_emergentes_skills` · necesitás **acceso SSH al org** para que el install-kit funcione al 100%.

### Paso 3.1 · Verificá si ya tenés SSH a GitHub

```bash
ssh -T git@github.com
```

Si ves · *"Hi <tu-usuario>! You've successfully authenticated"* · andá directo al Paso 4.
Si ves · *"Permission denied (publickey)"* · seguí acá.

### Paso 3.2 · Generá una SSH key (si no tenés)

```bash
ssh-keygen -t ed25519 -C "tu-email@itti.digital"
# Enter, Enter, Enter · sin password está bien para este setup

# Copiá la public key al portapapeles:
pbcopy < ~/.ssh/id_ed25519.pub   # macOS
# o
cat ~/.ssh/id_ed25519.pub         # Linux / WSL · copiás a mano
```

### Paso 3.3 · Agregala a tu cuenta de GitHub

1. Abrí https://github.com/settings/ssh/new
2. Pegá la public key del clipboard
3. Ponele un nombre (ej: *"macbook-itti"*)
4. Clickeá **Add SSH key**

### Paso 3.4 · Verificá que anda

```bash
ssh -T git@github.com
# Hi <tu-usuario>! You've successfully authenticated, but GitHub does not provide shell access.
```

### Paso 3.5 · ⚠️ Acceso al org ittidigital

Aparte de la SSH key, necesitás ser **colaborador** del org `ittidigital` · sino el clone al repo privado falla.

**Cómo verificar** · intentá clonar:
```bash
git clone git@github.com:ittidigital/tech_emergentes_skills.git /tmp/test-clone
# Si clona sin error · tenés acceso · borrá /tmp/test-clone
# Si dice "Repository not found" · no tenés acceso · pedile a Juan que te agregue
```

Si no tenés acceso:
- Mandale DM a Juan con tu `username` de GitHub
- Juan te agrega al team `ittidigital/tech-emergentes` (lleva 30 segundos)
- Reintentás el clone

---

## Paso 4 · Instalar las skills (2 min · 1 comando)

```bash
curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/install-kit.sh | bash
```

El script:
1. Clona las skills propias del equipo (repo público · `way-of-work-tools`)
2. Clona las skills del repo privado (`tech_emergentes_skills`) · **requiere SSH + acceso al org** (Paso 3)
3. Las linkea a tu `~/.claude/skills/`
4. Clona los PRs abiertos que todavía no mergearon
5. Instala `/office-hours` desde gstack (repo público · garrytan/gstack)
6. Imprime checklist de confirmación

**No borra nada de tu setup** · si ya tenés skills propias, las respeta.

### Si el `curl` falla

Cloná manualmente:
```bash
git clone git@github.com:juan-estrada-itti/way-of-work-tools.git ~/way-of-work-tools
bash ~/way-of-work-tools/kit/install-kit.sh
```

---

## Paso 5 · Verificar que quedó bien (5 min)

Corré el test de validación:
```bash
curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/verify-kit.sh | bash
```

Esperás ver:
```
✓ Claude Code instalado (v2.x.x)
✓ 10 skills encontradas
✓ office-hours SKILL.md válido
✓ rfc-to-adr SKILL.md válido
... (las 10)
✓ Test pasado · estás listo para el viernes
```

Si alguna falla · [FAQ](./FAQ.md) o escribime en Slack `#way-of-work`.

---

## Paso 6 · Primera corrida (5 min · opcional pero recomendado)

Abrí una carpeta vacía y probá una skill:

```bash
mkdir -p ~/test-skills && cd ~/test-skills
claude
```

Dentro de Claude Code:
1. Apretá `/` · verificás que aparecen las 10 skills
2. Tipeá `/office-hours`
3. Cuando te pregunte, elegí **startup mode**
4. Pegale esta idea:

> Quiero marcar mis skills favoritas de Claude Code para que aparezcan primero al apretar `/`.

5. Respondé las 6 preguntas con 1-2 frases cada una
6. La skill te devuelve un `discovery.md` estructurado

**Si funcionó · estás listo.** Salís con `Ctrl+D`.

---

## Troubleshooting rápido

| Síntoma | Solución |
|---|---|
| `npm: command not found` | Instalá Node.js primero · `https://nodejs.org` |
| `EACCES: permission denied` al instalar Claude | `sudo npm install -g @anthropic-ai/claude-code` o usá `nvm` para manejar permisos |
| `claude: command not found` después de instalar | Abrí terminal nueva · verificá que `npm root -g` está en tu PATH |
| `$ANTHROPIC_API_KEY` vacío | Reabrí la terminal o corré `source ~/.zshrc` |
| API key no funciona | Verificá que copiaste completa · generá una nueva en platform.claude.com |
| Skills no aparecen con `/` | Reiniciá Claude Code completo · `pkill -f claude && claude` |
| `install-kit.sh` falla por SSH | Usá HTTPS: `git config --global url."https://github.com/".insteadOf git@github.com:` |
| Corporativo bloquea GitHub | Usá datos móviles · o pedime la config Netskope |

[Ver FAQ completa →](./FAQ.md)

---

## Dónde pedir ayuda

| Canal | Para qué |
|---|---|
| Slack `#way-of-work` | Preguntas generales · respuestas en <30 min durante la semana |
| Slack DM a Juan | Algo bloqueante · necesitás hoy |
| Alejo en `#way-of-work` | Soporte técnico · instalación · plan B |

---

## Siguiente paso · viernes

Cuando tengas el kit instalado:

1. **Pensá 1 idea de feature greenfield** que te gustaría construir
   - No la desarrolles · solo tenela en la cabeza
   - Puede ser algo real de tu iniciativa o algo inventado
2. **Reservá 2 horas el viernes** para el taller 2 (greenfield hands-on)
3. **Venite curioso** · vamos al relay de 8 parejas · experiencia end-to-end

---

## Contenido del repo

```
way-of-work-tools/
├── kit/              ← estás acá · instalación
├── pipeline/         · docs del flujo SDD · glosario · pipeline
├── skills/           · las 6 skills propias del equipo
├── skills-overlays/  · propuestas v2 para skills del repo oficial
├── sesiones/         · material del taller · slides · guiones
└── tools/            · otras herramientas (crece con el tiempo)
```

**Última actualización** · 2026-04-21 · Juan Estrada
