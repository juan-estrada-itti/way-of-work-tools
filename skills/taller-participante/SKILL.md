---
name: taller-participante
description: "Guía para los 16 participantes del Taller 1 Relay SDD · te dice qué hacer en tu fase asignada (1-8), qué skill correr, dónde leer el input de la pareja anterior, dónde pegar tu output, y cómo armar tu frase para el show & tell. Use when: sos participante del taller, te tocó una fase del relay, necesitás saber qué skill usar, querés la plantilla de output, o te trabaste en tu fase. Triggers: 'soy pareja', 'me tocó fase', 'qué hago en el taller', 'taller sdd', 'ayuda en el relay', 'mi fase del taller', 'qué skill uso ahora', 'show and tell', 'input del taller', 'taller-participante'."
version: 1.0.0
triggers:
  - soy pareja
  - me tocó fase
  - qué hago en el taller
  - taller sdd
  - ayuda en el relay
  - mi fase del taller
  - qué skill uso ahora
  - show and tell
  - show & tell
  - input del taller
  - taller-participante
  - participo en el taller
---

# Taller Participante · Guía del Relay SDD

Sos una de las 16 personas que participa del Taller 1 · Relay SDD end-to-end.
Tu pareja tiene UNA fase asignada del pipeline SDD. Yo te guío:

1. Qué input tenés que leer (del equipo anterior)
2. Qué skill correr (con el comando exacto)
3. Qué output producir (con plantilla)
4. Dónde pegar tu output (Google Doc · sección de tu pareja)
5. Cómo armar la frase para el show & tell

**Tiempo activo de tu pareja:** 15 minutos.

## Cómo arrancamos

Preguntame primero:

### Pregunta única · ¿qué pareja sos?

a) **Pareja 1** · Discovery (Juan Manuel + Stephany)
b) **Pareja 2** · PRD (Sergio + Javier)
c) **Pareja 3** · RFC (Fede + Andrés)
d) **Pareja 4** · ADRs (Hugo + Juan Pablo)
e) **Pareja 5** · Contratos (Luciano + Ana María)
f) **Pareja 6** · User Stories (Leonardo + Carlos)
g) **Pareja 7** · Tasks (Nicolás Canese + Cóppola)
h) **Pareja 8** · Code Review (German + Fernando)
i) **No sé cuál es mi pareja** → te ayudo a identificarla

Con esa respuesta te paso la guía específica de tu fase.

---

## Guías por fase

### Pareja 1 · Discovery

**Juan lo hace en vivo · vos no tenés que hacer nada acá.** Prestá atención a la demo.

Tu pareja (Juan Manuel + Stephany) arranca en la Fase 2 · PRD. Saltá a la guía de Pareja 2.

---

### Pareja 2 · PRD Negocio (15 min)

**Driver:** Juan Manuel Salazar · **Navigator:** Stephany Rivera
**Skill:** `/create-prd`
**Input:** Discovery que hizo Juan en vivo · lo pegó en el Google Doc sección "Fase 1"
**Output va en:** Google Doc sección "Fase 2 · PRD Negocio"

#### Paso 1 · Leer el input (2 min)

Abrí el Google Doc compartido · buscá la sección "FASE 1 · DISCOVERY" · leé el discovery.md.

#### Paso 2 · Correr la skill (10 min)

En Claude Code tipeá:

```
/create-prd

Input · tengo este discovery de la Fase 1:

[PEGAR el contenido del discovery.md]

Generá el PRD de negocio basado en esto.
```

Claude te va a hacer preguntas. Respondelas con lo que venga del discovery.

#### Paso 3 · Pegar output (2 min)

Copiá el PRD generado · pegalo en la sección "FASE 2 · PRD NEGOCIO" del Google Doc.

#### Paso 4 · Frase para show & tell (1 min)

Escribí en el Doc, al final de tu sección:

> Lo que más nos sorprendió fue: ___________

