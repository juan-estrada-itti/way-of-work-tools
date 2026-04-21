# Roadmap de sesiones · el próximo mes

**Para qué sirve este archivo**
Mostrar al equipo **qué vamos a ver** en las 5 sesiones y **cómo se conectan entre sí** · para que no queden con la sensación de *"¿y ahora qué?"* al final del primer taller.

**Cuánto dura en el taller** · 10 min

---

## Las 5 sesiones · vista de águila

```
┌─────────────────────────────────────────────────────────────┐
│  Sesión 1 · HOY · 1h · onboarding                           │
│  Objetivo + metodología + glosario + herramientas + roadmap │
│  Resultado: todos con ambiente funcionando + lenguaje común │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  Sesión 2 · semana 2 · 2h · greenfield                      │
│  SDD en profundidad + ejercicio relay 8 parejas             │
│  Resultado: cada uno vivió 1 fase del pipeline en vivo      │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  Sesión 3 · semana 3 · 2h · brownfield                      │
│  Discovery sobre academy/ittilab + pipeline completo         │
│  Resultado: saben aplicar SDD a iniciativas en producción    │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  Sesión 4 · semana 4 · 1h · night shift + automatización    │
│  MCPs · agentes autónomos · DAG con --dangerously-skip-perm │
│  Resultado: saben dejar trabajo andando fuera de horario    │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  Sesión 5 · semana 5 · 2h · publicar + mejorar              │
│  Crear tu primer skill + PR al repo compartido              │
│  Resultado: el equipo pasa de consumir a contribuir         │
└─────────────────────────────────────────────────────────────┘
```

---

## Sesión 1 · hoy · 1h

**Estás acá.**

| Bloque | Duración |
|---|---|
| Setup mínimo | 10 min |
| Objetivo + metodología | 12 min |
| Glosario | 8 min |
| Herramientas + canales + demo | 15 min |
| Roadmap (este bloque) | 10 min |
| Cierre | 5 min |

**Qué te llevás** · ambiente funcionando · lenguaje común · claridad de lo que viene.

---

## Sesión 2 · greenfield · semana 2 · 2h

**Foco** · Spec-Driven Development aplicado a un proyecto desde cero.

### Agenda

| Bloque | Duración | Qué hacemos |
|---|---|---|
| Recap + preguntas de semana 1 | 10 min | *"qué pudieron aplicar · qué no"* |
| SDD en profundidad | 20 min | Las 4 reglas duras · los 6 gates · el pipeline |
| Ejercicio **relay greenfield** | 75 min | 8 parejas · 8 fases · proyecto "favoritos de skills" |
| Show & tell | 10 min | Cada pareja cuenta *"lo que más nos sorprendió fue..."* |
| Cierre + tarea | 5 min | Traer para sesión 3 · 1 idea de feature brownfield |

### Qué te llevás

- Experiencia hands-on del pipeline completo
- Artefactos reales (PRD · RFC · ADRs · contratos · historias · tasks · PR review) generados por el equipo
- Confianza para arrancar una iniciativa greenfield vos solo

---

## Sesión 3 · brownfield · semana 3 · 2h

**Foco** · aplicar SDD a iniciativas **sobre código existente** · academy · ittilab · futuros.

### Agenda

| Bloque | Duración | Qué hacemos |
|---|---|---|
| Recap + experiencias greenfield | 10 min | *"¿alguien ya aplicó el flujo a una iniciativa real?"* |
| **Por qué brownfield es distinto** | 15 min | Discovery del sistema existente · skills nuevas |
| Nuevas skills · `/journey-creator` + `/ddd-workshop-facilitator` + `/journey-ddd-evaluator` | 25 min | Demo + explicación |
| **Ejercicio sobre academy o ittilab** | 60 min | En parejas · aplican las 3 skills · encuentran bounded contexts |
| Show & tell | 10 min | Qué descubrimos del sistema |

### Qué te llevás

