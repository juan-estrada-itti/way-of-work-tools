# Pipeline greenfield · las 7 fases del relay

**Qué es esto**
El flujo completo del SDD para proyectos desde cero · qué skill correr en cada fase, qué input necesita, qué output produce.

**Cuándo usarlo**
- Cuando arrancás una iniciativa nueva desde idea
- Cuando hacés un taller de aprendizaje (como el del 21/4)
- Cuando alguien pregunta "¿por dónde empiezo?" y la iniciativa es greenfield

---

## Diagrama del pipeline

```
┌─ FASE 1 · DISCOVERY ────────────────────────────────┐
│  /office-hours                                       │
│  Input: idea cruda (lo que tenés en la cabeza)       │
│  Output: discovery.md  (6 preguntas YC respondidas)  │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 2 · PRD ──────────────────────────────────────┐
│  /create-prd                                         │
│  Input: discovery.md                                 │
│  Output: prd.md  (QUÉ construir y POR QUÉ)           │
│  🛑 Gate: líder de producto valida scope             │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 3 · RFC ──────────────────────────────────────┐
│  /rfc-builder                                        │
│  Input: prd.md                                       │
│  Output: rfc.md  (CÓMO construir · propuesta técnica)│
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 4 · ADRs ─────────────────────────────────────┐
│  /rfc-to-adr                                         │
│  Input: rfc.md                                       │
│  Output: docs/04-adrs/ADR-001..N.md                  │
│  🛑 Gate: arquitectos validan decisiones             │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 5 · CONTRATO ─────────────────────────────────┐
│  /contract-define                                    │
│  Input: prd.md + rfc.md + ADRs                       │
│  Output: api-contract.md · data-model.md · events.md │
│  🛑 Gate: FE + BE validan contrato antes de codear   │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 6 · HISTORIAS ────────────────────────────────┐
│  /user-story-builder                                 │
│  Input: api-contract.md + prd.md                     │
│  Output: stories.md  (historias INVEST)              │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 6.5 · PLAN POR HISTORIA (vertical slice) ─────┐
│  /story-to-plan                                      │
│  Input: 1 historia INVEST + ADRs + contrato          │
│         + CLAUDE.md + data-model (si aplica)         │
│  Output: docs/06-plans/plan-H<N>.md                  │
│          (subtasks verticales FE+BE+DB+tests         │
│           con consume/produce declarativos)          │
│  Se corre 1 vez por historia · N outputs             │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 7 · TASKS + DAG MACRO ────────────────────────┐
│  /task-dependency-analyzer                           │
│  Input: N plan-H<N>.md consolidados                  │
│  Output: DAG Mermaid + critical path                 │
│          + JSON Agents Kanban (prompts ejecutables)  │
│  🛑 Gate: equipo valida el grafo antes de ejecutar   │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 8 · CÓDIGO ───────────────────────────────────┐
│  Claude Code · Cursor · Copilot                      │
│  Input: plan-Hi.md + DAG + JSON Agents Kanban        │
│  Output: commits · PR                                │
└──────────────────────────────────────────────────────┘
                           ↓
┌─ FASE 9 · REVIEW ───────────────────────────────────┐
│  /code-review                                        │
│  Input: PR + prd + rfc + contract                    │
│  Output: review.md  (apto o lista de cambios)        │
│  🛑 Gate: revisor aprueba antes de merge             │
└──────────────────────────────────────────────────────┘
                           ↓
                       [MERGE]
```

---

## Tabla resumen

| Fase | Skill | Input (lee) | Output (escribe) | Responsable típico |
|---|---|---|---|---|
| 1 · Discovery | `/office-hours` | Idea cruda | `discovery.md` | Discovery / PM |
| 2 · PRD | `/create-prd` | `discovery.md` | `prd.md` | Producto |
| 3 · RFC | `/rfc-builder` | `prd.md` | `rfc.md` | Arquitectos |
| 4 · ADRs | `/rfc-to-adr` | `rfc.md` | `docs/04-adrs/ADR-*.md` | Arquitectos |
| 5 · Contrato | `/contract-define` | `prd.md` + `rfc.md` + ADRs | `api-contract.md` · `data-model.md` · `events.md` | Arquitectos + FE/BE |
| 6 · Historias | `/user-story-builder` | contratos + PRD | `stories.md` (INVEST) | Producto |
| 6.5 · Plan por historia | `/story-to-plan` | 1 historia + ADRs + contrato + CLAUDE.md | `plan-H<N>.md` (subtasks verticales con consume/produce) | Tech lead + developer |
| 7 · DAG macro | `/task-dependency-analyzer` | N `plan-H<N>.md` | DAG Mermaid + JSON Agents Kanban | Tech lead |
| 8 · Código | Claude/Cursor/Copilot | plan-Hi.md + DAG + JSON | commits · PR | Developers |
| 9 · Review | `/code-review` | PR + specs | `review.md` | Revisor |

---

## Las 7 reglas del pipeline greenfield

1. **Nunca saltes una fase** · cada output es input obligatorio de la siguiente
2. **Cada fase tiene un artefacto visible** · si no hay artefacto, no pasó
3. **Los gates son humanos, no automáticos** · siempre alguien valida antes de avanzar
4. **El PRD de negocio nunca se reduce** · el técnico puede agregar rigor, nunca quitar alcance (V1)
5. **Si el RFC tiene >5 decisiones · se parte en ADRs** (V4)
6. **Cada skill declara qué consume y qué produce** · el grafo es explícito, no implícito
7. **Plan micro (story-to-plan) antes de DAG macro (task-dependency-analyzer)** · el plan trae governance cargada · el DAG la consume sin re-leerla

