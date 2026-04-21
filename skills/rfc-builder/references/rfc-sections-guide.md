# RFC Sections Guide by Type

Not every RFC needs the same depth in every section. This guide helps you decide where to invest detail based on the type of technical initiative.

## How to Use This Guide

After Phase 1 (Discovery), identify which type best matches the RFC. Then use the emphasis guide to decide where to go deep and where to keep it light.

---

## RFC Types and Section Emphasis

### Feature / New Capability
*Adding a new user-facing feature or internal capability.*

| Section | Emphasis | Why |
|---------|----------|-----|
| Contexto | **Medium** | Reviewers need to understand the user need, but it's usually clear |
| Métricas | **High** | Features need measurable success criteria to avoid "ship and forget" |
| Requerimientos | **High** | Both functional and non-functional — this is what gets reviewed hardest |
| Solución | **High** | Detailed design, data model, API contracts |
| Alternativas | **Medium** | Show you considered other approaches |
| Plan | **High** | Sprints, rollout, feature flags — the "how we ship" matters |
| Testing | **Medium** | Standard test pyramid, focus on acceptance criteria |
| Riesgos | **Medium** | User-facing risks, rollback strategy |

### Infrastructure / Platform
*Database migrations, service mesh changes, cloud infrastructure, CI/CD pipeline changes.*

| Section | Emphasis | Why |
|---------|----------|-----|
| Contexto | **High** | Need to explain current infra state clearly — most reviewers won't know it |
| Métricas | **Medium** | Focus on operational metrics: latency, availability, cost |
| Requerimientos | **Medium** | Mostly non-functional (performance, reliability, security) |
| Solución | **Very High** | Extremely detailed — configs, scripts, migration steps, rollback procedures |
| Alternativas | **High** | Infra decisions are hard to reverse — show thorough evaluation |
| Plan | **Very High** | Step-by-step migration plan, zero-downtime strategy, rollback at each step |
| Testing | **High** | Load testing, chaos engineering, disaster recovery testing |
| Riesgos | **Very High** | Data loss, downtime, cascading failures — enumerate everything |

### Migration
*Moving from system A to system B (database, framework, language, cloud provider).*

| Section | Emphasis | Why |
|---------|----------|-----|
| Contexto | **High** | Need to explain why the current system is no longer adequate |
| Métricas | **Medium** | Before/after comparison metrics |
| Requerimientos | **Medium** | Focus on data integrity, backward compatibility |
| Solución | **High** | Migration strategy (big bang vs incremental), data mapping, dual-write period |
| Alternativas | **High** | "Do nothing" and "partial migration" should always be alternatives |
| Plan | **Very High** | Phased migration plan, cutover strategy, data validation steps |
| Testing | **Very High** | Data validation, shadow traffic, comparison testing |
| Riesgos | **Very High** | Data loss/corruption is the primary fear — address it extensively |

### Integration
*Connecting to a new external service, API, or third-party system.*

| Section | Emphasis | Why |
|---------|----------|-----|
| Contexto | **Medium** | What capability we're adding and why we need an external system |
| Métricas | **Medium** | Availability SLAs, latency impact, cost per call |
| Requerimientos | **High** | Contract requirements, SLA expectations, data format specifications |
| Solución | **High** | Integration pattern (sync/async), error handling, retry strategy, circuit breaker |
| Alternativas | **High** | Compare vendors/services if applicable |
| Plan | **Medium** | Standard sprint plan, sandbox/staging/production progression |
| Testing | **High** | Mock-based testing, contract testing, integration testing against sandbox |
| Riesgos | **High** | Third-party downtime, API changes, rate limits, data privacy |

### AI/ML Tools
*Building tools for AI agents, LLM integrations, ML pipelines.*

| Section | Emphasis | Why |
|---------|----------|-----|
| Contexto | **High** | Need to explain the AI/agent context for non-ML reviewers |
| Métricas | **Very High** | Tool selection accuracy, latency, error rates, eval baselines |
| Requerimientos | **Very High** | Both functional (what tools do) and design principles (naming, error format, etc.) |
| Solución | **Very High** | Tool signatures, response formats, confirmation flows, tool graph |
| Alternativas | **Medium** | Architecture alternatives more than individual tool alternatives |
| Plan | **High** | Iterative — first tool, validate patterns, then scale |
| Testing | **Very High** | Evals (intent→tool selection), contract tests, integration tests |
| Riesgos | **High** | LLM misselection, token budget overflow, prompt injection |

### Refactoring / Tech Debt
*Restructuring existing code without changing external behavior.*

| Section | Emphasis | Why |
|---------|----------|-----|
| Contexto | **Very High** | Must convincingly explain why this is worth doing NOW vs later |
| Métricas | **Medium** | Code quality metrics, developer velocity, build times |
| Requerimientos | **Low** | Behavior shouldn't change — focus on constraints and invariants |
| Solución | **High** | Before/after code structure, migration path from old to new |
| Alternativas | **Medium** | "Do nothing" and "incremental cleanup" should be considered |
| Plan | **High** | How to refactor safely alongside feature work |
| Testing | **Very High** | Must prove behavior is unchanged — regression testing is critical |
| Riesgos | **Medium** | Introducing bugs during refactoring, scope creep |

---

## Universal Rules

Regardless of RFC type:

1. **Out of scope is always important** — it prevents scope creep during review
2. **Rollback plan is never optional** — even if it's "revert the deploy"
3. **Impact on other teams deserves mention** — even if the answer is "none"
4. **Glossary helps new team members** — when in doubt, include it
