# Rules Extraction Guide

How to extract verifiable rules from a CLAUDE.md file for Step 4 (Project Rules Compliance).

## Process

1. Read CLAUDE.md completely
2. Identify sections marked as "NON-NEGOTIABLE", "Rules", "Conventions", or similar
3. For each rule, determine:
   - **Category**: Architecture, Code Style, Security, Naming, PR Hygiene
   - **Verifiable?**: Can it be checked mechanically by reading code? (imports, patterns, naming)
   - **Severity**: BLOCKER (non-negotiable) or WARNING (convention)

## Common Rule Patterns

### Architecture Rules (usually BLOCKER)

| Pattern | How to verify |
|---|---|
| "Domain has no framework imports" | Scan imports in `domain/**/*.java` for Spring/JPA/Jackson |
| "Dependencies point inward" | Check that `domain/` doesn't import from `application/` or `infrastructure/` |
| "Business logic in aggregates" | Look for conditionals/calculations in service classes (should be in domain) |
| "Bounded context isolation" | Check for cross-context imports (except shared/common) |

### Reactive Rules (usually BLOCKER)

| Pattern | How to verify |
|---|---|
| "No .block()" | Grep for `\.block\(\)` in production code |
| "Return Mono/Flux" | Check public method signatures |
| "Use StepVerifier in tests" | Check test files for StepVerifier usage |
| "R2DBC only" | Check for JPA/Hibernate/JDBC imports |

### CQRS Rules (usually BLOCKER)

| Pattern | How to verify |
|---|---|
| "Use case does write OR read, not both" | Check if use case calls both repository.save() and returns data |
| "Commands in command/" | Verify path of command records |
| "Queries in query/" | Verify path of query records |

### Security Rules (usually BLOCKER)

| Pattern | How to verify |
|---|---|
| "WebFilters with new, not @Bean" | Search SecurityConfig for filter instantiation |
| "No sensitive data in logs" | Check log statements for field names like password, token, email |
| "No System.out" | Grep for System.out.println |

### Naming Rules (usually WARNING)

| Pattern | How to verify |
|---|---|
| Aggregate: `User` (no suffix) | Check domain model class names |
| Command: `CreateUserCommand` | Check command record names |
| Event: `UserCreatedEvent` (past tense) | Check event class names |
| UseCase: `execute()` method | Check use case interface method names |
| Config: `*Config` without Lombok | Check config class annotations |

### PR Hygiene Rules (mixed severity)

| Pattern | How to verify |
|---|---|
| "Max N files" | Count files in diff |
| "Max N lines" | Count additions + deletions |
| "Tests included" | Check for test files in diff |
| "Conventional commits" | Check commit message prefixes |
| "Branch naming" | Check branch name pattern |

## Handling Justified Deviations

Not every rule violation is a real problem. When a violation is justified:

1. Document the justification (e.g., "PRD explicitly requires get-or-create in single use case")
2. Mark as WARNING instead of BLOCKER
3. Recommend documenting the exception in the codebase

A violation is justified when:
- The PRD/RFC explicitly requires the deviation
- The alternative would be worse (e.g., while loop instead of regex to avoid Sonar issue)
- The rule doesn't apply to the layer (e.g., entity mutability in infrastructure)
