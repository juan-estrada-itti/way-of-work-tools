# Code Review Pipeline

Validates pull requests against the full SDD artifact chain (PRD, RFC, Contract) and project rules (CLAUDE.md).

Valida pull requests contra la cadena completa de artefactos SDD (PRD, RFC, Contrato) y reglas del proyecto (CLAUDE.md).

## Usage / Uso

### With GitHub Copilot

Copy to your repo:

```bash
cp -r skills/code-review/ your-repo/.github/skills/code-review/
```

Then ask: "Review PR #123 against CLAUDE.md"

### With Claude Code

Copy to your repo:

```bash
cp -r skills/code-review/ your-repo/.claude/skills/code-review/
```

Then ask: "Review PR #123" or use the trigger "revisar PR"

## What It Does / Que Hace

Runs a 6-step pipeline:

| Step | What it checks | Key question |
|------|---------------|--------------|
| 1. Discovery Inverso | PR files vs RFC phases | Does the code implement what the RFC says? |
| 2. PRD Traceability | Acceptance criteria vs tests | Does every AC have test coverage? |
| 3. Contract Compliance | Endpoints/DTOs vs API contract | Do controllers match the contract? |
| 4. Project Rules | Code vs CLAUDE.md rules | Does the code follow architecture rules? |
| 5. Cross-validation | PRD vs RFC vs Contract vs Code | Are there contradictions between artifacts? |
| 6. Scope Check | Delivered vs planned | Is it exactly what was requested? |

## Output

A structured review report with:
- Findings classified as BLOCKER / WARNING / INFO
- Scores per category
- Final verdict: APPROVE / APPROVE WITH COMMENTS / REQUEST CHANGES

## Requirements / Requisitos

- The repo must have a `CLAUDE.md` (or equivalent) with explicit rules
- Recommended: PRD and RFC documents for the feature being reviewed
- Optional: `api-contract.md` for endpoint validation
- `gh` CLI authenticated for posting reviews to GitHub
