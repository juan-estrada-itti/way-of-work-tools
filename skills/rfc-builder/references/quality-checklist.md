# RFC Quality Checklist

Run through these 12 checks before presenting the final RFC draft. Each check targets a common failure mode that leads to rejected or heavily-revised RFCs.

## Structure & Completeness

- [ ] **1. Title is specific**: Someone scanning a list of 20 RFCs can tell what this one proposes without opening it.
- [ ] **2. Problem is separate from solution**: Section 1 describes the problem without leaking implementation details. A reader should understand the problem before seeing the solution.
- [ ] **3. Out of scope is explicit**: At least 2-3 items listed. If the out-of-scope section is empty, the author hasn't thought about boundaries.

## Grounding & Evidence

- [ ] **4. Current state is specific**: References actual systems, services, repos, or code paths — not generic descriptions. If a codebase was explored, findings are cited.
- [ ] **5. Metrics have targets**: Every KPI has a measurable target and a method for measurement. "Improve latency" without a number is not a metric.
- [ ] **6. Tech choices are justified**: The stack table explains WHY each technology was chosen, not just WHAT was chosen. Non-obvious choices get extra explanation.

## Solution Quality

- [ ] **7. Solution is implementable**: An engineer could start working from this RFC without needing to ask "but how do I actually do X?" Critical paths have code examples or pseudocode.
- [ ] **8. Alternatives were considered**: At least 2 alternatives with pros, cons, and specific reasons for rejection. "Do nothing" counts as a valid alternative.
- [ ] **9. Testing is concrete**: Specific test types, tools, coverage targets, and CI integration. Not just "we will write tests."

## Risk & Planning

- [ ] **10. Risks have mitigations**: Every risk has a specific mitigation strategy, not just a severity label. The mitigation should be actionable.
- [ ] **11. Rollback plan exists**: Even if it's simple ("disable feature flag" or "revert deploy"), it's written down. For data migrations, the rollback plan needs more detail.
- [ ] **12. Plan is phased**: Work is broken into deliverable increments. Each phase has a clear deliverable and success criterion, not just a date.

## Scoring

- **10-12 checks pass**: RFC is ready for review
- **7-9 checks pass**: Needs improvement in specific areas — address before sending
- **< 7 checks pass**: Significant gaps — iterate on the draft before presenting