---

## Tiempo esperado por fase

| Fase | Tiempo real (iteración sin taller) | Tiempo en el taller |
|---|---|---|
| Discovery | 30-60 min | 10 min (Juan demo en vivo) |
| PRD | 2-4 h | 10 min (pareja) |
| RFC | 4-8 h | 10 min (pareja) |
| ADRs | 1-3 h | 10 min (pareja) |
| Contrato | 2-4 h | 10 min (pareja) |
| Historias | 1-2 h | 10 min (pareja) |
| Plan por historia | 30-60 min · por historia | 5 min (en el taller usa 1 sola) |
| DAG macro | 1-2 h | 10 min (pareja) |
| Code review | 30-90 min | 10 min (pareja) |

> El taller comprime todo a 10 min por fase · entonces los artefactos serán **chicos pero completos** · la idea es ver el flujo, no producir specs de producción.

---

## Qué NO incluye greenfield

Estas skills **no** aplican a greenfield (son de brownfield):

- `/journey-creator` · documentar journeys desde código existente · NO HAY CÓDIGO
- `/ddd-workshop-facilitator` · bounded contexts del sistema actual · NO HAY SISTEMA
- `/journey-ddd-evaluator` · evaluar arquitectura existente · NO HAY ARQUITECTURA
- `/ia-adoption-scanner` · medir AI tooling del repo · NO HAY REPO

Todo eso aparece en iter 4 (brownfield).

---

## Grafo de dependencias entre skills

Cada skill del pipeline declara en su frontmatter qué consume y qué produce · así `/sdd-router` puede encadenar automáticamente y detectar handoffs rotos.

### Vista del grafo

```
┌──────────────────┐
│ /office-hours    │
│ produce:         │
│  · discovery.md  │
└────────┬─────────┘
         │
         ▼
┌────────────────────────┐
│ /create-prd            │
│ consume: discovery.md  │
│ produce: prd.md        │
└────────┬───────────────┘
         │
         ▼
┌────────────────────────┐
│ /rfc-builder           │
│ consume: prd.md        │
│ produce: rfc.md        │
└────────┬───────────────┘
         │
         ▼
┌──────────────────────────────┐
│ /rfc-to-adr                  │
│ consume: rfc.md              │
│ produce: docs/04-adrs/*.md   │
└────────┬─────────────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│ /contract-define                    │
│ consume: prd.md + rfc.md + ADRs     │
│ produce: api-contract.md ·          │
│          data-model.md · events.md  │
└────────┬────────────────────────────┘
         │
         ▼
┌───────────────────────────────────────┐
│ /user-story-builder                   │
│ consume: api-contract.md + prd.md     │
│ produce: stories.md                   │
└────────┬──────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────────────┐  ← NUEVO
│ /story-to-plan                               │
│ consume: 1 historia + ADRs + contrato +      │
│          CLAUDE.md + data-model              │
│ produce: plan-H<N>.md                        │
│ (1 corrida por historia · N outputs)         │
└────────┬─────────────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────────────┐
│ /task-dependency-analyzer                    │
│ consume: N plan-H<N>.md                      │
│ produce: DAG Mermaid + JSON Agents Kanban    │
└────────┬─────────────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────────────┐
│ [Código · Claude / Cursor / Copilot]         │
│ consume: plan + DAG + JSON                   │
│ produce: commits + PR                        │
└────────┬─────────────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────────────┐
│ /code-review                                 │
│ consume: PR + prd + rfc + contract +         │
│          ADRs + plan                         │
│ produce: review.md                           │
└──────────────────────────────────────────────┘
```

### Schema en el frontmatter (v2 de cada skill · propuesta)

```yaml
pipeline:
  phase: <nombre de fase>
  applies_to: [greenfield, brownfield]
  position_greenfield: <N>
  position_brownfield: <M>

dependencies:
  consumes:
    - artifact: <path-hint>
      produced_by: <skill>
      required: true | false
  produces:
    - artifact: <path-hint>
      cardinality: 1..N
  upstream: [<skills>]
  downstream: [<skills>]
```

### Handoffs explícitos (declarativos, no implícitos)

Entre `/story-to-plan` y `/task-dependency-analyzer` el handoff se declara con **namespaces**:

```
Subtask T1.1 produce: schema.table.favorites
                      │
                      │ match literal
                      ▼
Subtask T2.1 consume: schema.table.favorites
```

Namespaces permitidos (no inventar otros):
`schema.*` · `endpoint.*` · `contract.*` · `event.*` · `file.*` · `adr.*` · `interface.*` · `test.*` · `env.*`

---

## Referencia cruzada

- Glosario de términos · `03-glosario.md`
- Cómo arrancás tu propia iniciativa greenfield · `./guia-paso-a-paso.md`
- Proyecto ejemplo del taller · `../sesiones/sesion-1-onboarding/proyecto-ejemplo.md`
- Slides para proyectar · `../sesiones/sesion-1-onboarding/slides.md`

---

**Última actualización** · 2026-04-21 · Juan Estrada
