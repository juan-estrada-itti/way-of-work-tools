# Lessons · Sesión 1 · Onboarding · 21/4/2026

**Qué es este archivo**
Aprendizajes del taller + del setup async post-taller.
Cada lesson es accionable para sesiones futuras.

**Cómo se lee** · código + categoría + 1 frase + cómo aplicarlo.

**Formato** · `L-##` · `categoría` · `lesson` · `aplicación`

---

## Del diseño y ejecución del taller

### L-01 · contenido · 1 hora alcanza para onboarding · no para ejercicio

La sesión 1 de 60 min funcionó bien para: objetivo · metodología · glosario · demo chica · roadmap.
**NO alcanza** para incluir ejercicio práctico (el relay de 8 parejas).

**Aplicación** · para sesión 2 (greenfield hands-on) reservar **2 horas completas** · no intentar comprimir.

---

### L-02 · formato · glosario ANTES de la demo funciona mejor que después

En el diseño original el glosario iba después de la demo. Lo movimos antes y se notó · los términos (PRD · RFC · ADR) se "activaron" y la demo fue interpretable.

**Aplicación** · en sesiones 2-5, siempre presentar vocabulario nuevo **antes** de ejercicios que lo usen.

---

### L-03 · comunicación · no técnicos sienten alivio cuando les das "opción 2"

En los DMs post-taller, ofrecer 1-on-1 de 20 min como opción explícita baja la ansiedad de los 4 no-técnicos · incluso si no la usan, saber que existe es suficiente.

**Aplicación** · seguir ofreciéndolo en sesiones futuras · agregar "o hablamos por acá si preferís" para los que les cuesta agendar.

---

## Del setup async y kit

### L-04 · herramientas · npm es mejor vehículo que brew para distribuir Claude Code

Originalmente la guía decía `brew install anthropics/claude/claude`. **Falla o no es estándar**.
Lo correcto es `npm install -g @anthropic-ai/claude-code` · funciona en Mac, Linux y Windows por igual.

**Aplicación** · siempre validar el método de install con la documentación oficial de Anthropic antes de asumir · no propagar métodos que "parecen Mac-nativos" si no son canónicos.

---

### L-05 · autenticación · API key > OAuth personal para equipos

OAuth personal obliga a cada miembro a tener cuenta Pro/Max pagada separada.
El workspace compartido en `platform.claude.com` permite crear API keys nombradas por persona · los costos van al workspace del equipo · más control + simplicidad.

**Aplicación** · usar siempre `platform.claude.com/settings/workspaces/default/keys` como single point of key generation para el equipo · convención de naming `{nombre}-{apellido}-itti`.

---

### L-06 · gobernanza · orgs corporativas tienen rulesets que bloquean public visibility

La org `ittidigital` tiene un ruleset que **no permite** cambiar repo de privado a público · necesita permiso de admin de la org.
Workaround · crear mirror público en cuenta personal (`juan-estrada-itti/way-of-work-tools`) · el original queda como backup privado.

**Aplicación** · para futuros repos que vayan a ser públicos, crearlos directamente en cuenta personal o pedir permiso de admin de la org desde el arranque.

---

### L-07 · distribución · curl public necesita repo público o GitHub PAT

`curl -fsSL https://raw.githubusercontent.com/<org>/<repo>/main/<file>` **falla con 404** si el repo es privado · GitHub no autentica con el token del navegador.
Opciones · (a) repo público · (b) cada user configura PAT · (c) distribución por otra vía.

**Aplicación** · nunca diseñar kits de instalación `curl | bash` asumiendo repos privados · al menos el archivo servido debe ser público.

---

### L-08 · dependencias · install-kit depende del acceso al org privado

Las 6 skills del repo `ittidigital/tech_emergentes_skills` se clonan por SSH al org privado.
Si algún participante no tiene (a) SSH key configurada en GitHub o (b) colaborador access al org, el install-kit falla parcialmente · queda con 4/10 skills.