Ejemplos posibles:
- "Cuán rápido se arma un PRD estructurado vs hacerlo a mano"
- "Cuántas preguntas hace la skill que no habíamos pensado"
- "Que el JTBD salió clarísimo del discovery"

#### Si te trabás

1. Revisá `~/.claude/skills/create-prd/SKILL.md` · ahí está cómo funciona
2. Si Claude te pregunta algo del discovery que no tenés · poné `[TBD]` y seguí
3. Si no tenés Claude Code corriendo · Stephany avisame en chat y yo (Juan Manuel) ejecuto

---

### Pareja 3 · RFC Técnico (15 min)

**Driver:** Sergio Amarilla · **Navigator:** Javier Durán
**Skill:** `/rfc-builder`
**Input:** PRD de Pareja 2 · en el Google Doc sección "Fase 2"
**Output va en:** Google Doc sección "Fase 3 · RFC Técnico"

#### Paso 1 · Leer el input (2 min)

Leé el PRD completo · particular atención a user stories de alto nivel y scope.

#### Paso 2 · Correr la skill (10 min)

En Claude Code:

```
/rfc-builder

Input · tengo este PRD:

[PEGAR el contenido del PRD]

Arrancá la discovery del RFC. Stack sugerido: Node.js + Express + SQLite (ver repo del taller).
```

Claude te va a hacer 5-6 preguntas de discovery (problema, trigger, scope, success criteria, constraints, codebase).

#### Paso 3 · Completar las secciones (5 min)

El RFC típicamente tiene:
- Current state
- Propuesta técnica
- Trade-offs
- Testing strategy
- Rollout plan

Si algo no te queda claro, poné `[TBD con pareja siguiente]`.

#### Paso 4 · Pegar output + frase show & tell

Copiá al Doc · sección "Fase 3 · RFC Técnico".

**Ejemplos de frase show & tell:**
- "El RFC salió más acotado que los que escribimos normal · la skill corta la divagación"
- "Nos hizo explicitar trade-offs que solemos dejar implícitos"

#### Testimonio de Javier (si aplica)

Si Juan te pregunta durante el show & tell, Javier da 30 segundos sobre el caso ulab.

---

### Pareja 4 · ADRs (15 min)

**Driver:** Fede Correa · **Navigator:** Andrés López
**Skill:** Template manual (no hay skill dedicada aún)
**Input:** RFC de Pareja 3 · Google Doc sección "Fase 3"
**Output va en:** Google Doc sección "Fase 4 · ADRs"

#### Paso 1 · Leer el RFC (3 min)

Identificá **las decisiones arquitectónicas implícitas** en el RFC. Ejemplos típicos:
- ¿SQLite o Postgres?
- ¿Auth mínima o robusta?
- ¿REST o GraphQL?
- ¿SPA o server-rendered?

Elegí 1-3 decisiones. No más.

#### Paso 2 · Escribir cada ADR (10 min)

Usá el formato Nygard:

```
# ADR-00X · [Título en imperativo]

## Contexto
[Por qué esta decisión es necesaria · 2-3 frases]

## Decisión
[Qué decidimos · 1 frase clara]

## Consecuencias

Positivas:
- [item 1]
- [item 2]

Negativas:
- [item 1]
- [item 2]

## Status
Accepted
```

#### Paso 3 · Pegar + frase (2 min)

Copiá los ADRs al Doc.

**Ejemplos de frase show & tell:**
- "Haber hecho ADRs explícitos nos obligó a ver trade-offs que el RFC daba por sentados"
- "Con ADRs no hay 'magia' · cada decisión está documentada"

#### Si te trabás

Si no encontrás 3 decisiones para documentar, con UNA alcanza. El punto es aprender el formato, no saturar.

---

### Pareja 5 · Contratos API (15 min)

