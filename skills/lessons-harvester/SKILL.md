---
name: lessons-harvester
description: "Captura automáticamente las lecciones aprendidas (lessons.md) cada vez que hay intervención humana en el pipeline SDD. Detecta los puntos donde un humano tuvo que editar, revisar o corregir artefactos generados por skills, y los convierte en lecciones L-XXX con trigger + impacto + acción. Use when: termina una iteración del pipeline SDD (ulab, academy, ittilab, cualquier iniciativa), cuando se mergea un batch de PRs del pipeline, cuando hay cierre de epic en Jira, o cuando el usuario pide 'retrospectiva del proceso', 'lecciones aprendidas', 'qué aprendimos', 'lessons.md', 'human in the loop feedback', 'capturar aprendizajes', 'cerrar iteración'. Bilingual ES/EN."
version: 1.0.0
triggers:
  - lessons
  - lessons harvester
  - capturar lecciones
  - lecciones aprendidas
  - que aprendimos
  - retrospectiva del proceso
  - cerrar iteración
  - human in the loop feedback
  - harvest lessons
  - lessons.md
---

# Lessons Harvester

Convierte las intervenciones humanas en el pipeline SDD en lecciones capturadas automáticamente. Cada vez que un humano edita un artefacto generado por skills, responde a un comentario de Confluence, resuelve un finding de cross-validate, o corrige un PR, eso es una **señal** de que el pipeline no está cubriendo algo. Esta skill convierte esas señales en lessons estructuradas que el siguiente equipo (o iteración) no repite.

## Por qué esta skill existe

En el caso ulab (AI Issue Generator, PRD 3.0.1), Juan Diego escribió 18 lecciones a mano al final de 10 días. Costó 4-6 horas y quedó atomic porque una persona específica lo hizo. En el caso academy AppSec Q1 2026, se capturaron 21 lecciones — también manuales.

El problema: academy o el tercer equipo que venga no va a escribir su retro si lleva 4-6 horas. Sin retro capturada, los mismos errores se repiten. **Esta skill automatiza la captura** preservando el formato y el rigor de las retros manuales.

**Principio central:** no inventa lessons. Solo captura lo que efectivamente pasó, con evidencia trazable (diff de versiones, comentario de Confluence, commit específico, issue de GitHub, etc.).

## Cuándo usar

- Al cerrar una iteración del pipeline SDD (después de mergear todos los PRs de esa iteración).
- Cuando un epic en Jira se cierra.
- Cuando hay cambio grande en un artefacto del pipeline (ej: PRD v5 → v6, RFC v2 → v3).
- Al final de un sprint que usó skills del way of work.
- Cuando el usuario pide retrospectiva o lessons explícitamente.

## Cuándo NO usar

- Al principio de una iteración (todavía no hay qué capturar).
- Si el trabajo no pasó por el pipeline SDD (ej: solo fue código directo sin PRD/RFC).
- Si no hay acceso a los artefactos (specs, commits, comentarios).

## Inputs requeridos

| Input | Requerido | Descripción |
|---|---|---|
| Carpeta de specs | Sí | Path a la carpeta con los artefactos del pipeline (ej: `specs/iteration-3/`). Debe tener versiones múltiples si aplica (v1, v2, v3). |
| Tipo de iteración | Sí | `greenfield` (primera iteración) o `brownfield` (iteración sobre producto existente). |
| Nombre del caso / iniciativa | Sí | Ej: "AppSec Q1 2026", "ulab iter 3", "academy certificados". Para titular el lessons.md. |
| Previous lessons.md | No | Path al archivo de lessons anterior (si aplica). La skill **append**, no sobrescribe. |
| Confluence space + page ID | No | Si el PRD de negocio vive en Confluence, usar MCP para leer comentarios resueltos (L-011 ulab: comments resolved también son input). |
| Jira epic key | No | Si aplica. Para obtener los tickets ejecutados y cruzar con commits. |
| Autor / experto validador | Sí | Nombre del humano que va a revisar y aprobar cada lesson antes de escribirla al archivo (human in the loop de la skill misma). |

## Workflow en 4 fases

### Fase 1 · Discovery de inputs

Antes de escribir nada, verificá qué tenés disponible:

1. Leé la carpeta de specs completa. Listá todos los archivos con sufijos de versión (`-v1.md`, `-v2.md`, `-v3.md`).
2. Chequeá si hay `progress.md` o `retrospectiva-*.md` en la misma carpeta (podés extraer notas que el equipo dejó).
3. Si hay Confluence page + MCP disponible, leé los comentarios (open, resolved, inline). Cada comentario que gatilló un cambio es un candidato a lesson.
4. Si hay acceso al repo de código, leé el `git log --grep="Skill-Used:"` y los merge commits con labels de la iteración.
5. Confirmá con el usuario qué inputs encontraste y cuáles no están disponibles. No alucines — si un input crítico falta, decilo.

### Fase 2 · Análisis de cambios entre versiones

Para cada artefacto con múltiples versiones (PRD, RFC, contracts):

