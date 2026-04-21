# Diapositivas · Sesión 1 · onboarding · 60 min

**Formato** · markdown con `---` entre slides · proyectás con Marp / Markdown Preview Enhanced / Google Slides.

**Duración** · 60 minutos.

**Estructura** · 6 bloques · cada uno arranca con slide de transición.

---

## SLIDE 1 · Portada

# Way of Work · Sesión 1
## Onboarding al SDD en tech emergentes

2026-04-21 · Juan Estrada · 1 hora

---

## SLIDE 2 · ¿Qué vamos a hacer en esta hora?

1. **Setup mínimo** · que todos tengan ambiente funcionando · 10 min
2. **Objetivo + metodología** · por qué estamos acá · 12 min
3. **Glosario** · los términos clave · 8 min
4. **Herramientas + canales + demo** · qué usamos · dónde pedir ayuda · 15 min
5. **Roadmap** · las 5 sesiones del mes · 10 min
6. **Cierre** · 5 min

**No hay ejercicio práctico hoy** · eso es sesión 2.

---

# BLOQUE 1 · Setup mínimo · 10 min

---

## SLIDE 3 · Setup mínimo · 3 cosas

1. Claude Code corriendo · `claude --version` sin errores
2. Repo del taller clonado · `cd ~/taller1-skills`
3. Google Doc abierto · escriben su nombre en "presentes"

**Si algo falla** · Alejo te ayuda en `#taller1-skills`.

---

## SLIDE 4 · Verificación grupal

Cuando tengas los 3 ítems:

👀 Levantá la mano
✅ Ponete reacción ✅ en el chat

Juan espera a que estén los 16.

---

# BLOQUE 2 · Objetivo + metodología · 12 min

---

## SLIDE 5 · Por qué estamos acá

Somos **20 personas** en tech emergentes.

Hoy:
- Cada uno resuelve igual, con resultados distintos
- No se reusa el aprendizaje del otro
- Las decisiones viven en la cabeza · no documentadas
- Los nuevos tardan meses en entender cómo trabajamos

**La hipótesis** · con way of work común + lenguaje común + herramientas que lo soporten · **escalamos sin fricción**.

---

## SLIDE 6 · Qué queremos lograr en 1 mes

1. Hablar el **mismo idioma** (glosario común)
2. Tener un **pipeline común** (idea → código siempre igual)
3. Usar **herramientas que lo soportan** (Claude · Cursor · Copilot · MCPs)
4. **Contribuir** al sistema (crear skills propias)

**Meta cuantitativa** · arrancar una iniciativa nueva lleva **horas, no semanas**.

---

## SLIDE 7 · Cómo nos acompañamos

| Rol | Quién | Qué hace |
|---|---|---|
| Facilitador | **Juan** | Diseña · modera · 1-on-1s |
| Soporte | **Alejo** | Chat · emoji signals · plan B |
| Participantes | **Los 16 de ustedes** | Traen iniciativas · practican · reportan |

**Cadencia** · 1 sesión semanal · 1-on-1s opcionales los miércoles · Slack permanente.

---

## SLIDE 8 · Las 4 reglas duras (no-negociables)

- **V1** · PRD técnico no reduce alcance del PRD de negocio
- **V2** · Hasta el RFC · validamos contra el PRD de negocio
- **V3** · `CLAUDE.md` obligatorio antes de codear
- **V4** · RFC con >5 decisiones · se parte en ADRs

Todo lo demás es ajustable.

---

## SLIDE 9 · Compromiso realista

**Lo que pedimos** :
- Venir a las 5 sesiones (o recuperar con video)
- Probar **1 skill en 1 iniciativa real** entre sesiones
- Reportar cuando algo rompe

**Lo que NO pedimos** · cambiar cómo codeás hoy.

---

# BLOQUE 3 · Glosario · 8 min

---

## SLIDE 10 · Glosario · tipos de proyecto

**Greenfield** · proyecto desde cero · sin código · sin usuarios · sin deudas
_Ejemplo_ · la feature de favoritos que vamos a inventar sesión 2

**Brownfield** · sobre sistema existente · código · usuarios · deudas
_Ejemplo_ · academy · ittilab · nueva feature sobre eso

---

## SLIDE 11 · Glosario · artefactos del pipeline

| Artefacto | Qué es |
|---|---|
| **Discovery** | Exploración del problema antes de diseñar |
| **PRD** | QUÉ construir y POR QUÉ |
| **RFC** | CÓMO construir (propuesta técnica) |
| **ADR** | UNA decisión arquitectónica (formato Nygard) |
| **Contrato API** | Schema compartido entre FE y BE |
| **Historia INVEST** | Unidad de valor entregable al usuario |
| **Task técnica** | Paso concreto de implementación |
| **PR + review** | Cambio listo para merge + validación |

---

## SLIDE 12 · Glosario · conceptos del way of work

- **SDD** · Spec-Driven Development · decisiones antes del código
- **Pipeline** · Discovery → PRD → RFC → ADRs → Contrato → Historias → Tasks → Code → Review
- **Gate humano** · checkpoint antes de avanzar
- **Skill** · módulo instruccional para un agente (Claude/Cursor)
- **MCP** · conector con servicios externos (Jira, GitHub)
- **Trigger** · `/nombre-skill` que invoca la skill

---

# BLOQUE 4 · Herramientas + canales + demo · 15 min

---

## SLIDE 13 · Herramientas que usamos

| Herramienta | Quién la usa | Fuerte |
|---|---|---|
| **Claude Code** | Juan · Fede · Luciano · más | Skills globales · CLI |
| **Cursor** | Sergio · Hugo | IDE visual · Rules |
| **GitHub Copilot** | Varios | Autocompletado rápido |

