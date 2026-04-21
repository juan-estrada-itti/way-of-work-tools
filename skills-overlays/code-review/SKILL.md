---
name: code-review
version: 2.0.0
description: >
  Validates a pull request against the full SDD artifact chain (PRD, RFC, Contract, ADRs, Plan)
  and project rules (CLAUDE.md). 6-step pipeline producing a structured review report.

triggers:
  - code review
  - review PR
  - code-review
  - validate PR
  - revisar PR

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: review
  applies_to: [greenfield, brownfield]
  position_greenfield: 9
  position_brownfield: 12

dependencies:
  consumes:
    - artifact: PR-diff
      produced_by: null
      path_hint: "gh pr diff {N} o git diff main...HEAD"
      required: true
    - artifact: CLAUDE.md
      produced_by: null
      path_hint: CLAUDE.md
      required: true
    - artifact: prd.md
      produced_by: create-prd
      path_hint: docs/01-prd/prd.md
      required: false
      note: "recomendado · sin PRD no se puede validar contra business intent"
    - artifact: rfc.md
      produced_by: rfc-builder
      path_hint: docs/02-rfc/rfc.md
      required: false
      note: "recomendado · sin RFC no se valida arquitectura"
    - artifact: api-contract.md
      produced_by: contract-define
      path_hint: docs/03-contracts/api-contract.md
      required: false
      note: "opcional · si existe se genera desde código"
    - artifact: docs/04-adrs/ADR-*.md
      produced_by: rfc-to-adr
      path_hint: docs/04-adrs/
      required: false
      note: "si hay ADRs · el review valida que no se contradigan"
    - artifact: plan-H<N>.md
      produced_by: story-to-plan
      path_hint: docs/06-plans/plan-H*.md
      required: false
      note: "si el PR implementa una historia específica · se valida contra su plan"

  produces:
    - artifact: review.md
      path_hint: docs/08-reviews/review-PR<N>.md
      cardinality: 1..1
      note: "report estructurado: apto o lista de cambios"

  upstream: [code-execution]
  downstream: [spec-library-update]
---

# ⚠️ OVERLAY v2 · solo frontmatter

**Este archivo es una propuesta de v2 del frontmatter** · agrega campos `pipeline:` y `dependencies:` para que `/sdd-router` pueda calcular el grafo automáticamente.

**El body completo de la skill vive en el SKILL.md original** · este overlay NO reemplaza la skill, la **extiende**.

## Cómo aplicarlo cuando se merge al repo oficial

1. Abrir el SKILL.md en la branch `feature/code-review-skill`
2. Copiar los campos `pipeline:` y `dependencies:` de este overlay
3. Subir version a `2.0.0`
4. PR al repo del equipo

## Cambios importantes · v2

**Agregados 2 inputs opcionales:**
- `docs/04-adrs/ADR-*.md` · si existen ADRs, el review valida que el código no los contradiga
- `plan-H<N>.md` · si el PR implementa una historia concreta, se valida contra su plan (subtasks completados, criterios de validación pasados)

**Cierra el loop completo del pipeline** · `code-review` es el último gate antes del merge. Con v2, puede validar contra todos los artefactos previos (PRD, RFC, ADRs, contrato, plan).

## Referencia

- Original · `~/.claude/skills/code-review/SKILL.md`
- Repo fuente · `ittidigital/tech_emergentes_skills` · branch `feature/code-review-skill`
- Pipeline greenfield · `../../pipeline/pipeline-greenfield.md`