1. **Diff v1 → v2 → v3.** Extraé qué cambió en cada salto.
2. **Clasificá cada cambio en una de estas categorías:**
   - **Scope shift** — se agregó, se quitó o se movió alcance (ej: US-006 desapareció en v3 → L-010 ulab)
   - **Technical discovery** — se descubrió un patrón o constraint del sistema que no estaba en el input (ej: dual JWT → L-005 academy)
   - **Naming / framing** — se renombró un componente o concepto (ej: SpecKit → PRD Extractor → L-006 ulab)
   - **Process gap** — el pipeline hizo algo mal o saltó un paso (ej: L-014 ulab: copiar local sin consultar Confluence)
   - **Tool gap** — algo que hubiera necesitado tooling y se hizo a mano (ej: L-015 ulab: verificación cross-refs manual)
   - **Skill gap** — una skill que no existe y debería (ej: L-016 academy: spec-engine no se usó)
3. Para cada cambio significativo, preparar un lesson candidato.

### Fase 3 · Análisis de intervenciones humanas explícitas

Más allá del diff de versiones, captura **signals de human-in-the-loop**:

- **Comentarios de Confluence que gatillaron cambios** (cada uno = 1 lesson candidato). Incluir tanto los open como los resolved (L-011 ulab).
- **PR comments que pidieron cambios** (si hay acceso a git/GitHub). Categoría typical: "convenciones del proyecto violadas".
- **Findings CRITICAL/HIGH del cross-validate** que requirieron edición manual vs. los auto-resueltos.
- **Commits de merge que resolvieron conflictos manualmente** (especialmente en `.gitignore`, shared schemas, configs — L-006 del agents-kanban).
- **Branches stale o worktrees fallidos** (si hay telemetría del executor — L-019, L-020 academy).

Cada una de estas intervenciones es un lesson candidato.

### Fase 4 · Redacción de lessons con validación humana

Para cada lesson candidato (output de Fases 2 y 3):

1. **Proponé un draft** al usuario con esta estructura:

```markdown
### L-XXX: [Título en una línea, acción imperativa o hallazgo]

**Problema:** [qué pasó, evidencia concreta — qué archivo cambió, qué comentario lo disparó]

**Causa raíz:** [por qué pasó — sin interpretación, basado en evidencia]

**Solución:** [qué se hizo (si se hizo) o qué debería hacerse]

**Clave:** [la lección atómica en 1 frase, reutilizable para futuros equipos]
```

2. **Pedí confirmación al humano** antes de escribirla al archivo. Opciones:
   - `aceptar` → va al lessons.md final con número consecutivo
   - `editar` → human propone cambios, se incorpora
   - `descartar` → no se incluye (registrar como rechazada en log interno)
   - `fusionar con L-YYY` → si es duplicada de una lesson previa

3. **Numerá secuencialmente.** Si ya existe `lessons.md`, continuá desde el último L-N. No reinicies.

4. **Agrupá por categoría** al final:
   - Del proceso SDD aplicado
   - Del análisis técnico
   - Del pipeline de review
   - De la ejecución con agentes (si aplica)
   - De integración con herramientas externas (Jira, GitHub, Confluence, IDE)

## Output

Archivo `lessons.md` con estructura:

```markdown
# [Nombre del caso]: Lessons Learned

> Lecciones del proceso [tipo: SDD / agentes / brownfield] aplicado a [iniciativa].
> Iteración: [ID / fecha rango]
> Fecha de captura: [YYYY-MM-DD]
> Autor validador: [nombre]

## Del proceso SDD aplicado

### L-001: [título]
...

## Del análisis técnico

### L-00X: [título]
...

## De la ejecución con agentes

### L-0XX: [título]
...

## Siguiente iteración

[Sección generada al final con recomendaciones:
- Skills que faltan y deberían priorizarse
- Convenciones a agregar a CLAUDE.md
- Scripts de automatización candidatos
- Ajustes al way of work]
```

Además genera un **log de decisiones** en `lessons-decisions.log`:

```
2026-05-15T14:32:00  L-001  accepted   [human: juan]
2026-05-15T14:33:14  candidate-7  rejected  reason: "no es reusable, muy específico"
2026-05-15T14:34:05  L-002  edited-by-human [cambio: reemplazó palabra "siempre" por "usualmente"]
...
```

## Reglas de validación

- [ ] Cada lesson tiene evidencia trazable (path a archivo, comentario, commit, ticket). Si no, **descartar**.
- [ ] El título de cada lesson es imperativo o hallazgo, no opinión (ej: "PRD técnico no reduce scope del PRD negocio" sí; "Es importante cuidar el scope" no).
- [ ] La sección "Clave" cabe en 1 frase reusable por futuros equipos.
- [ ] No duplicar lessons previas. Detectar similitud y proponer fusión.
- [ ] Agrupar por categoría. No mezclar proceso con ejecución.
- [ ] El output es append-only si hay lessons.md previo. Nunca sobrescribir.

## Negative constraints

