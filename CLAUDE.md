# CLAUDE.md · convenciones del repo way-of-work-tools

Este archivo es leído por agentes AI (Claude Code, Cursor, Copilot) cuando trabajan en este repo.
Declara cómo está organizado, cómo se nombran las cosas y qué patrones seguir.

**V3 del way of work** · este archivo es obligatorio en todo repo antes de generar código.

---

## Qué es este repo

Herramientas del way of work SDD de tech emergentes · itti digital.
Contiene skills, documentación del pipeline, material de talleres y tools varias.

**No es producción** · acá vive la infraestructura del equipo, no productos finales.

---

## Estructura · qué va dónde

| Carpeta | Contenido | Convención |
|---|---|---|
| `kit/` | Guía de instalación + scripts | Solo cosas que un nuevo miembro corre 1 vez |
| `pipeline/` | Docs del flujo SDD | Documentación · no scripts · no código |
| `skills/` | Skills propias del equipo | 1 subcarpeta por skill · con `SKILL.md` + `skill.json` + `README.md` |
| `skills-overlays/` | Propuestas v2 para skills del repo `tech_emergentes_skills` | 1 subcarpeta por skill · solo overlay de frontmatter |
| `sesiones/` | Material por sesión del plan de 5 | `sesion-N-<nombre>/` · markdown legible sin render |
| `tools/` | Otras herramientas del equipo | Libre · cada herramienta en su subcarpeta |

---

## Naming

- **Archivos** · `kebab-case.md` (ej: `pipeline-greenfield.md`)
- **Carpetas** · `kebab-case/` (ej: `sesion-1-onboarding/`)
- **Skills** · `kebab-case/` con `SKILL.md` en MAYÚSCULAS (convención Claude Code)
- **Scripts bash** · `kebab-case.sh` (ej: `install-kit.sh`)

## Estilo de markdown

- Títulos en H1/H2/H3 · nada de H4+
- Tablas para cualquier comparación > 3 items
- Code blocks con language hint (```bash · ```yaml · ```markdown)
- Separadores `---` entre secciones largas
- Emojis **solo en títulos de alerta** (⚠️ · 🛑 · ⭐) · no decorativos
- Enlaces relativos entre docs del repo · absolutos hacia afuera

## Tono del contenido

- **Castellano** · con palabras técnicas en inglés cuando no hay equivalente claro (ej: "handoff", "greenfield")
- **Directo** · sin consultant-speak · frases cortas
- **Personal** · uso de "vos" (o "tú" si el público es latam mixto)
- **Accionable** · cada doc termina con próximo paso claro

---

## Skills · patrón obligatorio

Toda skill nueva debe tener:

```
skills/<nombre-skill>/
├── SKILL.md      · frontmatter YAML + cuerpo en markdown
├── skill.json    · metadata (name · description · capabilities)
├── README.md     · guía de uso en 100-200 líneas
└── references/   · (opcional) recursos externos
```

### Frontmatter mínimo del SKILL.md

```yaml
---
name: nombre-skill
version: 1.0.0
description: "Qué hace en 1-2 frases · triggers en prosa · cuándo usar"
triggers:
  - trigger-1
  - trigger-2

pipeline:
  phase: <nombre-fase>
  applies_to: [greenfield, brownfield]
  position_greenfield: <N>
  position_brownfield: <M>

dependencies:
  consumes:
    - artifact: <path-hint>
      produced_by: <skill-upstream>
      required: true
  produces:
    - artifact: <path-hint>
      cardinality: 1..1
  upstream: [<skills>]
  downstream: [<skills>]
---
```

Los campos `pipeline:` y `dependencies:` son **nuevos en v2** · permiten que `/sdd-router` calcule el grafo automáticamente.

---

## PRs · flujo

1. Branch desde `main` · nombre `feat/<qué>` · `fix/<qué>` · `docs/<qué>`
2. Commit atómicos · 1 cambio lógico por commit
3. PR a `main` con:
   - Título descriptivo (<70 chars)
   - Body con **Summary** + **Test plan**
   - Al menos 1 reviewer asignado
4. Merge squash · para mantener log limpio

**Mensajes de commit** · formato convencional:
- `feat(kit): add verify script`
- `docs(pipeline): clarify greenfield flow`
- `fix(install): resolve ssh clone fallback`

---

## Testing · qué validar en cada PR

- **Scripts** · probás en tu compu antes del PR · pegás output en el PR body
- **Skills** · corrés la skill con un input real · verificás que funciona en Claude Code
- **Docs** · rendereás el markdown antes del merge · no hay links rotos

No hay CI automatizado todavía · el review es humano.

---

## Reglas duras del way of work (aplican a todos los repos)

- **V1** · PRD técnico nunca reduce alcance del PRD de negocio
- **V2** · Validar cada paso contra PRD de negocio hasta el RFC
- **V3** · `CLAUDE.md` obligatorio antes de codear
- **V4** · RFC con >5 decisiones → partir en ADRs
- **V5** · Plan micro (`/story-to-plan`) antes de DAG macro (`/task-dependency-analyzer`)

---

## Referencias

- Pipeline completo · `pipeline/pipeline-greenfield.md`
- Glosario · `pipeline/glosario.md`
- PIPELINE-MANIFEST · `pipeline/PIPELINE-MANIFEST.yml`
- Material sesión 1 · `sesiones/sesion-1-onboarding/`

---

**Última actualización** · 2026-04-21 · Juan Estrada
