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

# RFC Builder

Build technical RFCs interactively from PRDs, requirements, or business context. The skill follows a hybrid flow: gather key context through focused questions, explore the codebase if available, generate a complete first draft, then iterate section by section until the RFC is ready for review.

## Why This Approach Works

A good RFC does three things: it explains the problem clearly enough that someone outside the team can understand it, it proposes a solution grounded in the real codebase and constraints, and it gives reviewers enough detail to make an informed decision. Most RFC drafts fail because they skip one of these — usually the grounding in reality.

This skill addresses that by combining structured questioning with active codebase exploration. When a source code repo is available (as a symlink or directory), the skill reads the actual code to understand current architecture, tech stack, patterns, and conventions before proposing anything. This means the RFC won't suggest patterns that conflict with how the team already works.

## Process Overview

```
┌─────────────────┐     ┌──────────────┐     ┌───────────────┐     ┌────────────┐
│  1. Discovery    │────▶│ 2. Codebase  │────▶│ 3. Generate   │────▶│ 4. Iterate │
│  (5-6 questions) │     │   Analysis   │     │   Full Draft  │     │  by section│
└─────────────────┘     └──────────────┘     └───────────────┘     └────────────┘
```

Each phase builds on the previous one. Don't skip phases — the quality of the draft depends heavily on what you learn in Discovery and Codebase Analysis.

## Phase 1: Discovery

Ask focused questions to understand scope and constraints. Use AskUserQuestion for structured choices, and follow up conversationally when answers need depth. The goal is to gather enough context to write a strong first draft without exhausting the user with a 20-question interview.

### Core Questions (adapt phrasing to context)

Ask these **one or two at a time**, not all at once:

1. **The Problem**: What problem are we solving? Who feels this pain today? (If the user provides a PRD, extract this from it and confirm rather than asking from scratch.)

2. **The Trigger**: What changed that makes this worth solving now? New requirement, scaling issue, tech debt, team pain, business opportunity?

3. **Scope & Boundaries**: What's IN scope for this RFC? Equally important: what's explicitly OUT of scope? (This prevents scope creep during review.)

4. **Success Criteria**: How will we know this worked? Think metrics, SLOs, user outcomes, not just "it's deployed."

5. **Known Constraints**: Team size, timeline, existing tech stack requirements, compliance needs, dependencies on other teams?

6. **Source Code**: Is there an existing codebase I should explore? If so, where is it? (Check if there's a symlink or directory with frontend/backend code. If the user says there's a repo, ask them to point you to it.)

After gathering answers, write a **brief summary** (5-6 sentences) of what you understood and confirm with the user before moving on. This prevents misalignment early.

### When a PRD is Provided

If the user provides a PRD (as a document, pasted text, or file):
1. Read the entire PRD first
2. Extract answers to the core questions from it
3. Present what you found and ask only about gaps — don't re-ask what the PRD already answers
4. Pay special attention to what the PRD does NOT cover: technical constraints, existing architecture impact, testing strategy, rollout plan — these are the sections where the RFC adds value beyond the PRD

## Phase 2: Codebase Analysis

If a source code repository is available, explore it actively. This phase grounds the RFC in reality rather than assumptions.

### What to Look For

Use Glob, Grep, and Read tools to understand:

- **Project structure**: `ls` the root, identify monorepo vs polyrepo, main directories
- **Tech stack**: Read package.json, pyproject.toml, requirements.txt, Cargo.toml, go.mod — whatever applies
- **Architecture patterns**: How is the code organized? MVC? Hexagonal? Domain-driven? Look at directory naming and imports
- **Existing conventions**: Naming patterns, error handling approach, logging/observability setup, test organization
- **Configuration**: How are environment variables, feature flags, and configs managed?
- **CI/CD**: Check .github/workflows/, Jenkinsfile, .gitlab-ci.yml for existing pipeline patterns
- **Dependencies that matter**: What libraries are already in use for the area this RFC touches?

### How to Use What You Find

The codebase analysis directly feeds into these RFC sections:
- **Current state** → describe the actual architecture, not a guess
- **Proposed solution** → align with existing patterns and conventions
- **Tech stack** → recommend libraries already in the dependency tree when possible
- **Testing strategy** → match the existing test structure and tools
- **Impact on other teams** → identify actual integration points from the code

If the codebase reveals something that contradicts the PRD or the user's assumptions (e.g., "the PRD says we use REST but the codebase is GraphQL"), surface it explicitly. These discoveries are high-value.

## Phase 3: Generate Full Draft

Write a complete RFC in markdown. Use the template in `references/rfc-template.md` as the structural guide, but adapt sections based on the type of RFC — not every RFC needs every section.

### Key Principles for the Draft

**Ground it in specifics.** Don't write "we will use a database" — write "we will add a PostgreSQL table `user_preferences` with columns X, Y, Z, indexed on user_id." The more concrete the RFC, the more useful the review feedback.

**Show your reasoning.** For every significant choice, briefly explain why. "We chose X over Y because Z." Reviewers who disagree with Z can surface it; reviewers who agree will approve faster.

**Make the testing section real.** A testing strategy that says "we will write unit tests" is worthless. Specify what kinds of tests, what they verify, what tools they use, and what the coverage target is.

**Include the ugly parts.** Risks, limitations, known unknowns, things that could go wrong — these build trust with reviewers and lead to better decisions.

**Match the audience's depth.** An RFC for a platform migration needs different detail than one for adding a new API endpoint. Scale the depth to the decision's impact.

### Section Adaptation by RFC Type

Read `references/rfc-sections-guide.md` for guidance on which sections to emphasize or skip based on the type of RFC (infrastructure, feature, migration, integration, AI/ML, etc.).

### After Generating

Present the draft to the user with a brief note about each section:
- Which sections you feel confident about (grounded in PRD + code)
- Which sections need the user's input (metrics, timelines, team assignments)
- Which sections you'd recommend they focus their review on

## Phase 4: Iterate by Section

After the user reviews the draft, iterate. The user might say:
- "Section 3 needs more detail on X" → expand that section
- "The testing strategy doesn't match how we work" → ask how they work and rewrite
- "Add a section about monitoring" → add it
- "This looks good, ship it" → done

For each iteration:
1. Apply the requested changes
2. Show only the changed section (don't regenerate the whole document)
3. Ask if there's anything else to adjust

When the user is satisfied, write the final RFC as a clean `.md` file.

## Output Format

The final deliverable is a single markdown file with this structure:

```markdown
# RFC - [Title]

- **Estado:** BORRADOR
- **Fecha de creación:** [date]
- **Autores:** [names]
- **Revisores:** [names]

## 1. Contexto y problema
## 2. Impacto y métricas de éxito
## 3. Objetivos y requerimientos
## 4. Propuesta de solución
## 5. Alternativas consideradas
## 6. Plan de implementación
## 7. Testing y validación
## 8. Riesgos y mitigaciones
## 9. Glosario
```

See `references/rfc-template.md` for the full template with guidance per section.

## References

This skill includes reference files for deeper guidance. Read them as needed — don't load everything upfront.

| File | When to Read |
|------|-------------|
| `references/rfc-template.md` | When generating the draft (Phase 3). Contains the full template with per-section guidance. |
| `references/rfc-sections-guide.md` | When deciding which sections to emphasize based on RFC type. |
| `references/quality-checklist.md` | Before presenting the final draft. 12 checks for RFC quality. |
| `references/rfc-example-summary.md` | If the user asks "what does a good RFC look like?" A condensed example based on a real production RFC. |
