# sdd-router

Guía del way of work SDD. Tutor que te ubica en el pipeline y te recomienda la skill correcta a correr.

## Qué resuelve

Cuando el usuario tiene una tarea y no sabe qué skill usar — o tiene un artefacto (PRD, RFC, código) y duda del siguiente paso — esta skill hace 3 preguntas diagnósticas y aplica 14 reglas de ruteo + 4 validaciones críticas para devolver una recomendación concreta.

## Cuándo se activa

Cualquiera de estos triggers (lista completa en `skill.json`):

- *"por donde empiezo"*
- *"que skill uso"*
- *"no sé por donde"*
- *"que sigue"*
- *"siguiente paso"*
- *"way of work"*
- *"sdd router"* / *"router"*
- *"guía SDD"*
- *"ayudame a empezar"*

Se activa automáticamente cuando el usuario dice cualquiera de estas frases.

## Cómo se usa

### Ejemplo 1 · PM con idea para academy

```
Usuario: "Tengo una idea para academy, no sé por donde empezar"

sdd-router: "Te ayudo. Pregunta 1: ¿qué tenés hoy como insumo?
             a) idea sin validar, b) problema validado sin doc, c) PRD negocio..."

Usuario: "Solo la idea"

sdd-router: "Pregunta 2: ¿cuál es tu rol?"

Usuario: "PM"

sdd-router: "Pregunta 3: ¿en qué iniciativa?"

Usuario: "academy"

sdd-router:
  Skill recomendada: /journey-creator (PR #35)
  Por qué esta: estás iterando producto vivo. Necesitás contexto del código
               actual antes de proponer la feature nueva.
  Qué preparar: path al repo, CLAUDE.md actualizado, idea en 2 frases.
  Shared knowledge: ver shared-knowledge-sesion-1.md
  Qué viene: /create-prd con los journeys como contexto, después /sdd-prd-builder.
  Validaciones: V3 — verificá que academy/CLAUDE.md tenga las convenciones.
```

### Ejemplo 2 · Tech Lead con RFC

```
Usuario: "Ya escribí el RFC. ¿Qué sigue?"

sdd-router: aplica las 3 preguntas (insumo = RFC, rol = Tech Lead, iniciativa = ittilab)
            → R7 aplica → /contract-define
            → V4 aplica si RFC tiene >5 decisiones → recomienda partir en ADRs primero
```

### Ejemplo 3 · Usuario confundido

```
Usuario: "Necesito ayuda"

sdd-router: pregunta 1 → "no estoy seguro"
            → R14: pregunta adicional: "¿existe código de este producto?"
            → rutea a /journey-creator (sí) o /create-prd (no)
```

## Caso validado por experto

El flujo completo se probó internamente con 3 casos (PM con idea, Tech Lead con RFC, usuario confundido) y las 14 reglas + 4 validaciones dieron recomendaciones consistentes con el Proceso Light v2.0 y los aprendizajes del caso academy AppSec Q1 2026.

Documentación del caso: `docs/case-appsec-q1-2026/README.md`

## Limitaciones conocidas

1. La skill **no ejecuta** la skill recomendada — solo recomienda. El usuario debe invocar la siguiente manualmente.
2. Si el usuario pregunta algo que no es de SDD, la skill responde normalmente sin forzar las 3 preguntas.
3. Las skills de Discovery (9 en total) aún no existen en el repo — la skill avisa cuando caen en esa fase y sugiere fallback manual.
4. Versión inicial manual — en Mes 2-3 se integra con `lessons-harvester` y `iteration-state-loader`.

## Validaciones que aplica

- **V1** (L-010 ulab): scope PRD negocio ≠ técnico
- **V2** (F-01 feedback líder): validar contra PRD hasta el RFC
- **V3** (L-017 academy): `CLAUDE.md` obligatorio antes de skills que generen código
- **V4**: RFC con >5 decisiones → partir en ADRs

## Autoría

- Autor: Juan Estrada
- Revisor: [TBD con experto Producto]
- Versión: 1.0.0
- Fecha: 2026-04-17