**Aplicación** · documentarlo explícitamente en `INSTALL.md` sección "pre-requisitos" · verificar acceso de los 16 al org antes de mandar DMs.

---

### L-09 · enlaces relativos · renombrar/mover archivos requiere sweep de refs

Al mover archivos de `shared_knowledge_iter_3/` al nuevo repo con nombres distintos, **9 referencias internas quedaron rotas** (apuntaban a nombres viejos como `06a-pipeline.md`).

**Aplicación** · en próximos repos, después de cualquier rename · correr grep del nombre viejo antes de commitear · y en repos públicos agregar CI check (linter de broken markdown links).

---

## Del contenido del way of work

### L-10 · skills · gap entre `user-story-builder` y `task-dependency-analyzer`

Durante el diseño detectamos un gap · las historias INVEST van directo al DAG macro sin un paso intermedio de "plan vertical por historia con governance cargada".
Resolución · creamos `/story-to-plan` · carga ADRs + contrato + CLAUDE.md · descompone la historia en subtasks con `consume`/`produce` estructurados.

**Aplicación** · el pipeline SDD ahora tiene 2 niveles de planning · micro (`/story-to-plan` por historia) · macro (`/task-dependency-analyzer` entre historias). Documentarlo en el glosario.

---

### L-11 · schema · frontmatter declarativo simplifica análisis de dependencias

Agregar campos `pipeline:` y `dependencies:` al frontmatter de cada SKILL.md permite que `/sdd-router` calcule el grafo automáticamente · sin necesidad de lógica hardcodeada.
Los namespaces (`schema.*` · `endpoint.*` · `adr.*` etc.) hacen que el matching sea literal · no requiere entender de negocio.

**Aplicación** · v2 de todas las skills del equipo debe adoptar este schema · PR al repo `tech_emergentes_skills` pendiente.

---

### L-12 · scope · greenfield y brownfield tienen pipelines distintos

Mezclarlos confunde al equipo. En greenfield no aplican skills de discovery de código existente (`/journey-creator` · `/ddd-workshop-facilitator` · etc.).

**Aplicación** · `applies_to: [greenfield]` y `applies_to: [brownfield]` explícitos en el frontmatter · `/sdd-router` filtra según el tipo de iniciativa que arranca el user.

---

## Lo que cambiaría para próxima sesión

### CA-01 · pre-enviar kit · antes del taller, no después

Mandar el kit **24-48hs antes** de la sesión 1 · los que llegan sin setup pierden los primeros 10 min del taller.
Esta sesión lo hicimos al revés (setup async post-taller) · porque fue la primera y no sabíamos qué íbamos a enseñar · pero para sesión 2 en adelante, pre-enviar.

---

### CA-02 · video grabado del taller · disponible antes de 48hs

Los que faltan a la sesión lo recuperan · los que vinieron lo usan como referencia. Grabado + subido a Google Drive / YouTube privado con link restringido.

Esta sesión 1 · pendiente · grabar sesión 2 por defecto.

---

### CA-03 · asignar parejas DESDE la invitación

En este taller las parejas las definimos en el momento · funcionó pero creó fricción.
Para sesión 2 · parejas ya pre-asignadas en la convocatoria · cada uno llega sabiendo con quién y qué fase.

Ya está documentado en `DMs-individuales.md` · cada DM menciona la pareja.

---

## Template para agregar nuevas lessons

```markdown
### L-## · categoría · título corto

Descripción de lo que pasó · 2-3 líneas.

**Aplicación** · qué hacer distinto la próxima vez · concreto, accionable.
```

**Categorías sugeridas** · contenido · formato · comunicación · herramientas · autenticación · gobernanza · distribución · dependencias · skills · schema · scope · convocatoria

---

**Última actualización** · 2026-04-21 · Juan Estrada · post taller-1
