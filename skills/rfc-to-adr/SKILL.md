---
name: rfc-to-adr
description: "Toma un RFC como input y extrae las decisiones arquitectónicas implícitas, generando un ADR por cada una en formato Nygard (Contexto · Decisión · Consecuencias · Status). Identifica cuáles decisiones necesitan PoC/spike antes de commitearse. Resuelve el gap de RFCs grandes que mezclan decisiones: separarlas en ADRs individuales permite versionarlas e iterarlas independientemente. Use when: terminaste un RFC técnico y querés extraer decisiones · el RFC tiene >5 decisiones mezcladas · necesitás ADRs para governance · sos Fase 4 del Taller SDD. Triggers: 'rfc a adr', 'crear adr', 'rfc-to-adr', 'partir rfc', 'adr desde rfc', 'architecture decisions', 'decisiones arquitectura', 'nygard adr', 'extraer adrs'."
version: 1.0.0
triggers:
  - rfc a adr
  - crear adr
  - rfc-to-adr
  - partir rfc
  - adr desde rfc
  - architecture decisions
  - decisiones de arquitectura
  - decisiones arquitectura
  - nygard adr
  - extraer adrs
  - adr generator
---

# RFC-to-ADR · extractor de decisiones arquitectónicas

Convierto un RFC en una colección de ADRs (Architecture Decision Records) en formato Nygard · uno por decisión arquitectónica significativa.

**Por qué existo:**
RFCs grandes mezclan 5-10 decisiones distintas. Cuando una decisión cambia, el RFC entero se rompe. Con ADRs individuales cada decisión se versiona e itera independientemente. Es la práctica estándar en equipos de arquitectura maduros (Michael Nygard, Spotify, ThoughtWorks).

**Resuelvo V4 del way of work:** "RFC con >5 decisiones → partirlo en ADRs antes de `/contract-define`".

## Inputs requeridos

| Input | Requerido | Descripción |
|---|---|---|
| RFC | ✅ Sí | Path al `.md` del RFC o contenido pegado |
| CLAUDE.md del proyecto | ⚠️ Recomendado | Convenciones existentes · ayuda a diferenciar "decisión nueva" vs "convención ya documentada" |
| PRD de negocio | ⚠️ Recomendado | Para cross-referenciar cada decisión con un problema de negocio |
| Contexto adicional | Opcional | Deuda técnica existente, constraints externos |

## Output

Por cada decisión arquitectónica en el RFC, un archivo `.md`:

```
docs/04-adrs/
├── ADR-INDEX.md                    · índice + sugerencias de PoC
├── ADR-001-<kebab-title>.md        · 1 decisión = 1 ADR
├── ADR-002-<kebab-title>.md
├── ADR-003-<kebab-title>.md
└── ...
```

### Formato de cada ADR (Nygard)

```markdown
# ADR-00N · [Título · imperativo · ≤10 palabras]

**Status:** Proposed | Accepted | Deprecated | Superseded by ADR-0XX
**Date:** YYYY-MM-DD
**Deciders:** [lista]

## Contexto

[2-3 frases · qué fuerza de negocio/técnica hace que esta decisión sea necesaria]

## Decisión considerada

Opciones evaluadas:
1. [Opción A] · pros · contras
2. [Opción B] · pros · contras
3. [Opción C] · pros · contras

## Decisión tomada

**[Opción elegida]** porque [razón central en 1 frase].

## Consecuencias

### Positivas
- [item 1]
- [item 2]

### Negativas / trade-offs aceptados
- [item 1]
- [item 2]

## Requiere PoC antes de implementar

☐ Sí · porque [razón de incertidumbre · performance, compat, overhead]
☐ No · decisión basada en evidencia existente

Si SÍ: ver `ADR-INDEX.md` sección "PoCs pendientes".

## Referencias

- RFC fuente: [path]
- Decisiones relacionadas: ADR-00X, ADR-00Y
- PRD negocio: [path]
```

### Output adicional · ADR-INDEX.md

