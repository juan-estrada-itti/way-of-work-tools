# Glosario · términos del way of work

**Para qué sirve este archivo**
Cuando alguien en el equipo dice "ADR" o "historia INVEST" · que todos entendamos lo mismo.

Es la **diapositiva clave del taller** · 5 min de lectura · después los términos aparecen en todo el resto.

---

## Parte 1 · Tipos de proyecto

**Greenfield** · proyecto desde cero · no hay código, no hay usuarios, no hay deudas. Todo se decide.
_Ejemplo_ · el caso del taller (app de favoritos de skills) · academy cuando la imaginábamos en papel.

**Brownfield** · proyecto sobre sistema existente · código en producción, usuarios activos, deudas técnicas. Hay que entender antes de cambiar.
_Ejemplo_ · academy hoy · ittilab hoy · cualquier refactor o nueva feature sobre algo que ya anda.

> **En este iter** solo trabajamos **greenfield** · el brownfield viene en iter 4.

---

## Parte 2 · Artefactos del pipeline SDD

**Discovery** · exploración del problema antes de diseñar solución.
Responde · *¿quién tiene el problema? ¿qué tan doloroso es? ¿qué hacen hoy sin nuestra solución?*
Output típico · un doc de 1 página con 6 insights · producido con `/office-hours`.

**PRD · Product Requirements Document** · documento que dice QUÉ construir y POR QUÉ.
Responde · *¿qué problema resuelve? ¿qué métricas mueve? ¿quién es el usuario?*
NO responde · *¿cómo lo construyo?* (eso va en el RFC).
Output típico · 1-3 páginas · producido con `/create-prd`.

**RFC · Request For Comments** · propuesta técnica de CÓMO construir lo del PRD.
Responde · *¿qué stack? ¿qué patrón? ¿cómo resolvemos X?*
Si tiene más de 5 decisiones arquitectónicas · se parte en ADRs.
Output típico · 2-5 páginas · producido con `/rfc-builder`.

**ADR · Architecture Decision Record** · registro de UNA decisión arquitectónica.
Formato Nygard · Contexto · Decisión considerada · Decisión tomada · Consecuencias · Status.
Si una decisión cambia, se versiona solo ese ADR · no se rompe todo el RFC.
Output típico · 1 página por decisión · producido con `/rfc-to-adr`.

**Contrato API** · schema compartido entre frontend y backend · fuente de verdad.
Define endpoints, request/response shapes, error codes, eventos.
Permite que FE y BE trabajen en paralelo sin colisiones.
Output típico · `api-contract.md` + `data-model.md` + `events.md` · producido con `/contract-define`.

**Historia de usuario (INVEST)** · unidad de valor entregable al usuario.
- **I**ndependent · se puede desarrollar sola
- **N**egotiable · se puede conversar con el equipo
- **V**aluable · entrega valor visible al usuario
- **E**stimable · se puede estimar esfuerzo
- **S**mall · cabe en un sprint (o menos)
- **T**estable · se puede validar si está terminada

Formato típico · *"Como [rol] quiero [acción] para [beneficio]"* · producido con `/user-story-builder`.

**Task técnica (subtask)** · paso concreto de implementación · subdivisión de una historia.
_Ejemplo_ · "crear endpoint POST `/favorites`" · "agregar columna `is_favorite` a tabla `skills`" · "escribir test e2e del flujo favoritos".

Se generan en 2 niveles · no mezclar:

**Plan de ejecución (micro · vertical slice)** · producido con `/story-to-plan`
Toma UNA historia INVEST · la descompone en subtasks verticales (DB + BE + FE + Tests) · cada subtask declara qué consume (`consume:`) y qué produce (`produce:`) con namespaces fijos. Output: `plan-H<N>.md` con governance ya cargada (ADRs, contrato, CLAUDE.md).

