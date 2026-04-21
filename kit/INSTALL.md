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

### macOS
```bash
brew install anthropics/claude/claude
claude --version
```

Si `brew` no está · instalá Homebrew primero (`https://brew.sh`).

### Linux / WSL
```bash
curl -fsSL https://claude.ai/install.sh | bash
claude --version
```

### Windows sin WSL
Instalá **WSL 2** con Ubuntu 22.04 · después seguí los pasos de Linux.
Si no querés WSL, podés usar Cursor · hablame y te paso alternativa.

---

## Paso 2 · Autenticación (5 min)

Al correr `claude` por primera vez te pide login.

**Opción A · Anthropic Console (recomendada)**
1. Abrí [console.anthropic.com](https://console.anthropic.com)
2. Login con tu cuenta itti (Google SSO)
3. Volvé a la terminal · Claude Code detecta la sesión

**Opción B · API Key**
Si preferís API key directa:
```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```
Si necesitás una key temporal del equipo, pedila a Juan.

---

## Paso 3 · Instalar las skills (2 min · 1 comando)

```bash
curl -fsSL https://raw.githubusercontent.com/ittidigital/way-of-work-tools/main/kit/install-kit.sh | bash
```

El script:
1. Clona las skills propias del equipo
2. Las linkea a tu `~/.claude/skills/`
3. Clona los PRs abiertos que todavía no mergearon
4. Instala `/office-hours` desde gstack (externa)
5. Imprime checklist de confirmación

**No borra nada de tu setup** · si ya tenés skills propias, las respeta.

### Si el `curl` falla

Cloná manualmente:
```bash
git clone git@github.com:ittidigital/way-of-work-tools.git ~/way-of-work-tools
bash ~/way-of-work-tools/kit/install-kit.sh
```

---

## Paso 4 · Verificar que quedó bien (5 min)

Corré el test de validación:
```bash
curl -fsSL https://raw.githubusercontent.com/ittidigital/way-of-work-tools/main/kit/verify-kit.sh | bash
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

## Paso 5 · Primera corrida (5 min · opcional pero recomendado)

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
| `claude: command not found` | Abrí terminal nueva · si persiste reinstalá |
| Auth falla | Usá API key (Paso 2 Opción B) |
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
