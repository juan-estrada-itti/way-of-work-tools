# Pipeline SDD · greenfield vs brownfield

**Por qué este documento**
Hasta ahora el way of work asumía greenfield. Pero academy y ittilab son brownfield · necesitan pasos previos de discovery sobre el sistema existente antes de entrar al pipeline común.

Este doc separa los dos flujos para que `/sdd-router` pueda decidir correctamente qué skill correr primero.

---

## Definiciones rápidas

**Greenfield** · arrancás de cero · no hay código, no hay dominio implementado, no hay deudas
- Ejemplo: el taller del 21/4 · app de favoritos de skills
- Ejemplo: una iniciativa nueva que todavía no existe

**Brownfield** · hay sistema en producción · código, usuarios, deudas técnicas, decisiones ya tomadas
- Ejemplo: academy (en prod, usuarios activos)
- Ejemplo: ittilab (en prod, usuarios activos)
- Ejemplo: cualquier refactor, nueva feature sobre sistema existente

---

## Skills por tipo

### Skills de discovery brownfield (las que entienden sistema existente)

| Skill | Qué hace | Dónde vive |
|---|---|---|
| `journey-creator` | Documenta user journeys leyendo **código existente** | `feature/journey-creator` |
| `ddd-workshop-facilitator` | Facilita DDD · bounded contexts + domain storytelling del sistema actual | `agents-sdd-pipeline` |
| `journey-ddd-evaluator` | Evalúa arquitectura del código vs DDD / Reactive Manifesto | `agents-sdd-pipeline` |
| `ia-adoption-scanner` | Mide qué AI tooling ya usa el repo | `agents-sdd-pipeline` |

### Skills comunes (aplican a ambos)

| Skill | Fase | Dónde vive |
|---|---|---|
| `create-prd` · `sdd-prd-builder` | PRD | `tech_emergentes_skills` main |
| `prd-slice` | Slice (si PRD grande) | `agents-sdd-pipeline` |
| `rfc-builder` | RFC | `tech_emergentes_skills` main |
| `rfc-to-adr` | ADRs (V4) | `roadmap_modelo_operativo/skills-draft` |
| `contract-define` | Contrato API | branch `feature/contract-define` |
| `cross-validate` | Validación FE/BE | `agents-sdd-pipeline` |
| `user-story-builder` | Historias | branch `feature/user-story-builder` |
| `task-dependency-analyzer` | Grafo tasks DAG | branch `feature/task-dependency-analyzer` |
| `code-review` | Review | branch `feature/code-review-skill` |
| `spec-library-update` | Archivo | `agents-sdd-pipeline` |

### Skills de discovery greenfield

| Skill | Qué hace | Dónde vive |
|---|---|---|
| `/office-hours` | 6 preguntas YC · expone demanda, wedge, status quo | gstack (externo) |

---

## Pipeline greenfield (taller del 21/4)

```
/office-hours
  → discovery.md
      ↓
/create-prd
  → prd.md
      ↓
/rfc-builder
  → rfc.md
      ↓
/rfc-to-adr
  → docs/04-adrs/ADR-*.md   (V4: si RFC tiene >5 decisiones)
      ↓
/contract-define
  → api-contract.md, data-model.md, events.md
      ↓
/user-story-builder
  → stories.md  (INVEST)
      ↓
/task-dependency-analyzer
  → tasks.md + grafo Mermaid (DAG)
      ↓
[código]         Claude Code · Cursor · Copilot
      ↓
/code-review
  → review.md
      ↓
/spec-library-update   (post-merge)
  → living docs actualizados
```

**Gates humanos · mínimos para greenfield**
- Gate PRD · líder valida scope antes de RFC
- Gate RFC+ADRs · arquitectos validan decisiones antes de contratos
- Gate PR · revisor valida antes de merge

---

## Pipeline brownfield (academy · ittilab · futuro)

Se agregan **3 fases de discovery previas**, después empalma con el greenfield desde PRD.

