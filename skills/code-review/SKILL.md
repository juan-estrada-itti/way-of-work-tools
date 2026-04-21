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

# Code Review Pipeline

Validates a PR against the full chain of SDD artifacts and project rules. Closes the loop that generation skills (`sdd-prd-builder`, `rfc-builder`, `contract-define`) leave open: **does the code match what was promised?**

## When to Use

- A developer opens a PR and wants a structured review
- A tech lead wants to validate that implementation matches the RFC/PRD
- Before merging, to catch contradictions between docs and code
- To enforce architecture rules (CLAUDE.md, constitution) mechanically

## Input Required

Gather these before starting. If an artifact is missing, the pipeline adapts (skips that step or generates it from code).

| Input | Required | Source |
|---|---|---|
| PR number or branch diff | **Yes** | `gh pr diff {N}` or `git diff main...HEAD` |
| CLAUDE.md (project rules) | **Yes** | Root of the repository |
| PRD (issue.md or equivalent) | Recommended | `docs/issue/{ID}/issue.md` or similar |
| RFC (plan.md or equivalent) | Recommended | `docs/issue/{ID}/plan.md` or similar |
| API Contract (api-contract.md) | Optional | If it exists; otherwise generated from code |

## The 6 Steps

Run in order. Each step produces a section of the final report.


### Step 1: Discovery Inverso

> "Does the code implement what the docs say?"

Compare the PR diff against the RFC. For each file in the PR:

| Check | What to look for | Severity |
|---|---|---|
| RFC coverage | Is the file listed in a phase of the RFC? | WARNING if not |
| RFC accuracy | Did the RFC correctly describe what this file does? | INFO |
| Scope creep | Does the PR touch files not in the RFC and not necessary? | WARNING |
| Missing files | Does the RFC list files for this phase that the PR doesn't include? | BLOCKER |

**Output**: Table with `file | in RFC? | phase | discrepancy`

If no RFC is available, skip this step and note: `RFC not available — discovery skipped`.


### Step 2: PRD Traceability

> "Does every acceptance criterion have test coverage?"

1. Extract all acceptance criteria from the PRD (Given/When/Then or implicit from flow descriptions)
2. For each AC, search the tests in the PR for a matching test
3. Map explicitly:

| AC# | Criterion | Test that covers it | Status |
|---|---|---|---|
| AC1 | Given X When Y Then Z | `XTest::shouldZ` | COVERED |
| AC2 | Given A When B Then C | — | MISSING |

**Severity**:
- AC without test → WARNING (BLOCKER if it's a happy-path or critical-path AC)
- AC partially covered → WARNING
- Defensive code without test → INFO

If no PRD is available, extract implicit criteria from the PR description and commit messages.


### Step 3: Contract Compliance

> "Do the endpoints/DTOs match the contract?"

If `api-contract.md` exists, validate:

| Check | What to compare | Severity |
|---|---|---|
| Endpoints | Method + path in controller vs contract | BLOCKER if different |
| Request DTOs | Fields, types, nullables vs contract | BLOCKER if different |
| Response DTOs | Fields, types, wrapping vs contract | BLOCKER if different |
| Error responses | Status codes + body vs contract | WARNING |
| Auth/headers | @PreAuthorize, required headers vs contract | WARNING |
| Query params | Pagination, filters vs contract | WARNING |

If no contract exists: generate one from the code and mark as `CONTRACT MISSING — generated from code, requires validation`.

If the PR doesn't include REST endpoints (e.g., it's an internal layer), note: `No endpoints in this PR — contract check N/A`.


### Step 4: Project Rules Compliance

> "Does the code follow the project's non-negotiable rules?"

Read CLAUDE.md (or equivalent project rules file) and extract every verifiable rule. Classify each rule into a category and check every file in the diff.

**Common categories** (adapt to the actual CLAUDE.md):

