---
name: user-story-builder
version: 2.0.0
description: >
  Experto en construcción, evaluación y mejora de historias de usuario siguiendo
  principios INVEST y mejores prácticas ágiles. Usar este skill cuando el usuario
  quiera: (1) Crear historias de usuario nuevas a partir de ideas, requerimientos
  o conversaciones, (2) Evaluar o mejorar historias de usuario existentes,
  (3) Dividir historias grandes en historias más pequeñas e independientes,
  (4) Generar o mejorar criterios de aceptación, (5) Revisar historias en Jira
  y proponer mejoras, (6) Asegurar que las historias conecten valor de negocio
  con implementación técnica. También activar cuando el usuario mencione
  "historia de usuario", "user story", "criterios de aceptación", "acceptance
  criteria", "INVEST", "story splitting", "refinamiento", "backlog grooming",
  o pida ayuda escribiendo tickets para Jira. Funciona tanto en español como
  en inglés.

triggers:
  - historia de usuario
  - user story
  - criterios de aceptación
  - acceptance criteria
  - INVEST
  - story splitting
  - refinamiento
  - backlog grooming

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: stories
  applies_to: [greenfield, brownfield]
  position_greenfield: 6
  position_brownfield: 9

dependencies:
  consumes:
    - artifact: api-contract.md
      produced_by: contract-define
      path_hint: docs/03-contracts/api-contract.md
      required: true
    - artifact: prd.md
      produced_by: create-prd
      path_hint: docs/01-prd/prd.md
      required: true
    - artifact: data-model.md
      produced_by: contract-define
      path_hint: docs/03-contracts/data-model.md
      required: false

  produces:
    - artifact: stories.md
      path_hint: docs/05-stories/stories.md
      cardinality: 1..1
      note: "contiene N historias INVEST numeradas H1, H2, ..., HN"

  upstream: [contract-define]
  downstream: [story-to-plan]
---

# ⚠️ OVERLAY v2 · solo frontmatter

**Este archivo es una propuesta de v2 del frontmatter** · agrega campos `pipeline:` y `dependencies:` para que `/sdd-router` pueda calcular el grafo automáticamente.

**El body completo de la skill vive en el SKILL.md original** · este overlay NO reemplaza la skill, la **extiende**.

## Cómo aplicarlo cuando se merge al repo oficial

1. Abrir el SKILL.md en la branch `feature/user-story-builder`
2. Copiar los campos `pipeline:` y `dependencies:` de este overlay
3. Subir version a `2.0.0`
4. PR al repo del equipo

## Handoff crítico

**hacia `/story-to-plan`** · **cambio importante** · hoy el pipeline saltaba de historias directo a `task-dependency-analyzer`. Con la nueva skill `/story-to-plan` intercalada, cada historia se descompone verticalmente (FE+BE+DB+tests) antes del DAG macro.

El `downstream: [story-to-plan]` declara este encadenamiento.

## Referencia

- Original · `~/.claude/skills/user-story-builder/SKILL.md`
- Repo fuente · `ittidigital/tech_emergentes_skills` · branch `feature/user-story-builder`
- Pipeline greenfield · `shared_knowledge_iter_3/06a-pipeline.md`