**Driver:** Hugo Escobar · **Navigator:** Juan Pablo Fernández
**Skill:** `/contract-define`
**Input:** RFC (Fase 3) + ADRs (Fase 4) · Google Doc
**Output va en:** Google Doc sección "Fase 5 · Contratos"

#### Paso 1 · Leer input (3 min)

RFC te dice la arquitectura · ADRs te dicen decisiones clave. Con ambos armás los contratos.

#### Paso 2 · Correr la skill (10 min)

```
/contract-define

Input:
- RFC: [pegar resumen]
- ADRs relevantes: [pegar resumen]
- Stack: Node.js + Express + SQLite

Generá:
- api-contract.md · endpoints con method, path, request, response, errors
- data-model.md · entidades compartidas con SQL + TypeScript types
- events.md (si aplica)
- flows.md · sequence diagram Mermaid del happy path
```

#### Paso 3 · Revisar + pegar (2 min)

Chequeá que los contratos incluyen el MVP del PRD:
- Endpoints para marcar favorita
- Endpoint para listar favoritas
- Tabla en DB

Pegá los 4 archivos al Doc.

**Ejemplos de frase show & tell:**
- "Sin contratos definidos, FE y BE habrían hecho cosas distintas sin saberlo"
- "El sequence diagram Mermaid fue gratis · normalmente lo dibujás 30 min en Miro"

---

### Pareja 6 · User Stories (15 min)

**Driver:** Luciano Pérez · **Navigator:** Ana María Villegas
**Skill:** `/user-story-builder`
**Input:** Todo lo anterior (PRD + RFC + ADRs + Contratos)
**Output va en:** Google Doc sección "Fase 6 · User Stories"

#### Paso 1 · Leer inputs (3 min)

Leé en este orden:
1. PRD (Fase 2) · para user stories de alto nivel
2. Contratos (Fase 5) · para saber qué endpoints existen
3. RFC (Fase 3) · para constraints

#### Paso 2 · Correr la skill (10 min)

```
/user-story-builder

Input:
- PRD: [pegar]
- Contratos: [pegar api-contract]

Genera 4-6 historias INVEST con Given-When-Then, edge cases, definition of done.
```

#### Paso 3 · Pegar + rol único de Ana María

Luciano pega las historias. **Ana María** aporta mirada única:
- ¿Son historias que entendería alguien nuevo?
- ¿El lenguaje es humano o muy técnico?
- ¿Qué edge case de adopción falta? (ej: "qué pasa si es mi primera vez")

Ana · **si Juan te llama en el show & tell**, compartí 1 observación de cambio organizacional.

**Ejemplos de frase show & tell:**
- "Las historias salieron con Given-When-Then completo · normalmente nos faltan"
- "Ana observó que una historia estaba escrita asumiendo contexto que un usuario nuevo no tiene"

---

### Pareja 7 · Tasks (15 min)

**Driver:** Leonardo Villa · **Navigator:** Carlos Espinosa
**Skill:** `/task-dependency-analyzer`
**Input:** User Stories (Fase 6)
**Output va en:** Google Doc sección "Fase 7 · Tasks"

#### Paso 1 · Leer input (2 min)

Leé las historias. Identificá cuáles dependen de cuáles.

#### Paso 2 · Correr la skill (10 min)

```
/task-dependency-analyzer

Input · user stories:
[pegar stories]

Generá DAG Mermaid + subtasks por categoría (Backend, Frontend, DB, Tests) con dependencias explícitas y ruta crítica.
```

#### Paso 3 · Validar + pegar (3 min)

Chequeá que:
- Hay subtasks de DB (crear tabla)
- Hay subtasks de Backend (endpoints)
- Hay subtasks de Frontend (UI)
- Hay subtasks de Tests

Si falta alguna categoría, sumala manualmente.

**Ejemplos de frase show & tell:**
- "El DAG Mermaid nos ahorró 20 min de whiteboard"
- "La ruta crítica saltó obvia · habíamos subestimado la DB"

---

### Pareja 8 · Code Review (15 min)

