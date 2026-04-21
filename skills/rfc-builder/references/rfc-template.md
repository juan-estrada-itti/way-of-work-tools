# RFC Template

Use this as the structural backbone when generating an RFC draft. Every section includes guidance on what to write and common mistakes to avoid. Adapt freely — skip sections that don't apply, merge sections that overlap, add sections the specific RFC needs.

---

## Header Block

```markdown
# RFC - [Descriptive Title That Summarizes the Proposal]

- **Estado:** BORRADOR
- **Fecha de creación:** [YYYY-MM-DD]
- **Canal de comunicación:** [Slack channel, email list, etc.]
- **Referentes:** [Tech Lead, Product Owner, etc.]

### Revisores y autores

| Nombre | Rol | Estado | Fecha de Revisión |
|--------|-----|--------|-------------------|
| [Name] | Autor | N/A | - |
| [Name] | Aprobador | Pendiente | - |
```

**Guidance:** The title should be specific enough that someone scanning a list of RFCs knows what this one is about. "RFC - Database Migration" is too vague. "RFC - Migrate user_sessions from Redis to PostgreSQL for persistence" tells the story.

---

## 1. Contexto y problema

### What to cover
- **Current state**: Describe how things work today. Be specific — reference actual systems, services, or code paths. If you explored the codebase, cite what you found.
- **The problem**: What's broken, missing, or insufficient? Who feels this pain? How often?
- **Why now**: What changed that makes this worth solving? Business pressure, scale hitting limits, new requirements, tech debt reaching a tipping point?

### Common mistakes
- Being too abstract ("the current system is slow" — slow how? for whom? measured how?)
- Describing the solution in the problem section (keep them separate)
- Assuming the reader knows the current system as well as the author does

### Template

```markdown
## 1. Contexto y problema

### Estado actual
[Describe the current architecture/system/process. Reference specific services, repos, or components.]

### Problema a resolver
[What's broken or missing. Be specific about impact — frequency, affected users, cost.]

### Por qué ahora
[What triggered this RFC. New requirement, incident, scaling issue, business opportunity.]
```

---

## 2. Impacto y métricas de éxito

### What to cover
- **Business impact**: What changes for users, revenue, operations?
- **Measurable KPIs**: Define 3-5 metrics with specific targets. Each metric needs: what it measures, what the current value is (or "unknown — establish baseline"), and what the target is.

### Common mistakes
- Metrics without targets ("improve latency" — to what?)
- Metrics that can't be measured with current tooling (if you need new instrumentation, say so)
- Missing the baseline — you can't measure improvement without knowing the starting point

### Template

```markdown
## 2. Impacto y métricas de éxito

### Impacto esperado
[2-3 bullet points on what changes for users/team/business]

### KPIs

| Métrica | Valor Actual | Target | Cómo se mide |
|---------|-------------|--------|---------------|
| [Metric 1] | [Current or "Baseline TBD"] | [Target] | [Tool/query/dashboard] |
| [Metric 2] | ... | ... | ... |
```

---

## 3. Objetivos y requerimientos

### What to cover
- **Objectives**: 3-6 numbered goals. Each should be independently testable.
- **Functional requirements**: What the system must DO. Use IDs (RF-01, RF-02) for traceability.
- **Non-functional requirements**: Performance, security, observability, scalability. Use IDs (RNF-01, RNF-02).
- **Out of scope**: Explicitly list what this RFC does NOT cover. This is surprisingly important — it prevents scope creep during review and sets expectations.

### Common mistakes
- Requirements that are vague ("the system should be fast")
- Missing non-functional requirements entirely (especially security and observability)
- Out of scope being empty — there's always something out of scope

### Template

```markdown
## 3. Objetivos y requerimientos

### Objetivos
1. [Specific, testable goal]
2. [Another goal]

### Requerimientos funcionales

| ID | Requerimiento |
|----|---------------|
| RF-01 | [Specific functional requirement] |
| RF-02 | ... |

### Requerimientos no funcionales

| ID | Requerimiento |
|----|---------------|
| RNF-01 | [Performance/security/observability requirement] |
| RNF-02 | ... |

### Fuera de alcance
- [What this RFC explicitly does not cover]
- [Another out-of-scope item]
```

---

## 4. Propuesta de solución

### What to cover
This is the heart of the RFC. It should be detailed enough that an engineer could start implementing from it.

