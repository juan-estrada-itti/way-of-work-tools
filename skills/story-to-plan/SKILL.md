---
name: story-to-plan
version: 1.0.0
description: "Toma UNA historia INVEST y genera el plan ejecutable (vertical slice) que un agente de código puede ejecutar. Carga automáticamente el contexto de governance (ADRs, api-contract, CLAUDE.md) y descompone la historia en subtasks FE+BE+DB+tests, declarando consume/produce estructurados para cada uno. El output alimenta a /task-dependency-analyzer que arma el DAG entre subtasks y el JSON ejecutable. Resuelve el gap del pipeline SDD entre historia y ejecución. Use when: terminaste historias INVEST y necesitás un plan ejecutable antes del DAG · vas a ejecutar una historia con Claude Code y querés contexto completo cargado · sos Fase 6.5 del pipeline greenfield. Triggers: 'story to plan', 'plan de historia', 'historia a subtasks', 'vertical slice plan', 'plan ejecutable', 'story-to-plan', 'plan-historia'."

triggers:
  - story to plan
  - plan de historia
  - historia a subtasks
  - vertical slice plan
  - plan ejecutable
  - story-to-plan
  - plan-historia
  - subtasks verticales
  - plan para claude
  - planear historia

pipeline:
  phase: story-planning
  applies_to: [greenfield, brownfield]
  position_greenfield: 6.5
  position_brownfield: 9.5

dependencies:
  consumes:
    - artifact: stories.md
      produced_by: user-story-builder
      path_hint: docs/05-stories/stories.md
      required: true
      note: "el usuario selecciona UNA historia del archivo"
    - artifact: docs/04-adrs/ADR-*.md
      produced_by: rfc-to-adr
      path_hint: docs/04-adrs/
      required: true
    - artifact: api-contract.md
      produced_by: contract-define
      path_hint: docs/03-contracts/api-contract.md
      required: true
    - artifact: CLAUDE.md
      produced_by: null
      path_hint: CLAUDE.md
      required: true
      note: "convenciones del repo · V3 del way of work"
    - artifact: data-model.md
      produced_by: contract-define
      path_hint: docs/03-contracts/data-model.md
      required: false

  produces:
    - artifact: plan-H<N>.md
      path_hint: docs/06-plans/plan-H<N>.md
      cardinality: 1..1
      note: "un plan por ejecución · corresponde a 1 historia"

  upstream: [user-story-builder]
  downstream: [task-dependency-analyzer]

---

# Story-to-Plan · de historia INVEST a plan ejecutable

Convierto UNA historia funcional en un plan vertical accionable por un agente de código · con el contexto de governance ya cargado y las dependencias declaradas de forma estructurada.

**Por qué existo**
El gap del pipeline SDD hoy · entre `/user-story-builder` y `/task-dependency-analyzer` falta un paso que:
1. Carga ADRs + contrato + CLAUDE.md como contexto
2. Descompone la historia en subtasks verticales (FE + BE + DB + tests)
3. Declara `consume` y `produce` estructurados para que TDA después pueda analizar dependencias sin entender de negocio

Sin mí · `task-dependency-analyzer` recibe tasks vagas · inventa dependencias · los agentes ejecutan con poco contexto.

---

## Inputs requeridos

| Input | Obligatorio | Qué aporta |
|---|---|---|
| 1 historia INVEST (texto) | ✅ | El QUÉ a planear |
| Criterios de aceptación de la historia | ✅ | Define "hecho" |
| ADRs del proyecto | ✅ | Restricciones arquitectónicas (stack, patterns) |
| api-contract.md | ✅ | Endpoints, schemas, eventos disponibles |
| CLAUDE.md del repo | ✅ | Convenciones · estilo · testing · estructura |
| data-model.md | ⚠️ | Schemas de DB existentes · si aplica |
| Historias adyacentes | Opcional | Para detectar que otra historia ya resuelve un subtask |

---

## Output · `plan-H<N>.md`

Formato estándar · **siempre el mismo** para que TDA lo parse sin ambigüedad.

```markdown
# Plan · H<N> · <título de la historia>

**Historia fuente** · `docs/05-stories/stories.md#H<N>`
**Governance cargada**
- ADR-001 · <título>
- ADR-003 · <título>
- api-contract.md · secciones <X>, <Y>
- CLAUDE.md · secciones <A>, <B>
- data-model.md (si aplica)

## Contexto de la historia (breve)

<1 párrafo · qué resuelve · cuál es el slice vertical>

## Subtasks

