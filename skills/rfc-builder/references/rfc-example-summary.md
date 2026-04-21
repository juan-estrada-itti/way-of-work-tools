# RFC Example Summary

Condensed from a real production RFC for an AI Tool Library. This shows the level of specificity and structure that makes an RFC useful. Use as a reference when users ask "what does a good RFC look like?"

---

## What Made This RFC Good

1. **Concrete problem statement**: "APIs return HTML-embedded text, numeric IDs instead of names, and raw date formats that LLMs can't parse" — not just "data is messy."

2. **Measurable success criteria**:
   - API success rate > 99% normal, > 95% degraded
   - Latency p95 < 2s per tool invocation
   - Unit test coverage > 80%
   - Circuit breaker recovery < 60s

3. **14 functional requirements with IDs** (RF-01 through RF-14): Each independently testable, each traceable through the design. Examples:
   - RF-04d: "Responses must include available_actions with valid tools as next steps"
   - RF-06: "Responses must include actionable errors with recovery suggestions"
   - RF-12: "Each tool must declare risk_level (read/write/sensitive/not_delegable)"

4. **12 non-functional requirements** covering performance, resilience, observability, security, rate limiting, and connection pooling — with specific numbers, not vague targets.

5. **Explicit out of scope**: Listed 6 items including "modifying the BFF API", "implementing MCP Server (future release)", and "non-delegable operations (password change, account closure)."

6. **Solution grounded in real code**: Referenced actual libraries (httpx ^0.27, pybreaker ^1.2, tenacity ^8.2), showed actual directory structure, and included code examples for critical paths.

7. **Three alternatives considered and rejected**, each with specific reasons:
   - Direct API call (no resilience layer) — rejected for reliability
   - Intermediate Node.js service — rejected for operational complexity
   - Each rejection was 2-3 sentences, not paragraphs

8. **Testing pyramid with four levels**: Unit (each commit), LLM contract (each PR), Integration (nightly), E2E (pre-release). Each level specified what it verifies and what tools it uses.

9. **Phased rollout plan**: Staging → 10% → 50% → 100% with hold times between phases and clear criteria for progressing.

10. **Comprehensive glossary**: 15 terms defined, from domain-specific ("Tool", "Transformer", "Search-first") to technical ("Circuit Breaker", "Backpressure", "Token Budget").

## Structure Summary

```
1. Contexto y problema (current state, pain points, why now)
2. Impacto y métricas (4 KPIs with specific targets)
3. Objetivos y requerimientos (6 objectives, 14 RFs, 12 RNFs, out of scope)
4. Propuesta de solución
   4.1 Arquitectura de alto nivel (diagram)
   4.2 Alternativas descartadas (3 alternatives)
   4.3 Diseño detallado
       - Estructura de la librería (directory tree)
       - Tool por JTBD (code example)
       - Transformers (5 transform functions listed)
       - Cliente HTTP resiliente (4 patterns: CB, retry, backpressure, timeout)
       - DI pattern for HttpClient
       - Fallback strategy (3 levels)
   4.4 Diagramas de secuencia (happy path + 3 non-happy paths)
   4.5 Testing strategy (4-level pyramid)
   4.6 Versionamiento (semver, breaking change detection, deprecation path)
   4.7 Consideraciones técnicas (latency targets, security, metrics, tracing)
5. Plan de implementación (3 sprints, estimation, feature flags, rollout, rollback)
6. Glosario (15 terms)
```

## Key Takeaway

The RFC was 750+ lines because the problem warranted it — a new library that would become a critical dependency for an AI agent. A simpler RFC (adding a feature flag, changing a configuration) might be 100-200 lines. The depth should match the decision's impact and reversibility.
