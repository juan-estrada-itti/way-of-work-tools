---
name: contract-define
version: 2.0.0
description: "Generar contrato API compartido entre frontend y backend a partir de RFC y PRD aprobados. El contrato es el puente entre equipos y fuente de verdad para specs. Triggers: 'contrato API', 'contract define', 'api contract', 'definir contrato', 'contrato compartido FE BE', 'api-contract.md', 'data-model compartido'."

triggers:
  - contrato API
  - contract define
  - api contract
  - definir contrato
  - contrato compartido FE BE
  - api-contract.md
  - data-model compartido

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: contracts
  applies_to: [greenfield, brownfield]
  position_greenfield: 5
  position_brownfield: 8

dependencies:
  consumes:
    - artifact: rfc.md
      produced_by: rfc-builder
      path_hint: docs/02-rfc/rfc.md
      required: true
    - artifact: prd.md
      produced_by: create-prd
      path_hint: docs/01-prd/prd.md
      required: true
    - artifact: docs/04-adrs/ADR-*.md
      produced_by: rfc-to-adr
      path_hint: docs/04-adrs/
      required: false
      note: "obligatorio si el RFC tiene >5 decisiones · V4 del way of work"
    - artifact: backend-codebase
      produced_by: null
      path_hint: ../backend/
      required: false
      note: "en brownfield · explora endpoints existentes"
    - artifact: frontend-codebase
      produced_by: null
      path_hint: ../frontend/
      required: false

  produces:
    - artifact: api-contract.md
      path_hint: docs/03-contracts/api-contract.md
      cardinality: 1..1
    - artifact: data-model.md
      path_hint: docs/03-contracts/data-model.md
      cardinality: 1..1
    - artifact: events.md
      path_hint: docs/03-contracts/events.md
      cardinality: 0..1
      note: "solo si el sistema usa eventos"
    - artifact: flows.md
      path_hint: docs/03-contracts/flows.md
      cardinality: 0..1
      note: "diagramas Mermaid de secuencia"

  upstream: [rfc-builder, rfc-to-adr]
  downstream: [cross-validate, user-story-builder]
---

# ⚠️ OVERLAY v2 · solo frontmatter

**Este archivo es una propuesta de v2 del frontmatter** · agrega campos `pipeline:` y `dependencies:` para que `/sdd-router` pueda calcular el grafo automáticamente.

**El body completo de la skill vive en el SKILL.md original** · este overlay NO reemplaza la skill, la **extiende**.

## Cómo aplicarlo cuando se merge al repo oficial

1. Abrir el SKILL.md en la branch `feature/contract-define`
2. Copiar los campos `pipeline:` y `dependencies:` de este overlay
3. Subir version a `2.0.0`
4. PR al repo del equipo

## Handoff crítico

**desde `/rfc-to-adr`** · si hay ADRs, son input obligatorio (V4 · contratos no pueden contradecir decisiones arquitectónicas).
**hacia `/cross-validate`** · si existe la skill `cross-validate`, se encadena inmediatamente después para detectar inconsistencias FE/BE.
**hacia `/user-story-builder`** · el contrato es input de las historias · cada historia consume endpoints/schemas declarados.

## Referencia

- Original · `~/.claude/skills/contract-define/SKILL.md`
- Repo fuente · `ittidigital/tech_emergentes_skills` · branch `feature/contract-define`
- Pipeline greenfield · `../../pipeline/pipeline-greenfield.md`
