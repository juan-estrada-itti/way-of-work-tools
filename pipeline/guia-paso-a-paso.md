# Guía paso a paso · arrancar una iniciativa greenfield

**Para qué sirve**
Vos tenés una idea nueva · querés convertirla en código · no sabés por dónde empezar.
Esta guía te lleva desde *"tengo una idea"* hasta *"tengo el primer PR en review"* · sin saltos.

**Tiempo total estimado** · 1-3 semanas calendario · 30-60 horas de trabajo efectivo (depende del tamaño del feature).

---

## Antes de empezar · check de greenfield

Contesta estas preguntas · si todas dan **sí**, es greenfield y podés seguir esta guía:

- [ ] ¿No hay código previo que implemente esto o algo similar?
- [ ] ¿No hay usuarios usando hoy una versión actual del feature?
- [ ] ¿No estás sobre un repo existente (academy, ittilab, etc.)?

> Si alguna da **no** · es **brownfield** · usá `shared_knowledge_iter_4/` (cuando exista) o hablá con un arquitecto antes de arrancar.

---

## Paso 0 · Crear el repo de la iniciativa

```bash
mkdir mi-iniciativa
cd mi-iniciativa
git init
```

Estructura sugerida (la vas creando a medida que avanzás):

```
mi-iniciativa/
├── CLAUDE.md                    ← convenciones del repo · obligatorio (V3)
├── docs/
│   ├── 00-discovery/
│   │   └── discovery.md
│   ├── 01-prd/
│   │   └── prd.md
│   ├── 02-rfc/
│   │   └── rfc.md
│   ├── 03-contracts/
│   │   ├── api-contract.md
│   │   ├── data-model.md
│   │   └── events.md
│   ├── 04-adrs/
│   │   ├── ADR-INDEX.md
│   │   └── ADR-001-*.md
│   └── 05-stories/
│       ├── stories.md
│       └── tasks.md
└── src/                         ← código · aparece en Paso 8
```

---

## Paso 1 · Discovery · ¿el problema vale la pena?

**Skill** · `/office-hours` (modo startup)

```
cd mi-iniciativa
claude

> /office-hours
```

La skill te hace **6 preguntas forzadas**:
1. ¿Quién tiene este problema hoy y qué tan doloroso es?
2. ¿Qué hacen hoy sin nuestra solución?
3. ¿Qué es lo más específico y desesperado del problema?
4. ¿Cuál es el wedge más angosto por donde entrar?
5. ¿Qué has observado (no hipotetizado) directamente?
6. ¿Cómo se ve esto en 3 años si funciona?

**Output** · `docs/00-discovery/discovery.md`

**Gate 1** · Mostrale el discovery a un líder de producto · si te dice "mejor hacé otra cosa", parás acá.

---

## Paso 2 · PRD · ¿qué construimos?

**Skill** · `/create-prd`

```bash
> /create-prd
# pegás el discovery como contexto
```

La skill te arma:
- Problema + métrica de éxito
- Usuario target
- Casos de uso (3-5)
- Fuera de alcance
- Criterios de aceptación de alto nivel

**Output** · `docs/01-prd/prd.md`

**Gate 2** · Líder de producto valida scope · ojo: este PRD **no puede ser reducido** por el PRD técnico después (V1).

---

## Paso 3 · RFC · ¿cómo lo construimos?

**Skill** · `/rfc-builder`

```bash
> /rfc-builder
# le pasás el path del prd.md
```

La skill te arma:
- Contexto técnico
- Opciones consideradas (2-3)
- Decisión técnica recomendada
- Arquitectura propuesta (diagramas)
- Consideraciones (performance, seguridad, escalabilidad)

**Output** · `docs/02-rfc/rfc.md`

**Check rápido** · contá las decisiones arquitectónicas explícitas del RFC. Si son **más de 5**, andá al Paso 4 (ADRs) · si son menos, podés saltarte al Paso 5.

---

## Paso 4 · ADRs · decisión por decisión (si aplica V4)

**Skill** · `/rfc-to-adr`

```bash
> /rfc-to-adr
# le pasás el rfc.md
```

La skill:
1. Lee el RFC
2. Extrae las decisiones arquitectónicas
3. Genera 1 ADR por decisión · formato Nygard
4. Marca cuáles necesitan PoC antes de implementar
5. Crea `ADR-INDEX.md` con tabla resumen

**Output** · `docs/04-adrs/ADR-001-*.md` · `ADR-INDEX.md`

**Gate 3** · Arquitectos revisan los ADRs · marcan como `Accepted` los que están listos · identifican los que requieren spike/PoC.

---

## Paso 5 · Contrato API · el puente FE/BE

