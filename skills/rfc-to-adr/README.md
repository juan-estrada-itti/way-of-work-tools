# rfc-to-adr

Skill que toma un RFC técnico como input y genera una colección de ADRs (Architecture Decision Records) en formato Nygard — uno por decisión arquitectónica significativa.

## Qué resuelve

RFCs grandes mezclan 5-10 decisiones distintas (tech stack, storage, auth, APIs, patterns, deploy, etc.). Cuando una decisión cambia, el RFC entero se rompe.

Con ADRs individuales cada decisión se **versiona e itera independientemente**. Es la práctica estándar en equipos de arquitectura maduros (Michael Nygard, Spotify, ThoughtWorks).

Resuelve **V4 del way of work**: *"RFC con >5 decisiones → partirlo en ADRs antes de `/contract-define`"*.

## Cómo se activa

Triggers:
- *"rfc a adr"*
- *"crear adr"*
- *"partir rfc"*
- *"adr desde rfc"*
- *"extraer adrs"*
- *"rfc-to-adr"*

## Cómo se usa

```
Usuario: "Tengo este RFC de favoritos de skills, pásamelo a ADRs"
         [pega contenido del rfc.md]

rfc-to-adr:
  "Encontré 4 decisiones arquitectónicas:

   1. ADR-001 · Usar SQLite en vez de Postgres (high-stakes)
   2. ADR-002 · Auth por header simple en vez de JWT (requiere PoC)
   3. ADR-003 · REST en vez de GraphQL (high-stakes)
   4. ADR-004 · Frontend vanilla JS (requiere PoC)

   PoCs pendientes:
   - ADR-002 · 2 horas · criterio: header no expone sesiones
   - ADR-004 · 3 horas · criterio: vanilla JS aguanta UX requerido

   Archivos generados:
   - docs/04-adrs/ADR-INDEX.md
   - docs/04-adrs/ADR-001-usar-sqlite.md
   - docs/04-adrs/ADR-002-auth-header-simple.md
   - docs/04-adrs/ADR-003-rest-sobre-graphql.md
   - docs/04-adrs/ADR-004-vanilla-js-frontend.md

   Próximo paso: resolver PoCs antes de /contract-define"
```

## Inputs

| Input | Requerido | Descripción |
|---|---|---|
| RFC | ✅ Sí | Path al `.md` del RFC o contenido pegado |
| CLAUDE.md del proyecto | ⚠️ Recomendado | Evita convertir convenciones ya documentadas en ADRs |
| PRD de negocio | ⚠️ Recomendado | Para cross-referenciar cada decisión con problema de negocio |

## Outputs

- `docs/04-adrs/ADR-INDEX.md` · tabla resumen + PoCs pendientes + resumen ejecutivo
- `docs/04-adrs/ADR-00N-<kebab-title>.md` · 1 ADR por decisión (formato Nygard)

## Formato Nygard (estándar)

Cada ADR tiene 6 secciones:
1. **Status** · Proposed / Accepted / Deprecated / Superseded
2. **Contexto** · qué fuerza de negocio/técnica lo motiva
3. **Decisión considerada** · 2-3 alternativas con pros/contras
4. **Decisión tomada** · opción elegida + razón central
5. **Consecuencias** · positivas + negativas/trade-offs
6. **Requiere PoC** · sí/no + criterio de éxito medible

## Reglas (no negociables)

- **Mínimo 1 ADR · máximo 8 ADRs por RFC**
  - Si salen más de 8 → el RFC es demasiado grande, conviene partirlo primero
- **Status default = `Proposed`**
  - No se asume que están aceptadas, el equipo hace review después
- **Siempre referenciar al RFC fuente**
  - Trazabilidad end-to-end (PRD → RFC → ADR → Contrato)
- **PoC requiere criterio de éxito medible**
  - No "probamos si anda" · sí "latencia p95 <200ms con 1k req/s"
- **No convertir convenciones de CLAUDE.md en ADRs**
  - Ya están documentadas ahí, no duplicar

## Integración con el pipeline SDD

```
/rfc-builder       → rfc.md
      │
      ▼
/rfc-to-adr        → docs/04-adrs/ · ADR-001...N  ← SOY ACÁ
      │
      ▼
[PoCs si aplica]   → actualizan ADRs con evidencia
      │
      ▼
/contract-define   → api-contract, data-model, events, flows
```

Los ADRs sirven como **input de governance** para `/contract-define` — los contratos no pueden contradecir decisiones arquitectónicas.

## Quiénes la usan

- **Pareja 4 del Taller 1** (Fede + Andrés) · en vez del template manual de ADRs
- **Arquitectos** del equipo tech emergentes cuando terminen un RFC grande
- **Cualquier pareja** de otras iniciativas que necesite governance de decisiones

## Cuándo NO usarme

- El RFC tiene <3 decisiones arquitectónicas → no vale la pena partir
- No hay RFC · solo PRD → primero correr `/rfc-builder`
- Solo necesitás documentar 1 decisión → escribí el ADR a mano
- Estás retrodocumentando código ya implementado → esto es para ADRs de diseño, no arqueología

## Relación con otras skills

| Otra skill | Relación |
|---|---|
| `/rfc-builder` | Genera el input que yo consumo |
| `/contract-define` | Consume mis ADRs como governance |
| `/sdd-router` | Me llama cuando detecta RFC con >5 decisiones (V4) |
| `/spike-runner` | (futuro) Ejecutaría los PoCs que yo sugiero |

## Limitaciones

1. **No invento decisiones que no están en el RFC**
2. **No hago PoCs por el usuario** · solo los sugiero con criterio de éxito
3. **No apruebo ADRs** · eso lo hace el equipo con review
4. **No extraigo decisiones de código** · solo de RFCs escritos
5. **No genero ADRs sobre implementación** (naming, estilo) · solo arquitectura

## Autoría

- Autor: Juan Estrada
- Fecha: 2026-04-20
- Versión: 1.0.0
- Contexto: Taller 1 · Shared Knowledge Sesión 1 · 21 abril 2026 · resuelve V4 del way of work