```
┌─────────────── DISCOVERY BROWNFIELD (lo nuevo) ───────────────┐
│                                                                │
│  /journey-creator         [LEE: repo existente]                │
│    → journeys.md  (user journeys extraídos del código)         │
│        ↓                                                       │
│  /ddd-workshop-facilitator [LEE: journeys + repo]              │
│    → bounded-contexts.md + domain-storytelling.md              │
│        ↓                                                       │
│  /journey-ddd-evaluator   [LEE: todo lo anterior]              │
│    → assessment.md  (gaps vs DDD / Reactive Manifesto)         │
│                                                                │
└────────────────────────────────────────────────────────────────┘
        ↓
        ↓  (empalme con pipeline greenfield desde PRD)
        ↓
/create-prd  [LEE: assessment + discovery de negocio]
/rfc-builder
/rfc-to-adr
/contract-define
/cross-validate    [LEE: contrato + specs FE/BE existentes]
/user-story-builder
/task-dependency-analyzer
[código]
/code-review
/spec-library-update
```

**Gates humanos extra para brownfield**
- Gate Domain Map · después de Discovery · líder de producto valida el mapa de dominio detectado
- Gate Assessment · después de DDD evaluator · arquitectos validan qué deudas se tocan y cuáles no

---

## Schema de dependencias · frontmatter propuesto

Cada SKILL.md declara su posición en el grafo:

```yaml
---
name: rfc-to-adr
version: 2.0.0
description: "..."
triggers: [...]

# Grafo de dependencias
pipeline:
  phase: adrs
  applies_to: [greenfield, brownfield]
  position_greenfield: 4
  position_brownfield: 7

dependencies:
  consumes:
    - artifact: rfc.md
      produced_by: rfc-builder
      path_hint: docs/02-rfc/rfc.md
      required: true
    - artifact: CLAUDE.md
      produced_by: null              # convención, no producido por skill
      required: false

  produces:
    - artifact: ADR-INDEX.md
      path_hint: docs/04-adrs/ADR-INDEX.md
    - artifact: ADR-NNN-*.md
      path_hint: docs/04-adrs/ADR-NNN-<slug>.md
      cardinality: 1..8

  upstream: [rfc-builder]
  downstream: [contract-define, spike-runner]
---
```

Con este schema, `/sdd-router`:
1. Sabe qué fase está · por el campo `phase`
2. Decide si aplica · por `applies_to`
3. Encuentra el siguiente paso · por `downstream`
4. Valida handoffs · los outputs de la skill previa deben matchear los inputs de la siguiente

---

## Decisión · qué pipeline usa qué

| Iniciativa | Tipo | Pipeline |
|---|---|---|
| **Taller 21/4** · app favoritos skills | Greenfield | Pipeline greenfield · 7 skills del relay |
| **academy** · próxima feature | Brownfield | Pipeline brownfield completo (10+ skills) |
| **ittilab** · próxima feature | Brownfield | Pipeline brownfield completo (10+ skills) |
| **Iniciativa nueva post-taller** | depende | Greenfield si es MVP nuevo · Brownfield si es sobre academy/ittilab |

---

## Qué hacemos en este roadmap

**Sesión 1 (21/4 · taller del relay)**
- Foco: pipeline greenfield · 7 skills + `/office-hours`
- No mencionar brownfield · sumaría complejidad innecesaria
- Resultado esperado: estudiantes entienden el relay básico

**Sesión 2 · primera iteración real**
- Aplicar pipeline brownfield sobre **una feature chica de academy o ittilab**
- Probar `/journey-creator` + `/ddd-workshop-facilitator` en vivo
- Lecciones para ajustar el pipeline

**Mes 2 · adopción generalizada**
- Todas las iniciativas clasificadas (greenfield / brownfield)
- `/sdd-router` usa el campo `applies_to` para guiar automáticamente
- Grafo de dependencias completo en todas las skills (via frontmatter)

---

## Referencias externas

- **`agents-sdd-pipeline`** (`jdestradap/agents`) · 13 skills · brownfield pipeline completo con gates y ejecución paralela
- **`tech_emergentes_skills`** · skills del equipo · algunas mergeadas en main, otras en branches de PR
- **gstack** (`garrytan/gstack`) · fuente de `/office-hours`

---

## Trabajo pendiente (deuda del way of work)

1. Agregar campo `pipeline:` al frontmatter de las 7 skills del relay greenfield · primero como v2 en `skills-draft/`
2. Agregar campo `pipeline:` a las 4 skills de discovery brownfield
3. Actualizar `/sdd-router` para leer el campo y generar el grafo automáticamente
4. Generar `GRAFO-RELAY.md` derivado del frontmatter (output, no input)
5. Empaquetar pipeline brownfield como demo para Sesión 2

---

**Última actualización** · 2026-04-21 · después de revisar `agents-sdd-pipeline` · Juan Estrada