### T<N>.1 · <título corto>

**Descripción** · <1-2 frases>

**Consume** (inputs declarados)
- `<namespace>.<nombre>`  · <fuente · ej: adr.001 · schema.existente>
- ...

**Produce** (outputs declarados)
- `<namespace>.<nombre>`  · <descripción corta>
- ...

**Archivos a tocar**
- `<path/al/archivo.ext>`
- ...

**Patterns a seguir** (del CLAUDE.md)
- <regla aplicable>

**Validación**
- <check medible 1>
- <check medible 2>

**Rol** · FE | BE | DB | Tests | DevOps

---

### T<N>.2 · <título corto>

[mismo formato]

---

## Resumen

- Total subtasks · <M>
- Estimación (rough) · <X horas · sumado>
- Crítico · <qué subtask no puede faltar>
- Paralelo · <cuáles podrían arrancar simultáneo · análisis formal lo hace TDA>

## Pasos sugeridos con Claude Code

\`\`\`bash
# Después de generar este plan:
cd <repo-root>
claude
> /task-dependency-analyzer
# le pasás este plan-H<N>.md + otros si tenés
# obtenés DAG + JSON Agents Kanban
\`\`\`

## Referencias

- Historia · `docs/05-stories/stories.md#H<N>`
- ADRs aplicables · lista de arriba
- Contrato API · `docs/03-contracts/api-contract.md`
```

---

## Schema de `consume` / `produce` · namespaces permitidos

Todo subtask **debe** declarar al menos 1 `consume` y 1 `produce` con este formato:

```
<namespace>.<nombre-kebab>
```

**Namespaces válidos** (no inventar otros):

| Namespace | Qué referencia | Ejemplo |
|---|---|---|
| `schema.*` | Tablas, índices, tipos, migraciones | `schema.table.favorites` |
| `endpoint.*` | Rutas HTTP con método | `endpoint.POST./favorites/:skill` |
| `contract.*` | Secciones del api-contract | `contract.favorites-api` |
| `event.*` | Eventos del sistema | `event.favorite-marked` |
| `file.*` | Archivos concretos | `file.src/routes/favorites.ts` |
| `adr.*` | Decisiones arquitectónicas | `adr.001` |
| `interface.*` | Funciones, clases, componentes | `interface.SkillList` |
| `test.*` | Tests existentes o a crear | `test.e2e.mark-favorite` |
| `env.*` | Variables de entorno o configs | `env.DATABASE_URL` |

**Reglas duras**
- Si un subtask no declara consume/produce · **NO se entrega el plan · se pide al usuario completar**
- Los nombres deben ser **estables** · TDA matchea por igualdad literal
- Si T1 produce `schema.table.favorites` · otro subtask que consuma ese schema debe escribir **exactamente** `schema.table.favorites`

---

## Proceso en 6 pasos

### Paso 1 · Lectura de governance (2-3 min)

1. Leer la historia seleccionada (H<N>) + sus AC
2. Leer TODOS los ADRs del directorio (priorizar los de status `Accepted`)
3. Leer `api-contract.md` · identificar qué endpoints/schemas aplican
4. Leer `CLAUDE.md` · identificar convenciones relevantes (estructura de carpetas, estilo, testing)
5. Leer `data-model.md` si existe

### Paso 2 · Identificar qué del contexto aplica (1 min)

Listá · "Para esta historia me afectan ADR-001 y ADR-003, y secciones X e Y del contrato". El resto se deja afuera del plan para no saturar.

### Paso 3 · Descomponer verticalmente (3-5 min)

Pensá la historia como slice vertical · típicamente necesita:

- **DB** · migración, índices, constraints
- **BE** · endpoints, validación, lógica
- **FE** · componentes, estado, llamadas al BE
- **Tests** · unitarios mínimos + E2E del flujo

Cada uno es 1 subtask (o más si es grande). No mezcles capas en un subtask.

### Paso 4 · Declarar consume/produce por subtask (3-5 min)

Por cada subtask · pensá:
- ¿Qué schemas/endpoints/ADRs **necesito ya existentes** para arrancar? → `consume`
- ¿Qué schemas/endpoints/files voy a **dejar listos** para que otros usen? → `produce`

Si un subtask no tiene al menos 1 de cada · probablemente lo mezclaste con otro · repensalo.

### Paso 5 · Archivos + patterns + validación (2-3 min)

Por cada subtask:
- Archivos concretos que va a tocar (con path completo del repo)
- Patterns del CLAUDE.md que debe respetar
- Validación medible (test pasa · migración corre · endpoint responde N)

### Paso 6 · Escribir el plan-H<N>.md (2 min)

Aplicar el formato estándar · validar que:
- Todo subtask tiene consume/produce
- Los namespaces son válidos
- Los nombres son estables (sin typos)
- Las referencias a ADRs existen

---

## Validaciones críticas (antes de entregar)

### V-A · Completitud
- [ ] Cada subtask tiene `consume` con al menos 1 item
- [ ] Cada subtask tiene `produce` con al menos 1 item
- [ ] Cada subtask declara archivos a tocar
- [ ] Cada subtask tiene validación medible

### V-B · Namespaces válidos
- [ ] Todos los `consume` / `produce` usan namespaces de la lista permitida
- [ ] No hay nombres inventados (ej: `thing.xyz` no es válido)
- [ ] Los nombres son kebab-case consistentes

### V-C · Trazabilidad
- [ ] Cada ADR referenciado existe en `docs/04-adrs/`
- [ ] Cada sección del contrato referenciada existe en `api-contract.md`
- [ ] El plan linkea a la historia fuente

### V-D · Verticalidad
- [ ] La historia es cubierta end-to-end (DB + BE + FE + Tests)
- [ ] Si alguna capa falta · el plan lo justifica (ej: "no hay FE en esta historia")
- [ ] No hay subtask que mezcle capas arbitrariamente

---

## Cuándo NO usarme

- No hay historia INVEST clara · corré `/user-story-builder` primero
- No hay ADRs ni CLAUDE.md · violaste V3 · resolvé antes
- La "historia" es en realidad un épico · divídelo en historias INVEST primero
- Querés un DAG macro entre historias · eso es `/task-dependency-analyzer` directo

---

## Ejemplo completo

### Input · historia H1 del proyecto favoritos

```
H1 · Como usuario quiero marcar una skill como favorita
AC1 · veo el botón estrella al lado de cada skill en la lista
AC2 · al hacer click se marca y persiste entre sesiones
AC3 · si ya estaba marcada, click la desmarca
```

### Governance cargada
- ADR-001 · SQLite + Express
- ADR-002 · Auth por header simple
- api-contract.md sección "favorites"
- CLAUDE.md · convenciones de routes y testing

### Output · `plan-H1.md`

```markdown
# Plan · H1 · Marcar skill como favorita