```markdown
# ADRs · [Nombre del proyecto/feature]

| # | Decisión | Status | Requiere PoC | Link |
|---|---|---|---|---|
| 001 | [título] | Accepted | No | [ADR-001](./ADR-001-xxx.md) |
| 002 | [título] | Proposed | ⚠️ Sí | [ADR-002](./ADR-002-xxx.md) |
| 003 | [título] | Accepted | No | [ADR-003](./ADR-003-xxx.md) |

## PoCs pendientes (antes de implementar)

- **ADR-002** · [título corto] · estimado: [X días] · criterio de éxito: [medible]

## Resumen ejecutivo

[3-4 frases describiendo el arco de decisiones arquitectónicas del feature]
```

## Proceso en 5 fases

### Fase 1 · Lectura (2-3 min)

1. Leer el RFC completo
2. Leer `CLAUDE.md` del proyecto (si existe) · para no convertir convenciones ya documentadas en ADRs
3. Leer PRD negocio · para cross-referenciar cada decisión con problema de negocio

### Fase 2 · Extracción de decisiones (3-5 min)

Buscar en el RFC frases que indiquen decisión:
- *"Elegimos X en vez de Y porque..."*
- *"La arquitectura usa X..."*
- *"Para persistencia, X..."*
- *"Auth se maneja con..."*
- *"El patrón de integración es..."*

**Categorías típicas de decisiones (ejemplos):**
- Tech stack (lenguaje, framework, librerías)
- Storage (SQL/NoSQL, local/distribuido)
- Auth (session/token/OAuth)
- APIs (REST/GraphQL/gRPC)
- Patrones (hexagonal/clean/layered)
- Deployment (serverless/container/VM)
- Observabilidad (logs/metrics/traces)
- Escalado (monolito/microservicios)
- Cacheo (in-memory/Redis/CDN)
- Async (queue/eventos/polling)

### Fase 3 · Clasificación (2 min)

Por cada decisión encontrada, clasificar:

| Tipo | Acción |
|---|---|
| **High-stakes** (cambio caro, impacto grande) | → Generar ADR |
| **Low-stakes** (convención ya establecida) | → No ADR, si acaso mención en `CLAUDE.md` |
| **Incierta** (no hay evidencia clara) | → ADR + flag "requiere PoC" |

Regla: **mínimo 1 ADR, máximo 8 ADRs** por RFC. Si salen más de 8, el RFC es demasiado grande y conviene partirlo en mini-RFCs primero.

### Fase 4 · Generación de ADRs (5-10 min)

Por cada decisión high-stakes o incierta:
1. Escribir el ADR en formato Nygard
2. Incluir 2-3 alternativas consideradas con pros/contras
3. Marcar status · `Proposed` por default (el reviewer lo acepta después)
4. Si tiene incertidumbre técnica · marcar "Requiere PoC" con criterio de éxito medible

### Fase 5 · Índice + próximos pasos (2 min)

Generar `ADR-INDEX.md`:
- Tabla resumen de todos los ADRs
- Sección de PoCs pendientes con estimación
- Resumen ejecutivo en 3-4 frases

Devolver al usuario:
1. Link a cada ADR generado
2. Lista priorizada de PoCs a ejecutar
3. Sugerencia de próximo paso en el pipeline SDD

## Validaciones críticas

Aplicar **siempre** antes de devolver el output:

### V-A · Decisiones únicas

- [ ] Cada ADR representa UNA decisión (no varias agrupadas)
- [ ] Dos ADRs no contradicen entre sí (si pasa, crear ADR-XXX "supersedes" los anteriores)

### V-B · Referencias completas

- [ ] Cada ADR referencia al RFC fuente
- [ ] Si hay ADRs dependientes, se linkean entre sí
- [ ] Si la decisión viene de PRD negocio, se linkea

### V-C · PoC justificado

- [ ] Si un ADR marca "Requiere PoC", incluir criterio de éxito medible
- [ ] Si dice "no requiere", incluir evidencia que respalda

