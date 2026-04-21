# Way of Work · Tools

**Herramientas del way of work SDD** de tech emergentes @ itti digital · skills propias, kit de instalación, material de sesiones, manifest del pipeline.

---

## Arranque rápido · 3 pasos

```bash
# 1 · Instalar Claude Code (requiere Node.js 18+)
npm install -g @anthropic-ai/claude-code
claude --version

# 2 · Configurar API key del workspace itti
# Generá tu key en: https://platform.claude.com/settings/workspaces/default/keys
# Nombrala {tu-nombre}-itti · copiala · y pegala:
echo 'export ANTHROPIC_API_KEY="sk-ant-api03-TU-KEY"' >> ~/.zshrc
source ~/.zshrc

# 3 · Instalar las 10 skills del pipeline
curl -fsSL https://raw.githubusercontent.com/ittidigital/way-of-work-tools/main/kit/install-kit.sh | bash
```

**Verificar** · `curl -fsSL https://raw.githubusercontent.com/ittidigital/way-of-work-tools/main/kit/verify-kit.sh | bash`

Si te trabás · [FAQ](./kit/FAQ.md) o Slack `#way-of-work`.

---

## Qué hay acá

```
way-of-work-tools/
├── kit/                             ⭐ empezá acá si venís de un taller
│   ├── INSTALL.md                   · guía paso a paso (30-40 min)
│   ├── install-kit.sh               · script de instalación
│   ├── verify-kit.sh                · test de 5 min post-install
│   └── FAQ.md                       · troubleshooting
│
├── pipeline/                        · docs del pipeline SDD
│   ├── PIPELINE-MANIFEST.yml        · grafo de dependencias
│   ├── glosario.md                  · términos clave (5 min de lectura)
│   ├── pipeline-greenfield.md       · las 9 fases
│   ├── guia-paso-a-paso.md          · cómo aplicarlo en tu iniciativa
│   └── greenfield-vs-brownfield.md  · diferencias + skills por tipo
│
├── skills/                          · 6 skills propias del equipo
│   ├── rfc-to-adr/                  · parte RFC en ADRs Nygard (V4)
│   ├── story-to-plan/               · plan vertical por historia
│   ├── sdd-router/                  · navegador del pipeline
│   ├── taller-participante/         · guía por fase del relay
│   ├── facilitar-taller/            · guía para facilitadores
│   └── lessons-harvester/           · captura de aprendizajes
│
├── skills-overlays/                 · propuestas v2 del frontmatter
│   ├── create-prd/                  · (PR pendiente al repo tech_emergentes_skills)
│   ├── rfc-builder/
│   ├── contract-define/
│   ├── user-story-builder/
│   ├── task-dependency-analyzer/
│   └── code-review/
│
├── sesiones/                        · material de los talleres
│   └── sesion-1-onboarding/         · 21/4/2026
│
└── tools/                           · otras herramientas (crece con el tiempo)
```

---

## Plan de 5 sesiones · roadmap

| # | Sesión | Cuándo | Duración | Foco |
|---|---|---|---|---|
| 1 | Onboarding | 21/4 | 1h | Objetivo · metodología · glosario · herramientas |
| 2 | Greenfield | ~25/4 | 2h | Relay de 8 parejas · pipeline end-to-end |
| 3 | Brownfield | ~02/5 | 2h | Sobre academy / ittilab |
| 4 | Night Shift | ~09/5 | 1h | Agentes autónomos · MCPs |
| 5 | Publicar skill | ~16/5 | 2h | Crear + PR al repo compartido |

Material por sesión en `sesiones/sesion-N-<nombre>/`.

---

## Pipeline SDD · vista de águila

```
/office-hours      → discovery.md
      ↓
/create-prd        → prd.md
      ↓
/rfc-builder       → rfc.md
      ↓
/rfc-to-adr        → docs/04-adrs/ADR-*.md       (V4 · si RFC >5 decisiones)
      ↓
/contract-define   → api-contract.md
      ↓
/user-story-builder → stories.md (INVEST)
      ↓
/story-to-plan     → plan-H<N>.md (vertical slice · con governance cargada)
      ↓
/task-dependency-analyzer → DAG Mermaid + JSON Agents Kanban
      ↓
[código · Claude Code / Cursor / Copilot]
      ↓
/code-review       → review.md
      ↓
  MERGE
```

Diagrama detallado · [pipeline/pipeline-greenfield.md](./pipeline/pipeline-greenfield.md)

---

## Las 4 reglas duras del way of work

- **V1** · El PRD técnico **nunca reduce** alcance del PRD de negocio
- **V2** · Hasta el RFC, validamos cada paso contra el PRD de negocio
- **V3** · `CLAUDE.md` obligatorio en el repo antes de codear
- **V4** · RFC con >5 decisiones arquitectónicas → partir en ADRs antes del contrato

---

## Canales de ayuda

| Canal | Para qué |
|---|---|
| Slack `#way-of-work` | Preguntas generales · respuestas en <30 min durante la semana |
| Slack DM a Juan | Algo bloqueante · necesitás hoy |
| 1-on-1 con Juan | `calendly.com/juan-estrada-itti` · miércoles |
| Issues del repo | Bugs del kit · propuestas de mejora |

---

## Contribuir

El repo es de la organización · todos los 20 pueden abrir PRs.

**Flujo recomendado**
1. Branch desde `main` · `git checkout -b feat/mi-mejora`
2. Cambios + commit
3. PR a `main` · al menos 1 reviewer
4. Merge después de approve

Para agregar una skill nueva · seguí el patrón de `skills/rfc-to-adr/` · debe tener:
- `SKILL.md` con frontmatter completo (incluyendo `pipeline:` y `dependencies:`)
- `skill.json`
- `README.md` corto

---

## Autoría

- Autor inicial · Juan Estrada
- Contribuyentes · todo el equipo tech emergentes de itti digital
- Licencia · privado · interno a itti digital

---

**Última actualización** · 2026-04-21
