---
name: create-prd
version: 2.1.0
author: tech-emergentes-team
description: "Document a Product Requirements Document based on completed discovery work. Translate research findings, user insights, and validated problems into a clear specification answering WHAT to build and WHY. Use when documenting product requirements after discovery, preparing a feature spec, or aligning stakeholders."

triggers:
  - create-prd
  - write-prd
  - prd-document
  - product-requirements
  - crear-prd

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: prd
  applies_to: [greenfield, brownfield]
  position_greenfield: 2
  position_brownfield: 5

dependencies:
  consumes:
    - artifact: discovery.md
      produced_by: office-hours
      path_hint: docs/00-discovery/discovery.md
      required: true
      note: "el discovery puede venir de /office-hours o de research existente"
    - artifact: user-interviews
      produced_by: null
      path_hint: docs/00-discovery/interviews/
      required: false
    - artifact: assessment.md
      produced_by: journey-ddd-evaluator
      path_hint: docs/00-brownfield-discovery/assessment.md
      required: false
      note: "solo en brownfield · aporta contexto de sistema existente"

  produces:
    - artifact: prd.md
      path_hint: docs/01-prd/prd.md
      cardinality: 1..1

  upstream: [office-hours]
  downstream: [rfc-builder, prd-slice]
---

# ⚠️ OVERLAY v2 · solo frontmatter

**Este archivo es una propuesta de v2 del frontmatter** · agrega campos `pipeline:` y `dependencies:` para que `/sdd-router` pueda calcular el grafo automáticamente.

**El body completo de la skill vive en el SKILL.md original** · este overlay NO reemplaza la skill, la **extiende**.

## Cómo aplicarlo cuando se merge al repo oficial

1. Abrir `~/.claude/skills/create-prd/SKILL.md` (o equivalente en el repo)
2. Copiar los campos `pipeline:` y `dependencies:` de este overlay
3. Pegar al frontmatter existente
4. Subir version a `2.1.0`
5. PR al repo del equipo

**Body original preservado** · ninguna instrucción de la skill cambia · solo se agregan campos de metadata.

## Por qué v2

Resuelve el gap del grafo de dependencias · ahora `/sdd-router` sabe:
- Qué skill produce el input de `create-prd` → `/office-hours`
- Qué skills consumen su output → `/rfc-builder`, `/prd-slice`
- En qué fase del pipeline vive (greenfield posición 2, brownfield 5)
- Qué tipos de iniciativa aplica

Y `/story-to-plan` puede seguir la cadena hasta el PRD sin ambigüedad.

## Referencia

- Original · `~/.claude/skills/create-prd/SKILL.md`
- Repo fuente · `ittidigital/tech_emergentes_skills` · branch `main`
- Pipeline greenfield · `../../pipeline/pipeline-greenfield.md`