### V-D · Status coherente

- [ ] `Proposed` si necesita revisión del equipo
- [ ] `Accepted` solo si ya fue validado
- [ ] `Deprecated` / `Superseded by ADR-0XX` si reemplaza uno anterior

## Cuándo NO usarme

- El RFC tiene <3 decisiones arquitectónicas → no vale la pena partir
- No hay RFC · solo PRD → primero correr `/rfc-builder`
- Solo necesitás documentar 1 decisión → escribí el ADR a mano, es más rápido
- Estás en código ya implementado y querés retrodocumentar → esto es para ADRs de diseño, no arqueología

## Ejemplo de uso

### Input (usuario pega)

```
/rfc-to-adr

Input · RFC del feature "favoritos de skills":
[pega el contenido del rfc.md]

CLAUDE.md:
[pega convenciones del proyecto]
```

### Output (lo que yo devuelvo)

```
Encontré 4 decisiones arquitectónicas en el RFC:

1. ADR-001 · Usar SQLite en vez de Postgres (high-stakes)
2. ADR-002 · Auth por header simple en vez de JWT (high-stakes, requiere PoC)
3. ADR-003 · REST en vez de GraphQL (high-stakes)
4. ADR-004 · Frontend vanilla JS en vez de React (incierta, requiere PoC)

PoCs pendientes:
- ADR-002 · validar que header auth no expone sesiones · 2 horas
- ADR-004 · validar que vanilla JS aguanta el UX requerido · 3 horas

Archivos generados:
- docs/04-adrs/ADR-INDEX.md
- docs/04-adrs/ADR-001-usar-sqlite.md
- docs/04-adrs/ADR-002-auth-header-simple.md
- docs/04-adrs/ADR-003-rest-sobre-graphql.md
- docs/04-adrs/ADR-004-vanilla-js-frontend.md

Próximo paso sugerido:
→ Resolver PoCs de ADR-002 y ADR-004 antes de /contract-define
  (o aceptar el riesgo y seguir · documentá la decisión en el ADR correspondiente)
```

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

Los ADRs sirven como **input de gobernance** para `/contract-define` — los contratos no pueden contradecir decisiones arquitectónicas.

## Reglas (no negociables)

- **Nunca más de 8 ADRs por RFC** · si salen más, el RFC es demasiado grande
- **Nunca menos de 1 ADR** · todo RFC tiene al menos 1 decisión significativa
- **Status default = `Proposed`** · no asumir que están aceptadas
- **Siempre referenciar al RFC fuente** · trazabilidad
- **PoC requiere criterio de éxito medible** · no "probamos si anda"
- **No convertir convenciones de CLAUDE.md en ADRs** · ya están documentadas ahí

## Negative constraints

- No invento decisiones que no están en el RFC
- No hago PoCs por el usuario · solo los sugiero
- No apruebo ADRs · eso lo hace el equipo con review
- No extraigo decisiones de código · solo de RFCs escritos
- No genero ADRs sobre elementos de implementación (naming, estilo) · solo arquitectura

## Caso validado · taller del 21 abril

En el Taller 1 del Way of Work, la **Pareja 4 (Fede + Andrés)** usa esta skill en lugar del template manual de ADRs. Flujo:

1. Leen el RFC de Pareja 3 en Google Doc
2. Pegan el RFC en `/rfc-to-adr`
3. La skill devuelve 2-3 ADRs (el RFC del taller es chico)
4. Pegan los ADRs en la sección Fase 4 del Google Doc
5. Pareja 5 los usa como input adicional para contratos

## Evolución

| Versión | Fecha | Cambios |
|---|---|---|
| v1.0 (esta) | 2026-04-20 | Skill inicial · Nygard format · identifica PoCs · integra al pipeline SDD |
| v1.1 | Post-Taller 1 | Aprendizajes del uso en vivo · ajustes al algoritmo de extracción |
| v1.2 | Mes 2 | Integración con `spike-runner` · cuando exista, auto-ejecuta los PoCs sugeridos |
