# Herramientas + canales + demo chica

**Para qué sirve este archivo**
Mostrar al equipo **qué herramientas usamos** y **dónde pedir ayuda** · con una demo chica en vivo para que vean una skill corriendo.

**Cuánto dura en el taller** · 15 min (5 de herramientas + 5 de demo + 5 de canales)

---

## Parte 1 · Herramientas que usamos (5 min)

### Agentes de código

| Herramienta | Qué es | Quién la usa hoy | Fuerte |
|---|---|---|---|
| **Claude Code** | CLI con agentes IA · skills globales | Juan, Fede, Luciano, más | Skills compartidas · CLI terminal puro |
| **Cursor** | IDE estilo VS Code con IA integrada | Sergio, Hugo | Experiencia visual · Rules por repo |
| **GitHub Copilot** | Autocompletado en editor | Varios | Rápido · en todos lados |

**¿Cuál elijo?** · la que ya uses está bien. No cambiamos herramientas por esto.

**Clave** · el flujo SDD es **agnóstico** · funciona en las 3. Solo cambia el formato del artefacto (skill en Claude · rule en Cursor · instruction en Copilot).

### Piezas técnicas

| Pieza | Qué es | Cuándo la ves |
|---|---|---|
| **Skill** | Módulo instruccional para un agente · `SKILL.md` con frontmatter | Cuando apretás `/` en Claude |
| **Rule** | Skill equivalente en Cursor · `.cursor/rules/*.md` | En el repo, Cursor las lee solo |
| **MCP** (Model Context Protocol) | Conector con servicios externos · Jira · GitHub · Slack | Sesión 4 (Night Shift) |
| **CLAUDE.md** | Convenciones del repo · leído por agentes | En la raíz del repo |

### Workspace compartido

| Herramienta | Para qué |
|---|---|
| **Google Doc del taller** | Cada pareja pega sus outputs · queda trazabilidad |
| **Repo del taller** | Código + specs versionados · PRs visibles |
| **Slack `#way-of-work`** | Preguntas · avisos · emoji signals |

---

## Parte 2 · Demo chica (5 min)

**Meta** · que todos vean **1 skill corriendo en vivo** · no explicación, ejecución.

### Guión exacto para Juan

**Minuto 0 · pantalla compartida**

```
[abre terminal, tipea:]
cd ~/taller1-skills
claude
```

*"Esto es Claude Code · la versión CLI. Ven que abre un prompt."*

**Minuto 1 · mostrar skills**

```
/
```

*"Todas estas barras son skills · cada una es un módulo entrenado para una tarea específica. Hoy tenemos 7 instaladas para el taller."*

**Minuto 2 · correr office-hours**

```
/office-hours
```

*"Voy a correr la de office-hours · son 6 preguntas estilo Y Combinator para validar una idea. Lo que ven es la de startup mode."*

La skill arranca. Primera pregunta aparece.

**Minuto 3 · responder rápido**

Juan pega un input breve:
> *"Quiero construir una feature de favoritos para las skills de Claude Code · hoy la lista es alfabética y buscamos lo mismo varias veces por día."*

La skill procesa · pide más detalle · Juan responde en 2-3 frases por pregunta.

**Minuto 4 · aparece el output**

```
[pantalla muestra el discovery.md generado]
```

*"Esto que ven es un **discovery** · en términos que veremos en el glosario · es el primer artefacto del pipeline SDD."*

**Minuto 5 · cerrar**

*"Mañana (o sesión 2), ustedes van a hacer esto en parejas. La diferencia es que cada pareja hará una fase distinta · y el output de una es el input de la siguiente. Eso es el **relay**."*

*"Esta demo en Cursor se ve igual, con Rules en vez de skills. Sergio y Hugo lo pueden mostrar después."*

---

## Parte 3 · Canales · dónde pedir qué (5 min)

### El árbol de decisiones

```
¿Qué necesitás?
│
├── Problema técnico chiquito (5 min)
│   → Slack #way-of-work · alguien te responde en <30 min
│
├── Problema técnico mediano (15 min)
│   → Slack #way-of-work · mención a Alejo
│   → Alejo conecta con quien sepa (Sergio, Fede, Juan)
│
├── Aplicar SDD a tu iniciativa (30-60 min)
│   → 1-on-1 con Juan · miércoles · agendás link abajo
│
├── Durante un taller · algo se rompió
│   → Alejo cuida el chat · emoji signals 👀 🆘 ✅
│
└── Querés proponer algo al way of work
    → PR al repo de shared knowledge
    → O sesión de retro (fin de cada mes)
```

### Los canales en detalle

**Slack `#way-of-work`** (permanente)
- Preguntas generales del way of work
- Compartir PRs interesantes
- Avisos de cambios en skills compartidas

**Slack `#taller1-skills`** (solo mañana)
- Chat del taller · Alejo modera
- Emoji signals: 👀 atento · 🆘 ayuda · ✅ terminé · 🔥 en problemas
- Se cierra post-taller · historia queda archivada

**Google Doc del taller** (solo mañana)
- Sección "presentes" · escribís tu nombre al llegar
- Sesión 2+ · cada pareja pega outputs en su sección
- Link por DM esta noche

**1-on-1s con Juan** (miércoles)
- 30 min · videollamada · link `calendly.com/juan-estrada/way-of-work`
- Vas con una iniciativa tuya · salís con un plan

**Repo GitHub** (tech_emergentes_skills)
- Skills compartidas del equipo
- PRs abiertos · todos pueden reviewar
- Para contribuir tu primera skill · sesión 5

---

## Parte 4 · Referencia rápida · qué herramienta para qué

| Quiero... | Uso... |
|---|---|
| Correr una skill | `/nombre-skill` en Claude Code (o equivalente en Cursor) |
| Instalar una skill | Symlink de repo a `~/.claude/skills/` |
| Crear una skill nueva | `/skill-creator` (Sesión 5) |
| Ver grafo de dependencias | `/task-dependency-analyzer` |
| Preguntar al equipo | Slack `#way-of-work` |
| Pedir ayuda 1-on-1 | Calendly con Juan |
| Reportar bug del pipeline | Slack · o issue en GitHub |

---

## Parte 5 · Cierre del bloque

Juan dice:

> *"Las herramientas son medios · no fin. El mes que viene empezamos con las que ya tienen. Si alguna les falta, en 1 min la instalamos. Lo importante es el flujo, no la marca."*

Y pasa a roadmap de sesiones · 10 min.

---

**Última actualización** · 2026-04-21 · Juan Estrada