- Capacidad de arrancar una feature nueva sobre academy/ittilab **sin romper lo que hay**
- Skills de discovery brownfield instaladas y probadas
- Primer mapa de dominio de academy o ittilab · queda de referencia

---

## Sesión 4 · night shift · semana 4 · 1h

**Foco** · dejar agentes trabajando **fuera de horario**.

### Concepto

Si el DAG de tasks está bien armado y las skills saben qué hacer · podés dejar Claude Code corriendo de noche · resolviendo tasks autónomamente · a la mañana tenés PRs listos para review.

**Prerequisitos duros**
- DAG validado con humano (gate 4)
- CLAUDE.md completo (V3)
- Tests automáticos · si no, NO hagas night shift

### Agenda

| Bloque | Duración | Qué hacemos |
|---|---|---|
| Concepto · qué es · por qué · por qué es peligroso | 15 min | Ejemplos reales · casos de éxito · casos de desastre |
| MCPs · conectores con Jira · GitHub · Slack | 15 min | Demo de un MCP corriendo · actualiza Jira solo |
| Claude `--dangerously-skip-permissions` | 10 min | Cuándo usarlo · cuándo jamás usarlo · sandboxing con Docker |
| Armado de un **night shift chico** | 15 min | En pareja · cada uno arma 1 task autónoma · la corren · vemos resultados |
| Cierre + riesgos | 5 min | Guardrails obligatorios |

### Qué te llevás

- Entender cuándo SÍ y cuándo NO dejar agentes autónomos
- 1 MCP conectado a un servicio real
- 1 task ejecutada autónomamente · exitosa o fallida · aprendés igual

---

## Sesión 5 · publicar + mejorar · semana 5 · 2h

**Foco** · pasar de **consumir** skills a **contribuir** skills.

### Agenda

| Bloque | Duración | Qué hacemos |
|---|---|---|
| ¿Mejorar skills o mejorar outputs? | 20 min | Cuándo iterás la skill · cuándo ajustás solo el prompt |
| Anatomía de una skill · frontmatter · triggers · body | 20 min | Leer 2-3 skills propias del equipo |
| **Crear tu primera skill** · `/skill-creator` | 40 min | En parejas · cada pareja crea 1 skill nueva |
| PR al repo compartido · review en vivo | 30 min | Todos revisan 1 skill de otra pareja |
| Cierre + roadmap mes 2 | 10 min | Qué seguimos viendo · nuevos talleres |

### Qué te llevás

- 1 skill propia publicada en el repo del equipo
- Experiencia de review de skill · no solo de código
- Criterio para cuándo iterar la skill vs iterar el output

---

## Cómo se conectan las sesiones

| Para llegar a... | Necesitás haber pasado por... |
|---|---|
| Sesión 5 (publicar) | Sesiones 1-4 · conocés skills desde adentro |
| Sesión 4 (night shift) | Sesiones 1-3 · confías en que el DAG está bien |
| Sesión 3 (brownfield) | Sesiones 1-2 · dominás greenfield |
| Sesión 2 (greenfield) | Sesión 1 · tenés ambiente y lenguaje |

**Si faltás una sesión** · el video queda grabado + los docs de `shared_knowledge_iter_N/` · la recuperás en 1-2 hs de tu tiempo.

---

## Después del mes · qué viene

Al mes 2:
- **Retro abierta** · qué funcionó · qué ajustamos
- **Skills del equipo en producción** · no experimentales
- **Nuevos miembros del equipo** · onboarding en 2 semanas (no 2 meses)
- **Aplicación a iniciativas nuevas** · sin facilitación · por cuenta propia

---

## Cierre del bloque mañana

Juan dice:

> *"En 5 sesiones vamos de no-tener-lenguaje-común a publicar-nuestras-propias-skills. Cada sesión construye sobre la anterior. Si falta alguna, se recupera. Si todo lo aplican · al mes 2 arrancar una iniciativa es cuestión de horas, no de semanas."*

Y cierra · cierre final · 5 min de preguntas.

---

**Última actualización** · 2026-04-21 · Juan Estrada