**Skill** · `/contract-define`

```bash
> /contract-define
# le pasás prd + rfc + ADRs
```

La skill genera:
- Endpoints REST/GraphQL
- Request/response schemas
- Error codes
- Eventos (si el sistema los tiene)

**Output** · `docs/03-contracts/api-contract.md` · `data-model.md` · `events.md`

**Gate 4** · FE + BE revisan el contrato **antes** de codear · si lo aprueban, pueden trabajar en paralelo desde acá.

---

## Paso 6 · Historias de usuario · INVEST

**Skill** · `/user-story-builder`

```bash
> /user-story-builder
# le pasás contrato + prd
```

La skill te arma historias que cumplen los 6 criterios INVEST:
- Independent · no depende de otras
- Negotiable · se puede conversar
- Valuable · entrega valor al usuario
- Estimable · se puede estimar
- Small · cabe en un sprint
- Testable · se puede validar

**Output** · `docs/05-stories/stories.md`

---

## Paso 7 · Tasks técnicas + DAG de dependencias

**Skill** · `/task-dependency-analyzer`

```bash
> /task-dependency-analyzer
# le pasás las historias
```

La skill:
1. Descompone cada historia en tasks concretas
2. Identifica dependencias entre tasks
3. Arma un grafo Mermaid (DAG)
4. Marca el camino crítico
5. Muestra qué tasks se pueden hacer en paralelo

**Output** · `docs/05-stories/tasks.md` + diagrama Mermaid

**Gate 5** · Tech lead valida el grafo · acuerda qué se hace primero y quién toma cada task.

---

## Paso 8 · Código · construir las tasks

**Herramienta** · Claude Code, Cursor, o Copilot · lo que prefiera cada developer.

Por cada task del DAG:
1. Creás una branch · `git checkout -b task/<slug>`
2. Implementás la task
3. Tests unitarios mínimos
4. Commit con referencia a la task
5. PR · el título cita la historia · el body cita la task

**Output** · commits + PR

---

## Paso 9 · Code review antes de merge

**Skill** · `/code-review`

```bash
# en la branch del PR
> /code-review
# le pasás el PR + los specs previos
```

La skill revisa el PR contra:
- PRD · ¿cumple lo prometido?
- RFC · ¿respeta la arquitectura?
- Contrato · ¿respeta el API?
- CLAUDE.md · ¿respeta convenciones del repo?

**Output** · `review.md` · *"apto para merge"* o *"cambios requeridos"*.

**Gate 6** · Revisor humano confirma · mergea.

---

## Check rápido · ¿hice bien el pipeline?

Al final de cada iteración, mirá el repo. Si tenés estos archivos en orden, lo hiciste bien:

```
docs/
├── 00-discovery/discovery.md       ✓
├── 01-prd/prd.md                   ✓
├── 02-rfc/rfc.md                   ✓
├── 04-adrs/ADR-INDEX.md            ✓ (si aplica)
├── 03-contracts/api-contract.md    ✓
└── 05-stories/stories.md           ✓
    └── tasks.md                    ✓
```

Más `CLAUDE.md` en la raíz (convenciones del repo).

Si te falta alguno · probablemente saltaste una fase · volvé al diagrama en `01-pipeline-greenfield.md`.

---

## Cómo adaptar esto a tu iniciativa

**Iniciativa chica (1-2 semanas)** · fases 1-5 compresas (1 día total), fases 6-9 son el grueso.

**Iniciativa mediana (3-6 semanas)** · cada fase se respeta en tiempo completo · gates formales.

**Iniciativa grande (>6 semanas)** · probablemente conviene **slicear el PRD** en 2-3 entregas usando `/prd-slice` y hacer mini-pipelines paralelos.

---

## Errores comunes (y cómo evitarlos)

| Error | Síntoma | Cómo evitarlo |
|---|---|---|
| Saltar discovery | el PRD tiene 10 casos de uso sin evidencia | `/office-hours` antes de nada, siempre |
| PRD técnico reduce alcance | "esto no lo hacemos porque es difícil" | V1 · el técnico agrega rigor, no quita scope |
| RFC con 10 decisiones mezcladas | cuando cambia una, se rompe todo | V4 · partir en ADRs con `/rfc-to-adr` |
| Contrato después del código | FE y BE trabajan desalineados | Contrato **antes** de codear · es el gate 4 |
| Historias no-INVEST | historias gigantes, no estimables | `/user-story-builder` siempre · rebota si no cumple INVEST |
| Merge sin review contra specs | PR aprobado pero no cumple el PRD | `/code-review` con specs como input · no solo "eye-ball" |

---

**Última actualización** · 2026-04-21 · Juan Estrada