#### Architecture
- Dependency direction (e.g., domain has no framework imports)
- Layer isolation (bounded contexts don't cross-import)
- Business logic placement (aggregates, not services/controllers)
- Port/adapter placement

#### Code Style
- Reactive patterns (no `.block()`, `Mono`/`Flux` returns)
- Immutability (records, no mutable collections in domain)
- Declarative style (streams over loops, reactive operators over if/else)
- CQRS separation (use case does either write or read, not both)

#### Security
- Filter instantiation patterns
- No sensitive data in logs
- No `System.out`

#### Naming
- Verify naming conventions for aggregates, commands, queries, events, use cases, adapters, entities, configs, exceptions

#### PR Hygiene
- Max file count
- Max line count
- Tests included
- Conventional commits
- Branch naming
- Migration format

**Output**: Table with `rule | file:line | violation | suggested fix` and a score per category.


### Step 5: Cross-validation

> "Are there contradictions between PRD, RFC, Contract and Code?"

Compare all available sources across these dimensions:

| Dimension | PRD says | RFC says | Contract says | Code does | Match? |
|---|---|---|---|---|---|
| Endpoint paths | | | | | |
| Field names | | | | | |
| Auth requirements | | | | | |
| Error handling | | | | | |
| Business rules | | | | | |

**Severity**:
- CRITICAL: code contradicts PRD or contract
- WARNING: code contradicts RFC (RFC may be outdated)
- INFO: inconsistent terminology but correct semantics


### Step 6: Scope Check

> "Does the PR implement exactly what it should?"

| Check | What to verify | Severity |
|---|---|---|
| Under-delivery | Features from PRD/RFC for this phase missing in PR | BLOCKER |
| Over-delivery | Code implementing features from future phases | WARNING |
| Gold-plating | Abstractions, utils, refactors not requested | WARNING |
| Single responsibility | PR covers 1 subtask/feature, not multiple | WARNING |


## Output Format

Generate a consolidated review report:

```markdown
# Code Review — PR #{number}: {title}
## Branch: {branch} → {base}
## Date: {date}
## Files reviewed: {count} ({lines} lines)
## Artifacts validated
- CLAUDE.md: {status}
- PRD: {status + path}
- RFC: {status + path}
- Contract: {status + path}

## 1. Discovery Inverso
{file table}

## 2. PRD Traceability
{AC table}
Coverage: {X}/{total} ACs covered

## 3. Contract Compliance
{endpoint table or N/A}

## 4. Project Rules Compliance
### Scores
- Architecture: {X}/N
- Code Style: {X}/N
- Security: {X}/N
- Naming: {X}/N
- PR Hygiene: {X}/N
### Violations
{rule | file:line | fix table}

## 5. Cross-validation
{divergence table}

## 6. Scope Check
- Delivery: COMPLETE | PARTIAL | INCOMPLETE
- Scope creep: NONE | MINOR | SIGNIFICANT

## Verdict
| Category | Blockers | Warnings | Info |
|---|---|---|---|
| Discovery | | | |
| Traceability | | | |
| Contract | | | |
| Rules | | | |
| Cross-val | | | |
| Scope | | | |
| **Total** | | | |

## → {VERDICT}
- 0 BLOCKERS → APPROVE
- 1+ BLOCKERS (all justifiable) → APPROVE WITH COMMENTS
- 1+ BLOCKERS (unjustifiable) → REQUEST CHANGES
- Only WARNINGS → APPROVE WITH COMMENTS
```

## Posting the Review

After generating the report:
1. Save to `docs/reviews/PR-{number}-review.md` (or project's preferred path)
2. Post as a GitHub PR review comment using `gh pr review {N} --comment --body "..."`
3. If there are file-specific findings, post inline comments on the relevant lines

## Adapting to Different Projects

The skill reads CLAUDE.md dynamically — it doesn't hardcode rules for any specific project. To use it in a different repo:
1. Ensure the repo has a CLAUDE.md (or equivalent) with explicit rules
2. Adjust the input paths for PRD/RFC/Contract to match the project's doc structure
3. The 6 steps remain the same; only the rules in Step 4 change