- **No inventar lecciones.** Si no hay evidencia, no hay lesson. Preferí omitir que inventar.
- **No opinar sin evidencia.** Cada afirmación se respalda en algo concreto (diff, comment, commit).
- **No escribir al archivo sin validación humana.** El harvest es colaborativo — el humano valida cada lesson antes de persistirla.
- **No editar lessons previas.** Solo append. Si una lesson anterior era incorrecta, generar una nueva que la corrige con referencia (ej: "L-042 supersedes L-017 porque...").
- **No consolidar lecciones de múltiples iteraciones.** Cada ejecución del harvester es una iteración — separar claramente las fechas.
- **No exponer secretos.** Si en un diff aparece un path con credentials, flag al humano pero no lo copies al lessons.md.

## Validación de experto

Caso de referencia:
- **ulab retrospectiva-proceso-sdd.md** (18 lessons manuales) — el harvester debe poder reproducir ≥14 de esas 18 lessons correriendo sobre `/Users/juan.estrada/projects/sdd/ulab/specs/iteration-3/`.
- **academy case-appsec-q1-2026 lessons.md** (21 lessons manuales) — el harvester debe reproducir ≥16 de 21 lessons correriendo sobre `/Users/juan.estrada/projects/agents/docs/case-appsec-q1-2026/`.

Si el harvester omite >25% de las lessons del caso base, considerarlo un gap y mejorar con el experto del dominio.

## Ejemplo mínimo de uso

**Usuario:** "Terminamos iter 2 de academy. Vos me ayudas a capturar las lecciones."

**lessons-harvester:**
> Voy a buscar los inputs. ¿Me confirmás?
> - Carpeta de specs: `/Users/juan.estrada/projects/projects/itti_academy/specs/iter-2/`
> - Previous lessons.md: `/Users/juan.estrada/projects/projects/itti_academy/lessons.md` (encontré 12 lecciones previas, L-001 a L-012)
> - Confluence: veo comentarios en la página de academy iter 2 (5 comments resueltos, 2 open)
> - Jira epic: ACADEMY-42 con 8 subtasks
> - Autor validador: vos mismo (Juan Estrada) — ¿confirmás?

**Usuario:** "Sí, dale."

**lessons-harvester:**
> Fase 2 · analizando cambios entre versiones.
>
> Detecté 6 cambios significativos entre v1 y v3 del PRD, 3 entre v1 y v2 del RFC, y 2 en los contratos. Además, 5 comentarios de Confluence gatillaron cambios específicos.
>
> Total: 16 candidatos. Voy uno a uno. El primero:
>
> ```
> ### L-013: [DRAFT] El PRD técnico v2 eliminó el endpoint de export
> Problema: al generar el PRD técnico con sdd-prd-builder, el endpoint GET /certificados/export que estaba en el PRD negocio v1 desapareció en la versión técnica v2.
> Causa raíz: sdd-prd-builder no verificó exhaustivamente contra el PRD negocio (V1 no se aplicó).
> Solución: se agregó manualmente en v3 después del review del Experto Producto.
> Clave: sdd-prd-builder debe correr con una tabla de reconciliación explícita contra el PRD negocio.
> ```
>
> ¿Aceptar, editar, descartar o fusionar con L-010 (que dice algo similar del caso ulab)?

**Usuario:** "Fusionar con L-010 no, porque es otra iter. Aceptar tal cual."

**lessons-harvester:**
> Guardada como L-013 en academy/lessons.md. Siguiente candidato...

(continúa hasta los 16 candidatos)

**Al final:**
> Resumen:
> - 11 lessons aceptadas (L-013 a L-023)
> - 3 descartadas (evidencia insuficiente)
> - 2 fusionadas con lessons previas (L-005, L-008)
>
> Archivo actualizado: `/Users/juan.estrada/projects/projects/itti_academy/lessons.md`
> Log de decisiones: `/Users/juan.estrada/projects/projects/itti_academy/lessons-decisions.log`

## Seguridad

- No incluir credenciales en el output. Si aparecen paths con `.env` o `secret`, flagear pero no copiar valor.
- No ejecutar comandos del SO a menos que sea estrictamente necesario (solo lecturas).
- No escribir fuera de la carpeta de la iniciativa (no contaminar ni modificar `~/.claude/` ni repos ajenos).

## Evolución

| Versión | Fecha | Cambios |
|---|---|---|
| v1.0 (esta) | 2026-04-17 | MVP · lee specs + Confluence opcional + valida human-in-the-loop antes de persistir |
| v1.1 | Mes 2 | Integra con Jira MCP para leer tickets + comentarios de PRs automáticamente |
| v1.2 | Mes 3 | Integra con `iteration-state-loader` — las lessons capturadas alimentan el contexto de la siguiente iteración |
| v2.0 | Mes 4+ | Modo batch: corre automáticamente al cerrar un epic en Jira, sin trigger humano |

## Referencias

- `/Users/juan.estrada/projects/sdd/ulab/specs/iteration-3/retrospectiva-proceso-sdd.md` — 18 lessons caso ulab
- `/Users/juan.estrada/projects/agents/docs/case-appsec-q1-2026/lessons.md` — 21 lessons caso academy
- `~/projects/roadmap_modelo_operativo/aprendizajes-feedback.md` — 4 lessons extraídas de feedback del líder