**El flujo SDD es agnóstico** · funciona en las 3. Solo cambia el formato del artefacto.

---

## SLIDE 14 · Piezas técnicas

| Pieza | Qué es |
|---|---|
| **Skill** | `SKILL.md` con frontmatter · se ejecuta con `/nombre` |
| **Rule** | Equivalente en Cursor · `.cursor/rules/*.md` |
| **MCP** | Conector con servicios · se ve en sesión 4 |
| **CLAUDE.md** | Convenciones del repo · obligatorio (V3) |

---

## SLIDE 15 · DEMO EN VIVO (5 min)

Juan comparte pantalla · corre:

```
cd ~/taller1-skills
claude
/
/office-hours
```

Input breve. La skill hace las 6 preguntas · aparece output.

*"Esto que ven es un **discovery**. En sesión 2 lo van a hacer ustedes."*

---

## SLIDE 16 · Canales · dónde pedir qué

| Necesitás... | Andás a... |
|---|---|
| Problema chico (5 min) | Slack `#way-of-work` |
| Problema mediano (15 min) | Slack · mencionás a Alejo |
| Aplicar SDD a tu iniciativa | 1-on-1 con Juan · miércoles |
| Algo rompe durante taller | Alejo en `#taller1-skills` |
| Proponer algo al way of work | PR al repo de shared knowledge |

---

# BLOQUE 5 · Roadmap · 10 min

---

## SLIDE 17 · Las 5 sesiones

```
Sesión 1 (hoy · 1h) → onboarding + metodología + glosario
         ↓
Sesión 2 (sem 2 · 2h) → SDD profundo + ejercicio greenfield
         ↓
Sesión 3 (sem 3 · 2h) → ejercicio brownfield (academy/ittilab)
         ↓
Sesión 4 (sem 4 · 1h) → night shift + MCPs + agentes autónomos
         ↓
Sesión 5 (sem 5 · 2h) → publicar tu primera skill + mejorar vs iterar
```

---

## SLIDE 18 · Sesión 2 · greenfield · 2h

**Lo más importante del mes.**

- Relay de 8 parejas · cada una hace 1 fase del pipeline
- Proyecto · "favoritos de skills" · greenfield puro
- Cada pareja consume output de la anterior · deja el suyo a la siguiente
- 10 min por fase + show & tell al final

**Al terminar** · tienen **experiencia hands-on** del pipeline completo.

---

## SLIDE 19 · Sesión 3 · brownfield · 2h

**Skills nuevas** · `/journey-creator` · `/ddd-workshop-facilitator` · `/journey-ddd-evaluator`

**Ejercicio** · aplicar estas 3 skills a **academy** o **ittilab**

**Al terminar** · saben arrancar una feature nueva sobre sistema existente **sin romper lo que hay**.

---

## SLIDE 20 · Sesión 4 · night shift · 1h

**Concepto** · dejar Claude Code corriendo **de noche** resolviendo tasks autónomamente · a la mañana tenés PRs listos.

**Prerequisitos duros**
- DAG validado con humano
- `CLAUDE.md` completo
- Tests automáticos

**Al terminar** · 1 MCP conectado · 1 task autónoma ejecutada.

---

## SLIDE 21 · Sesión 5 · publicar + mejorar · 2h

**Pasás de consumir a contribuir.**

- ¿Mejorás la skill o ajustás el prompt?
- Anatomía de una skill
- Crear tu primera skill · `/skill-creator`
- PR al repo compartido · review en vivo

**Al terminar** · 1 skill propia publicada.

---

# BLOQUE 6 · Cierre · 5 min

---

## SLIDE 22 · Qué te llevás hoy

- Ambiente funcionando (Claude Code + skills + Google Doc)
- Lenguaje común (glosario en la cabeza)
- Roadmap claro (5 sesiones en 1 mes)
- Canales de ayuda identificados (Slack · 1-on-1 · repo)

---

## SLIDE 23 · Tarea para sesión 2

**Antes del próximo viernes** · pensá **1 idea de feature greenfield** que podrías proponer (real o inventada).

No la desarrolles · solo tenela en la cabeza.

En sesión 2 la usás como input del relay si querés.

---

## SLIDE 24 · Preguntas

Abro turno · 5 min.

Después cerramos.

---

## SLIDE 25 · Gracias

**Próxima sesión** · viernes 28/4 · 2 horas · greenfield.

**Link a material** · se los mando por DM hoy.

**Dudas hasta el viernes** · Slack `#way-of-work` · o 1-on-1 agendás en Calendly.

Gracias · nos vemos la próxima.

---

## Notas para el facilitador (Juan)

### Timing detallado

| Slides | Minutos | Bloque |
|---|---|---|
| 1-2 | 1 | Portada + agenda |
| 3-4 | 10 | Setup |
| 5-9 | 12 | Objetivo + metodología |
| 10-12 | 8 | Glosario |
| 13-16 | 15 | Herramientas + demo + canales |
| 17-21 | 10 | Roadmap |
| 22-25 | 5 | Cierre + preguntas |

### Si vas atrasado

- Saltear slide 4 (verificación grupal) · asumís que todos están
- Slide 9 (compromiso) la leés rápido
- Slides 13-14 (herramientas) las comprimís en 2 min

### Si vas adelantado

- Extender demo a 7 min
- Abrir preguntas durante slides (no solo al final)
- Pedir a 2-3 participantes que compartan lo que más les ruidio

---

**Última actualización** · 2026-04-21 · Juan Estrada
