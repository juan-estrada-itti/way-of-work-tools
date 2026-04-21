---
name: rfc-builder
version: 2.0.0
description: |
  Interactive RFC builder that constructs technical RFC documents from PRDs, user stories, or business requirements. Use this skill whenever the user mentions "RFC", "request for comments", "technical proposal", "architecture decision", "design document", or wants to formalize a technical initiative into a structured proposal for team review and approval. Also trigger when the user has a PRD and wants to turn it into an engineering plan, or when they say things like "I need to write a proposal for X", "help me structure this technical decision", or "document this architecture". The skill actively explores existing source code repositories when available to ground the RFC in the real codebase. Works for any type of technical RFC: infrastructure, AI/ML tools, migrations, integrations, new features, platform changes, etc.

triggers:
  - rfc
  - request for comments
  - technical proposal
  - design document
  - rfc-builder

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: rfc
  applies_to: [greenfield, brownfield]
  position_greenfield: 3
  position_brownfield: 6

dependencies:
  consumes:
    - artifact: prd.md
      produced_by: create-prd
      path_hint: docs/01-prd/prd.md
      required: true
    - artifact: CLAUDE.md
      produced_by: null
      path_hint: CLAUDE.md
      required: false
      note: "convenciones del repo · aporta contexto técnico"
    - artifact: src/
      produced_by: null
      path_hint: src/
      required: false
      note: "en brownfield · la skill explora el codebase existente"

  produces:
    - artifact: rfc.md
      path_hint: docs/02-rfc/rfc.md
      cardinality: 1..1

  upstream: [create-prd]
  downstream: [rfc-to-adr, contract-define]
---

# ⚠️ OVERLAY v2 · solo frontmatter

**Este archivo es una propuesta de v2 del frontmatter** · agrega campos `pipeline:` y `dependencies:` para que `/sdd-router` pueda calcular el grafo automáticamente.

**El body completo de la skill vive en el SKILL.md original** · este overlay NO reemplaza la skill, la **extiende**.

## Cómo aplicarlo cuando se merge al repo oficial

1. Abrir `~/.claude/skills/rfc-builder/SKILL.md`
2. Copiar los campos `pipeline:` y `dependencies:` de este overlay
3. Agregar `version: 2.0.0` al frontmatter
4. Agregar campo `triggers:` explícito (hoy solo está en la description)
5. PR al repo del equipo

## Handoff crítico

**hacia `/rfc-to-adr`** · si el RFC tiene más de 5 decisiones arquitectónicas · V4 del way of work obliga a partirlo en ADRs antes de `/contract-define`. El campo `downstream: [rfc-to-adr, contract-define]` declara este handoff.

## Referencia

- Original · `~/.claude/skills/rfc-builder/SKILL.md`
- Repo fuente · `ittidigital/tech_emergentes_skills` · branch `main`
- Pipeline greenfield · `../../pipeline/pipeline-greenfield.md`
