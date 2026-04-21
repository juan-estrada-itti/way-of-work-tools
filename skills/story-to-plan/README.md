# story-to-plan

Skill que convierte UNA historia INVEST en un plan ejecutable vertical · con governance cargada y dependencias declaradas de forma estructurada.

## Qué resuelve

**Gap del pipeline SDD** entre `/user-story-builder` y `/task-dependency-analyzer`.

Sin esta skill:
- Las historias quedan vagas · *"como user quiero marcar una favorita"*
- El agente que va a codear no tiene contexto cargado (ADRs, contrato, convenciones)
- `/task-dependency-analyzer` recibe tasks sin declaraciones estructuradas · inventa dependencias
- Los subtasks mezclan capas · un task hace "DB + endpoint + FE" todo junto

Con esta skill:
- La historia se descompone en slice vertical (DB, BE, FE, Tests)
- Cada subtask declara `consume` / `produce` con namespaces fijos
- `/task-dependency-analyzer` puede matchear dependencias literalmente · sin entender de negocio
- El agente ejecuta con contexto de governance cargado

## Cómo se activa

Triggers:
- *"story to plan"*
- *"plan de historia"*
- *"historia a subtasks"*
- *"vertical slice plan"*
- *"plan ejecutable"*
- *"story-to-plan"*

## Cómo se usa

```
Usuario: "Tengo la historia H1 del proyecto favoritos · armá el plan"
         [opcional: pega la historia o pasa el path a stories.md]

story-to-plan:
  "Cargando governance..."
  "✓ ADR-001 · SQLite + Express"
  "✓ ADR-002 · Auth por header"
  "✓ api-contract.md · sección favorites"
  "✓ CLAUDE.md · routes, testing"

  "Descomponiendo H1 · 'Marcar skill como favorita'"

  "Subtasks generados:"
  "  T1.1 · Migración favorites (DB)"
  "  T1.2 · Endpoint POST /favorites/:skill (BE)"
  "  T1.3 · Endpoint DELETE /favorites/:skill (BE)"
  "  T1.4 · Componente FavoriteButton (FE)"
  "  T1.5 · Test E2E marcar + desmarcar (Tests)"

  "Plan generado en docs/06-plans/plan-H1.md"

  "Próximo paso: /task-dependency-analyzer con este plan (y otros) para DAG + JSON"
```

## Inputs

| Input | Obligatorio |
|---|---|
| 1 historia INVEST | ✅ |
| AC de la historia | ✅ |
| ADRs del proyecto (`docs/04-adrs/`) | ✅ |
| `api-contract.md` | ✅ |
| `CLAUDE.md` del repo | ✅ |
| `data-model.md` | ⚠️ si aplica |

## Outputs

- `docs/06-plans/plan-H<N>.md` · 1 plan por historia · formato estándar parseado por TDA

## Estructura del plan-H<N>.md

```
# Plan · H<N> · <título>

Governance cargada · lista de ADRs/contratos/CLAUDE.md

## Subtasks
  T<N>.1 · <título>
    Consume: <namespace.nombre>, ...
    Produce: <namespace.nombre>, ...
    Archivos a tocar
    Patterns del CLAUDE.md
    Validación medible
    Rol (DB/BE/FE/Tests/DevOps)

  T<N>.2 ...
```

## Namespaces permitidos para consume/produce

- `schema.*` · tablas, índices, tipos
- `endpoint.*` · rutas HTTP
- `contract.*` · secciones del api-contract
- `event.*` · eventos del sistema
- `file.*` · archivos concretos
- `adr.*` · decisiones arquitectónicas
- `interface.*` · funciones, clases, componentes
- `test.*` · tests
- `env.*` · variables de entorno

## Reglas (no negociables)

- **Governance obligatoria** · sin ADRs + contrato + CLAUDE.md no arranca
- **Consume/produce obligatorio** · min 1 de cada por subtask
- **Namespaces de la lista** · no inventar otros
- **Nombres estables** · match literal con otros planes (TDA compara por igualdad)
- **1 plan = 1 historia** · no mezclar
- **Slice vertical** · cubrir DB + BE + FE + Tests (o justificar si alguna falta)

## Integración con pipeline

```
/user-story-builder → stories.md (N historias)
         ↓
Por cada historia:
    /story-to-plan → plan-Hi.md   ← SOY ACÁ
         ↓
N plan-Hi.md consolidados
         ↓
/task-dependency-analyzer → DAG + JSON Agents Kanban
         ↓
[Agentes ejecutan · branches · PRs]
         ↓
/code-review
```

## Cuándo NO usarme

- No hay historia INVEST clara · corré `/user-story-builder` primero
- Falta CLAUDE.md · violaste V3 · resolvé primero
- La historia es épico · dividila
- Querés DAG macro entre varias historias · eso es TDA directo

## Relación con otras skills

| Skill | Relación |
|---|---|
| `/user-story-builder` | Produce el input que yo consumo (historias INVEST) |
| `/task-dependency-analyzer` | Consume mis planes · genera DAG + JSON |
| `/contract-define` | Produce `api-contract.md` que yo consumo |
| `/rfc-to-adr` | Produce los ADRs que yo consumo |
| `/code-review` | Valida que el código cumplió con mi plan |

## Limitaciones

1. **No analizo dependencias** · solo declaro · el análisis es de TDA
2. **No genero DAG Mermaid** · tampoco TDA lo hace antes de este plan
3. **No ejecuto código** · solo planifico
4. **No invento governance** · si un ADR no existe · lo marco como gap
5. **1 historia por ejecución** · para múltiples corré en loop

## Autoría

- Autor: Juan Estrada
- Fecha: 2026-04-21
- Versión: 1.0.0
- Contexto: resuelve gap del pipeline SDD entre historias y ejecución · identificado con Pareja 7 del Taller 1