- **High-level architecture**: Diagram or description of how components interact
- **Detailed design**: For each major component, describe what it does, how it works, and how it integrates
- **Tech stack**: Libraries, frameworks, infrastructure. Justify non-obvious choices.
- **Data model**: If applicable — tables, schemas, API contracts
- **Sequence diagrams**: For complex flows, describe the step-by-step interaction

### Common mistakes
- Too high-level ("we'll add a service that handles X" — what does the service do internally?)
- Proposing new patterns when existing codebase patterns would work
- Missing the integration story — how does this connect to what already exists?
- No code examples for critical paths

### Template

```markdown
## 4. Propuesta de solución

### 4.1 Arquitectura de alto nivel
[Diagram or description of component interaction]

### 4.2 Diseño detallado

#### [Component 1]
[How it works, interfaces, data flow]

#### [Component 2]
[How it works, interfaces, data flow]

### 4.3 Stack tecnológico

| Componente | Tecnología | Justificación |
|-----------|------------|---------------|
| [Component] | [Library/framework] | [Why this choice] |

### 4.4 Modelo de datos
[Tables, schemas, API contracts if applicable]

### 4.5 Diagramas de secuencia
[Step-by-step flow for critical paths]
```

---

## 5. Alternativas consideradas

### What to cover
For each rejected alternative: what it is, its pros, its cons, and why you didn't choose it. This builds trust — it shows the author thought carefully, and it preempts "why didn't you just..." comments from reviewers.

### Template

```markdown
## 5. Alternativas consideradas

### Alternativa A: [Name]
[Description]

**Descartada porque:** [Specific reasons]

### Alternativa B: [Name]
[Description]

**Descartada porque:** [Specific reasons]
```

---

## 6. Plan de implementación

### What to cover
- **Phases/Sprints**: Break work into deliverable increments
- **Estimation**: Team size, timeline, dependencies
- **Feature flags**: How to control rollout
- **Rollout plan**: Staging → canary → production percentages
- **Rollback plan**: How to undo if things go wrong

### Template

```markdown
## 6. Plan de implementación

### Plan de sprints

| Sprint | Duración | Entregable |
|--------|----------|------------|
| 1 | [weeks] | [What's delivered] |
| 2 | [weeks] | [What's delivered] |

### Estimación
- **Equipo:** [N engineers]
- **Duración total:** [weeks/months]

### Feature flags

| Flag | Descripción |
|------|-------------|
| [flag.name] | [What it controls] |

### Plan de rollout
1. Staging: [details]
2. Producción X%: [details]
3. Producción 100%: [criteria]

### Plan de rollback
[How to revert if needed]
```

---

## 7. Testing y validación

### What to cover
- **Test pyramid**: Unit, integration, E2E — what each level verifies
- **Test tools**: What frameworks, mocking libraries
- **CI integration**: When tests run, what blocks merge
- **Acceptance criteria**: What must pass before release

### Common mistakes
- "We will write tests" without specifying what KIND of tests
- No mention of how tests integrate with CI/CD
- Missing contract or integration tests for systems that talk to external services

### Template

```markdown
## 7. Testing y validación

### Estrategia de testing

| Tipo | Herramienta | Cuándo | Qué verifica |
|------|-------------|--------|--------------|
| Unit | [framework] | Cada commit | [What] |
| Integration | [framework] | Nightly/PR | [What] |
| E2E | [framework] | Pre-release | [What] |

### Criterios de aceptación
- [ ] [Specific, verifiable criterion]
- [ ] [Another criterion]
```

---

## 8. Riesgos y mitigaciones

### What to cover
For each risk: description, severity (Alta/Media/Baja), and specific mitigation. Don't list risks without mitigations — that's just worrying, not planning.

### Template

```markdown
## 8. Riesgos y mitigaciones

| # | Riesgo | Severidad | Mitigación |
|---|--------|-----------|------------|
| 1 | [Risk] | Alta | [How to mitigate] |
| 2 | [Risk] | Media | [How to mitigate] |
```

---

## 9. Glosario

### When to include
Include if the RFC uses domain-specific terms, acronyms, or internal jargon that a new team member wouldn't know. Better to over-include than under-include.

### Template

```markdown
## 9. Glosario

| Término | Definición |
|---------|-----------|
| [Term] | [Clear, concise definition] |
```
