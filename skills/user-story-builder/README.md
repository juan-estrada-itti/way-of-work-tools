# User Story Builder

Construye, evalúa y mejora historias de usuario siguiendo principios INVEST.

Build, evaluate, and improve user stories following INVEST principles.

## Qué hace / What it does

Tres modos de operación:

- **Crear** — Genera historias nuevas con formato Como/Quiero/Para, criterios de aceptación verificables, y notas técnicas opcionales
- **Evaluar** — Analiza historias existentes con diagnóstico INVEST (✅/⚠️/❌) y propone mejoras concretas
- **Dividir** — Parte historias grandes en slices verticales independientes por flujo, CRUD, regla de negocio, plataforma o rol

## Integración con Jira

Si tenés herramientas de Jira conectadas, la skill puede:

- Crear historias directamente en tu proyecto Jira
- Leer historias existentes y evaluarlas
- Actualizar descripciones con las mejoras propuestas
- Dividir historias creando las hijas vinculadas al mismo epic

## Cuándo usarla / When to use it

- En sesiones de refinamiento de backlog
- Al crear nuevas historias desde ideas o requerimientos
- Cuando una historia es demasiado grande para un sprint
- Para mejorar la calidad de historias antes de sprint planning

## Triggers

- "historia de usuario", "user story"
- "criterios de aceptación", "acceptance criteria"
- "INVEST", "story splitting", "refinamiento", "backlog grooming"

## Ejemplo / Example

```
> Creame una historia de usuario para que un admin pueda exportar reportes de ventas mensuales en PDF
```

```
> Evaluá esta historia: "Como usuario quiero poder hacer cosas con mi cuenta para mejorar mi experiencia"
```

## Skills relacionadas / Related skills

- `sdd-prd-builder` — Genera el PRD con las user stories iniciales
- `prd-slice` — Parte PRDs grandes en vertical slices
- `rfc-builder` — Genera el RFC técnico desde las user stories
