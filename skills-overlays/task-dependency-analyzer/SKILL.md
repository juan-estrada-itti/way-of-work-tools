---
name: task-dependency-analyzer
version: 2.0.0
description: >
  Analyzes technical plans, feature specifications, or task lists to determine which tasks are
  independent (can run in parallel) and which have dependencies (must run sequentially).
  Produces a dependency graph as a Mermaid diagram showing execution phases, critical path,
  and the reasoning behind each dependency.

  Use this skill whenever the user wants to: decompose a project or feature into parallelizable
  work, identify dependencies between tasks or subtasks, figure out which tasks can run at the
  same time vs which must wait, plan agent orchestration order, create an execution DAG from
  a technical plan, or optimize task scheduling. Also trigger when the user mentions "dependency
  graph", "task ordering", "parallel tasks", "critical path", "execution phases", or asks
  "what depends on what" about a set of tasks. Even casual requests like "which of these can
  I run at the same time?" or "what's blocking what?" should trigger this skill.

triggers:
  - dependency graph
  - task ordering
  - parallel tasks
  - critical path
  - execution phases
  - task-dependency-analyzer
  - DAG
  - grafo de dependencias

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: task-dag
  applies_to: [greenfield, brownfield]
  position_greenfield: 7
  position_brownfield: 10

dependencies:
  consumes:
    - artifact: plan-H<N>.md
      produced_by: story-to-plan
      path_hint: docs/06-plans/plan-H*.md
      required: true
      cardinality: 1..N
      note: "consume los planes de 1 o varias historias · matchea consume/produce por namespace literal"

  produces:
    - artifact: dag.md
      path_hint: docs/07-dag/dag.md
      cardinality: 1..1
      note: "Mermaid diagram + critical path"
    - artifact: tasks.json
      path_hint: docs/07-dag/tasks.json
      cardinality: 1..1
      note: "JSON Agents Kanban · con prompts ejecutables por subtask"

  upstream: [story-to-plan]
  downstream: [code-execution]
---

# ⚠️ OVERLAY v2 · solo frontmatter

**Este archivo es una propuesta de v2 del frontmatter** · agrega campos `pipeline:` y `dependencies:` para que `/sdd-router` pueda calcular el grafo automáticamente.

**El body completo de la skill vive en el SKILL.md original** · este overlay NO reemplaza la skill, la **extiende**.

## Cómo aplicarlo cuando se merge al repo oficial

1. Abrir el SKILL.md en la branch `feature/task-dependency-analyzer`
2. Copiar los campos `pipeline:` y `dependencies:` de este overlay
3. Subir version a `2.0.0`
4. PR al repo del equipo

## Cambio más importante · v2

**Input cambia** · antes aceptaba "technical plans, feature specifications, or task lists" · vago. Ahora el input estructurado son los `plan-H<N>.md` producidos por `/story-to-plan`.

Esto hace que el análisis de dependencias sea **determinístico** · TDA matchea `consume`/`produce` por igualdad literal entre subtasks · no interpreta lenguaje natural.

**Backward compat** · sigue funcionando con planes no estructurados (falla gracefully), pero la precisión del grafo baja.

## Referencia

- Original · `~/.claude/skills/task-dependency-analyzer/SKILL.md`
- Repo fuente · `ittidigital/tech_emergentes_skills` · branch `feature/task-dependency-analyzer`
- Skill upstream nueva · `story-to-plan` (en `skills-draft/story-to-plan/`)
- Pipeline greenfield · `shared_knowledge_iter_3/06a-pipeline.md`
