---
name: contract-define
version: 2.0.0
description: "Generar contrato API compartido entre frontend y backend a partir de RFC y PRD aprobados. El contrato es el puente entre equipos y fuente de verdad para specs. Triggers: 'contrato API', 'contract define', 'api contract', 'definir contrato', 'contrato compartido FE BE', 'api-contract.md', 'data-model compartido'."

triggers:
  - contrato API
  - contract define
  - api contract
  - definir contrato
  - contrato compartido FE BE
  - api-contract.md
  - data-model compartido

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: contracts
  applies_to: [greenfield, brownfield]
  position_greenfield: 5
  position_brownfield: 8

dependencies:
  consumes:
    - artifact: rfc.md
      produced_by: rfc-builder
      path_hint: docs/02-rfc/rfc.md
      required: true
    - artifact: prd.md
      produced_by: create-prd
      path_hint: docs/01-prd/prd.md
      required: true
    - artifact: docs/04-adrs/ADR-*.md
      produced_by: rfc-to-adr
      path_hint: docs/04-adrs/
      required: false
      note: "obligatorio si el RFC tiene >5 decisiones · V4 del way of work"
    - artifact: backend-codebase
      produced_by: null
      path_hint: ../backend/
      required: false
      note: "en brownfield · explora endpoints existentes"
    - artifact: frontend-codebase
      produced_by: null
      path_hint: ../frontend/
      required: false

  produces:
    - artifact: api-contract.md
      path_hint: docs/03-contracts/api-contract.md
      cardinality: 1..1
    - artifact: data-model.md
      path_hint: docs/03-contracts/data-model.md
      cardinality: 1..1
    - artifact: events.md
      path_hint: docs/03-contracts/events.md
      cardinality: 0..1
      note: "solo si el sistema usa eventos"
    - artifact: flows.md
      path_hint: docs/03-contracts/flows.md
      cardinality: 0..1
      note: "diagramas Mermaid de secuencia"

  upstream: [rfc-builder, rfc-to-adr]
  downstream: [cross-validate, user-story-builder]
---

# Skill: `/contract.define`

**Prioridad**: ALTA — es la pieza que faltó en Release 3 (6/6 contradicciones FE↔BE habrían sido prevenidas).

## Propósito

Generar el **contrato API compartido** entre frontend y backend a partir del RFC y PRD aprobados. Este contrato es el puente entre ambos equipos y la fuente de verdad para speckit.

## Input

| Parámetro | Requerido | Descripción |
|---|---|---|
| RFC path | Sí | Path al RFC aprobado |
| PRD path | Sí | Path al PRD con user stories |
| Backend codebase | Sí | Path al repo backend |
| Frontend codebase | Sí | Path al repo frontend |

## Output

```
producto/contracts/{feature}/
├── api-contract.md       ← Endpoints: method, path, request, response, errors
├── data-model.md         ← Entidades compartidas (no internals)
├── events.md             ← Domain events (si aplica)
└── flows.md              ← Diagramas de secuencia (quién llama a quién)
```

## Workflow

### Paso 1: Leer contexto
1. Leer RFC completo
2. Leer PRD (especialmente user stories y acceptance criteria)
3. Explorar endpoints existentes en backend (`@RestController`, `@RequestMapping`)
4. Explorar llamadas API existentes en frontend (`httpClient`, `fetch`)

### Paso 2: Extraer endpoints
Para cada user story del PRD:
1. Identificar qué endpoints necesita
2. Si el endpoint ya existe en el backend → documentar como está
3. Si es nuevo → proponer basándose en patrones existentes
4. Documentar: method, path, request schema, response schema, error responses

### Paso 3: Extraer modelo de datos compartido
1. Identificar entidades que el frontend necesita ver
2. NO incluir internals del backend (IDs de DB, campos audit, etc.)
3. Documentar: nombre, campos, tipos, validaciones

### Paso 4: Extraer eventos (si aplica)
1. Webhooks que el frontend escucha
2. Domain events que cruzan bounded contexts
3. Eventos de notificación

### Paso 5: Generar diagramas de flujo
Para cada user story principal:
1. Diagrama de secuencia (Mermaid)
2. Quién inicia, qué endpoint llama, qué responde
3. Flujos de error

### Paso 6: Presentar para revisión
1. Mostrar contrato completo
2. Preguntar por cada endpoint: "¿FE dev confirma que puede consumir esto?"
3. Preguntar por cada endpoint: "¿BE dev confirma que puede implementar esto?"

## Reglas de Validación

### Para cada endpoint:
- [ ] Tiene method (GET/POST/PUT/DELETE/PATCH)
- [ ] Tiene path completo (con path params documentados)
- [ ] Tiene request body schema (si aplica)
- [ ] Tiene response schema para cada status code
- [ ] Tiene error responses documentados (4xx, 5xx)
- [ ] Tiene auth requirement documentado
- [ ] Nombre del endpoint es consistente con patrones existentes

### Para cada entidad:
- [ ] Tiene nombre en PascalCase
- [ ] Todos los campos tienen tipo explícito
- [ ] Campos nullable están marcados
- [ ] Campos con enum tienen valores listados
- [ ] No expone internals del backend

### Para cada flujo:
- [ ] Diagrama Mermaid renderiza correctamente
- [ ] Incluye happy path
- [ ] Incluye al menos un error path
- [ ] Actores están claramente identificados

## Ejemplo de api-contract.md

```markdown
## POST /api/v1/projects/{projectId}/refine/batch

**Propósito**: Disparar escaneo batch de issues del backlog
**Auth**: Bearer JWT
**User Story**: ULAB-011

**Path Parameters**:
| Param | Tipo | Descripción |
|---|---|---|
| projectId | UUID | ID del proyecto |

**Request Body**:
| Campo | Tipo | Requerido | Descripción |
|---|---|---|---|
| milestone | string | No | Filtro por GitHub milestone |
| labels | string[] | No | Filtro por labels |

**Response 202 (Accepted)**:
| Campo | Tipo | Descripción |
|---|---|---|
| status | string | Siempre "DISPATCHED" |
| projectId | UUID | ID del proyecto |
| message | string | Confirmación legible |

**Error Responses**:
| Código | Cuándo | Body |
|---|---|---|
| 409 | Escaneo ya en progreso | `{ error: "CONCURRENT_SCAN" }` |
| 404 | Proyecto no encontrado | `{ error: "PROJECT_NOT_FOUND" }` |
| 403 | Sin permisos | `{ error: "FORBIDDEN" }` |
```