**DAG macro (entre subtasks · todas las historias juntas)** · producido con `/task-dependency-analyzer`
Consume los `plan-H<N>.md` · analiza dependencias cruzadas (4 tipos: schema, interface, infra, lógica) · detecta falsas dependencias · genera grafo Mermaid con fases + critical path + JSON Agents Kanban con prompts ejecutables.

**Regla** · si solo tenés DAG sin plan · los subtasks son vagos · agentes no saben qué archivos tocar. Si solo tenés plan sin DAG · no sabés qué paralelizar. Se usan encadenados.

**PR · Pull Request** · cambio de código listo para review antes de merge.
Incluye · commits, descripción, tests corriendo, link a la historia que resuelve.

**Code Review** · revisión del PR contra PRD + RFC + Contrato + reglas del proyecto.
Valida · que el código cumple lo prometido en los specs · que no introduce deudas nuevas.
Producido con `/code-review`.

---

## Parte 3 · Conceptos del way of work

**SDD · Spec-Driven Development** · modelo donde las decisiones se documentan ANTES de codear.
Opuesto a · "tirar código y ver qué sale".
Por qué · alinea a 20 personas · reduce retrabajo · deja trazabilidad.

**Pipeline** · secuencia de fases · Discovery → PRD → RFC → ADRs → Contrato → Historias → Tasks → Code → Review.
Cada fase consume el output de la anterior · produce algo para la siguiente.

**Gate humano** · checkpoint antes de avanzar a la siguiente fase.
Quién lo hace · PM, líder, arquitecto · según el gate.
Por qué · prevenir errores caros temprano.

**Skill** · módulo instruccional portable que le explica al agente (Claude/Cursor) cómo hacer una tarea específica.
Formato · `SKILL.md` con frontmatter YAML + cuerpo en markdown.
Vive en · `~/.claude/skills/` (global) o `.claude/skills/` (por proyecto).

**Trigger** · palabra o frase que activa una skill cuando el usuario la escribe.
_Ejemplo_ · `/rfc-builder` activa la skill `rfc-builder`.

**Pipeline greenfield** · el flujo de 7 skills del relay del taller · desde discovery hasta code review · sin fases de brownfield-discovery.

---

## Parte 4 · Del taller · roles y formato

**Pareja** · dos personas trabajando juntas en una fase del relay.
**Driver** · la que tiene las manos en el teclado, corre la skill, pega el output.
**Navigator** · la que no toca el teclado · valida, cuestiona, piensa el "por qué".
Ambos rotan roles si quieren · pero siempre hay uno solo tocando herramientas.

**Relay** · formato del taller · cada pareja hace UNA fase · pasa el output a la siguiente pareja.
Tiempo por pareja · 7 min de onset · 10 min de ejecución · 2 min de show & tell.

**Show & tell** · al final de cada fase · la pareja cuenta en 1-2 frases *"lo que más nos sorprendió fue ___"*.

**Des-conferencia** · formato del taller general · reglas → demo → juego → teoría al final · opuesto a clase magistral.

---

## Parte 5 · Vocabulario del equipo (no consultor)

Decir así | No decir así
---|---
way of work | proceso · metodología · framework
iniciativa | proyecto · producto · cuenta
pareja · driver · navigator | estudiante · alumno · equipo
relay | ejercicio · dinámica · actividad
skill | comando · macro · template
greenfield / brownfield | proyecto nuevo / proyecto existente (ok, pero preferimos en inglés)
fase | paso · etapa · stage
handoff | entrega · pase · traspaso
artefacto | entregable · documento · deliverable
gate | revisión · check · aprobación
discovery | investigación · research · exploración (greenfield)

---

## Cómo usar este glosario mañana

1. **Al abrir el taller** · proyectás la parte 1 y 2 en una slide · 3 min de lectura
2. **Durante el relay** · si alguien pregunta "¿qué es un ADR?" · apuntás acá
3. **Después del taller** · queda como referencia para todas las iniciativas futuras

---

**Última actualización** · 2026-04-21 · Juan Estrada