**Driver:** German Insuasty · **Navigator:** Fernando López
**Skill:** `/code-review`
**Input:** PR abierto por la Pareja 7 (código) en el repo del taller
**Output va en:** Google Doc sección "Fase 8 · Code Review"

#### Paso 1 · Esperar a que el PR exista

La Pareja 7 (código) abre un PR al repo. Cuando esté abierto, arrancan ustedes.

#### Paso 2 · Correr la skill (12 min)

```
/code-review

PR a revisar: https://github.com/ittidigital/tech_emergentes_skills_taller_1/pull/[N]

Artefactos upstream en el repo:
- docs/02-prd/prd-negocio.md
- docs/03-rfc/rfc.md
- docs/04-adrs/
- docs/05-contracts/
- docs/06-stories/stories.md
- docs/07-tasks/tasks.md

Ejecutá los 6 pasos del pipeline code-review.
```

Claude va a chequear:
1. Discovery inverso (PR vs RFC)
2. PRD traceability (ACs vs tests)
3. Contract compliance (endpoints vs api-contract)
4. Project rules (vs CLAUDE.md)
5. Cross-validation
6. Scope check

#### Paso 3 · Pegar resultado (3 min)

Pegá el review al Google Doc · incluí:
- Blockers (si hay)
- Warnings
- Info
- Recomendación final (aprobar / pedir cambios)

**Ejemplos de frase show & tell:**
- "La skill encontró X blockers que review humano podría haberse perdido"
- "El cruce con el PRD expuso una historia sin cobertura de tests"

---

## Cómo trabajamos en pareja

### Rol del Driver (con Claude Code / herramientas)

- Comparte pantalla
- Tipea los comandos
- Ejecuta la skill
- Pega el output en el Google Doc

### Rol del Navigator (con preguntas)

- Lee el input antes que el driver
- Hace preguntas durante la ejecución ("¿esto está bien?" "¿qué pasa si...?")
- Cuida que el output tenga todas las secciones
- Escribe la frase del show & tell

## Reglas comunes

1. **15 minutos máximo** por fase · si te pasás, Alejo te avisa
2. **No pulas** · produce algo imperfecto · la pareja siguiente puede ajustarlo
3. **Si te trabás >5 min** · avisá en el chat del Meet · Alejo pega plantilla backup
4. **Siempre dejá output en el Doc** · aunque sea el template vacío con notas
5. **Siempre escribí la frase del show & tell** · es lo que queda después

## Show & Tell

**Al final**, 4 parejas comparten (no las 8 · no alcanza el tiempo).

Si tu pareja es elegida:
- 3 minutos · responden 3 preguntas:
  1. ¿Qué input recibieron?
  2. ¿Qué produjeron?
  3. ¿Qué les sorprendió?

No tenés que decir todo lo técnico · 1 frase por pregunta alcanza.

## Si el taller se cae (plan B)

- Si Claude Code no anda · usá Cursor o Copilot con la misma skill · el formato SKILL.md es portable
- Si la skill no se activa · pedí en el chat que Alejo te pegue la plantilla mínima
- Si el Google Doc colapsa · escribí tu output en el chat de Meet general con prefijo `[PAREJA X · FASE Y]`

## Reglas de esta guía (no negociables)

- **Una pareja a la vez** · primero identifico qué pareja sos · después te paso la guía específica
- **No hago el trabajo** · te guío · la pareja lo hace
- **Tiempos honestos** · 15 min son 15, no 8
- **Si te confunde la guía** · preguntame directo · arranco de nuevo con más simple

## Evolución

| Versión | Fecha | Cambios |
|---|---|---|
| v1.0 (esta) | 2026-04-20 | Guía para los 16 participantes del Taller 1 del 21/4 · 8 fases · comandos y plantillas específicas por pareja |
| v1.1 | Post-taller | Aprendizajes del taller ejecutado · ajustes a plantillas · cambios detectados |