**Historia fuente** · docs/05-stories/stories.md#H1
**Governance cargada**
- ADR-001 · SQLite + Express
- ADR-002 · Auth por header simple
- api-contract.md · sección favorites
- CLAUDE.md · secciones routes, testing

## Contexto de la historia

Usuario marca/desmarca skill como favorita · persiste en DB local · UI actualiza inmediatamente.

## Subtasks

### T1.1 · Migración tabla favorites

**Descripción** · Crear tabla `favorites(user, skill, created_at)` con índice único en `(user, skill)`

**Consume**
- `adr.001` · SQLite
- `file.CLAUDE.md`

**Produce**
- `schema.table.favorites`
- `schema.index.favorites_user_skill`
- `file.src/db/migrations/003_favorites.sql`

**Archivos a tocar**
- `src/db/migrations/003_favorites.sql`

**Patterns a seguir (CLAUDE.md)**
- Migraciones numeradas en 3 dígitos
- SQL en minúsculas
- Comentario al head con fecha y descripción

**Validación**
- `npm run migrate` corre sin error
- `SELECT * FROM favorites` existe y está vacía

**Rol** · DB

---

### T1.2 · Endpoint POST /favorites/:skill

**Descripción** · Marcar skill como favorita · idempotente (si ya está · no duplica)

**Consume**
- `schema.table.favorites`   ← de T1.1
- `adr.002` · auth por header
- `contract.favorites-api`

**Produce**
- `endpoint.POST./favorites/:skill`
- `file.src/routes/favorites.ts`

**Archivos a tocar**
- `src/routes/favorites.ts`
- `src/routes/index.ts` (registrar la ruta)

**Patterns a seguir**
- Validación con zod · definida en CLAUDE.md
- Response schema según api-contract.md

**Validación**
- `POST /favorites/:skill` con header `x-user: alice` devuelve 201
- Repetir el mismo call devuelve 200 (idempotente)

**Rol** · BE

---

### T1.3 · Endpoint DELETE /favorites/:skill

**Descripción** · Desmarcar favorita

**Consume**
- `schema.table.favorites`   ← de T1.1
- `adr.002` · auth por header
- `contract.favorites-api`

**Produce**
- `endpoint.DELETE./favorites/:skill`

**Archivos a tocar**
- `src/routes/favorites.ts` (extiende T1.2)

**Validación**
- `DELETE` de una que existe · 204
- `DELETE` de una que no existe · 404

**Rol** · BE

---

### T1.4 · Componente FE · botón estrella en SkillList

**Descripción** · Botón clickeable por skill que refleja estado actual

**Consume**
- `endpoint.POST./favorites/:skill`   ← de T1.2
- `endpoint.DELETE./favorites/:skill` ← de T1.3
- `interface.SkillList`  (componente existente)

**Produce**
- `interface.FavoriteButton`
- `file.web/components/FavoriteButton.tsx`

**Archivos a tocar**
- `web/components/FavoriteButton.tsx` (nuevo)
- `web/components/SkillList.tsx` (integrar el botón)

**Patterns a seguir**
- Estilo con Tailwind · definido en CLAUDE.md
- Optimistic UI · actualizar antes de response

**Validación**
- Test visual · click en ⭐ vacía la llena
- Re-click la vacía de vuelta

**Rol** · FE

---

### T1.5 · Test E2E marcar + desmarcar

**Descripción** · Flujo completo desde UI hasta DB y vuelta

**Consume**
- `interface.FavoriteButton`           ← de T1.4
- `endpoint.POST./favorites/:skill`    ← de T1.2
- `endpoint.DELETE./favorites/:skill`  ← de T1.3
- `schema.table.favorites`             ← de T1.1

**Produce**
- `test.e2e.favorites-mark-unmark`
- `file.tests/e2e/favorites.spec.ts`

**Archivos a tocar**
- `tests/e2e/favorites.spec.ts`

**Validación**
- Test verde en CI
- Cubre AC1, AC2, AC3 de la historia

**Rol** · Tests

---

## Resumen

- Total subtasks · 5
- Estimación rough · ~6 horas
- Crítico · T1.1 (sin migración nada funciona)
- Paralelo posible (análisis formal en TDA) · T1.2 y T1.3 después de T1.1 · T1.4 puede arrancar con mock

## Pasos sugeridos con Claude Code

\`\`\`bash
cd ~/favorites-skills
claude
> /task-dependency-analyzer
# pasale este plan-H1.md (y plan-H2.md si también querés H2)
# TDA arma DAG + JSON Agents Kanban con prompts ejecutables
\`\`\`

## Referencias

- Historia · docs/05-stories/stories.md#H1
- ADR-001 · docs/04-adrs/ADR-001-sqlite.md
- ADR-002 · docs/04-adrs/ADR-002-auth-header.md
- Contrato · docs/03-contracts/api-contract.md#favorites
```

---

## Integración con el pipeline SDD

```
/user-story-builder
       ↓
  stories.md (N historias)
       ↓
 ┌──────────────────────────────┐
 │  Para cada historia Hi:      │
 │  /story-to-plan    ← SOY ACÁ │
 │       ↓                       │
 │   plan-Hi.md                 │
 └──────────────────────────────┘
       ↓
 N plan-Hi.md consolidados
       ↓
/task-dependency-analyzer
       ↓
  DAG macro + JSON Agents Kanban
       ↓
[Ejecución · Claude Code · branches · PRs]
       ↓
/code-review
```

---

## Reglas (no negociables)

- **Governance obligatoria** · sin ADRs + contrato + CLAUDE.md no arranca
- **Namespaces del schema** · los 9 listados · no inventar
- **Consume/produce obligatorios** · min 1 de cada por subtask
- **Nombres estables** · match literal con otros planes para que TDA detecte cruces
- **1 plan = 1 historia** · no mezclar varias historias en un plan
- **Slice vertical** · la historia se cubre end-to-end · capas declaradas

---

## Negative constraints

- No hago análisis de dependencias · eso es de `/task-dependency-analyzer`
- No genero DAG Mermaid · eso es del TDA
- No ejecuto código · solo planifico
- No invento governance · si un ADR no existe, lo declaro como gap
- No escribo historias · vienen de `/user-story-builder`

---

## Evolución

| Versión | Fecha | Cambios |
|---|---|---|
| v1.0 (esta) | 2026-04-21 | Skill inicial · schema con pipeline/dependencies · namespaces declarativos · integra con TDA |
| v1.1 (futura) | TBD | Aprendizajes tras uso real · ajustes al schema |
| v1.2 (futura) | TBD | Modo brownfield · consume assessment.md de journey-creator |
