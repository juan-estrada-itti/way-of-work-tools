# facilitar-taller

Skill que te acompaña como facilitador de talleres del Way of Work SDD desde el prep hasta el post-taller.

## Qué resuelve

Cuando tenés que dictar un taller y no sabés por dónde empezar · o estás EN vivo y algo se cayó · o terminó y querés capturar lessons. Esta skill hace 5 preguntas diagnósticas y te devuelve acciones concretas ajustadas a tu contexto (momento, tipo de taller, tamaño, duración, nivel del grupo).

## Cuándo se activa

Triggers (lista completa en `skill.json`):

- *"voy a dictar taller"*
- *"taller mañana"*
- *"preparar taller"*
- *"ayudame con el taller"*
- *"rehearsal"*
- *"plan B taller"*
- *"me toca dictar"*

## Cómo se usa

### Ejemplo 1 · Prep a 1 día del taller

```
Usuario: "Voy a dictar un taller mañana, ayudame con el prep"

facilitar-taller: "5 preguntas rápidas para darte el prep ajustado.
                   Pregunta 1: ¿En qué momento del prep estás? (a-f)"

Usuario: "c · 1 día antes"

facilitar-taller: "Pregunta 2: ¿Qué tipo de taller? (a-e)"

...

(después de las 5 preguntas)

facilitar-taller:
  Contexto: 1 día antes · Taller 1 Apropiación · 18 asistentes ·
            90 min · grupo mixto

  Checklist esta noche (~75 min):
  🔴 CRÍTICO
  1. Instalar gstack (5 min)
  2. Crear repo del taller (10 min)
  3. Crear Google Doc compartido (5 min)
  4. Test end-to-end (20 min)

  🟡 IMPORTANTE
  5. Backup QuickTime (15 min)
  6. DMs a 16 parejas (10 min)

  Próximo paso: arrancá con ítem 1. Te paso los comandos cuando digas listo.
```

### Ejemplo 2 · Falla en vivo

```
Usuario: "Estoy dictando el taller y /office-hours no responde en la demo"

facilitar-taller: "Falla tipo 1 · Claude Code no responde.

  Plan B inmediato (30 seg):
  1. Decí al grupo: 'parece un tema de red, uso el backup que grabé anoche'
  2. Abrí QuickTime con ~/Desktop/backup-office-hours.mov
  3. Compartí pantalla con el video
  4. Narrá sobre él: 'acá vean, esto es el mismo ejercicio que iba a hacer...'

  Después:
  - Pegá el discovery.md que tenés guardado del test end-to-end en el
    Google Doc para que las parejas arranquen con ese input
  - El relay sigue igual

  Si no tenés backup: usá /create-prd como sustituto y ajustá el guión."
```

### Ejemplo 3 · Post-taller

```
Usuario: "Terminé el taller, ayudame a cerrar"

facilitar-taller: "Contexto: post-taller ✓

  Plantilla para captura con Alejo (15 min):
  [preguntas a responder juntos]

  Prompt para lessons-harvester:
  [comando exacto para invocar la skill sobre el repo del taller]

  Mensaje Slack de cierre:
  [template pegable con resultados + próximos pasos]

  Próximo paso: agendar Sesión 2 (sugerido: [fecha +2 semanas])
  con pre-requisitos claros."
```

## Caso validado

El documento `TALLER1-FINAL.md` del proyecto `roadmap_modelo_operativo` es la aplicación concreta de esta skill para el Taller 1 del 21 de abril 2026. Sirve como ground truth para validar los outputs futuros de la skill.

## Limitaciones conocidas

1. **No reemplaza al facilitador** · solo lo acompaña. Decisiones de criterio (invitados, orden de temas) siguen siendo humanas.
2. **Optimizada para talleres del equipo itti-digital** · si el taller es para otro contexto, la skill pregunta y adapta.
3. **Requiere docs del proyecto** para dar respuestas específicas · si se usa fuera, trabaja con placeholders.
4. **v1 manual** · en Mes 2-3 se integra con `spec-engine` para orquestar rehearsal automático.

## Integración con otras skills

- **Complemento de `/skill-creator`** · cuando el taller crea skills nuevas (Sesión 2)
- **Output pre-lessons-harvester** · post-taller dispara `/lessons-harvester` sobre el repo del taller
- **No compite con `/sdd-router`** · ese es para el pipeline SDD, este es para talleres sobre el pipeline

## Reglas de oro

- Una pregunta a la vez (no 5 juntas)
- Tiempos honestos (no minimizo)
- Siempre próximo paso concreto
- Diferenciá obligatorio de nice-to-have
- Referenciá docs existentes del proyecto
- No facilito el taller · guío al facilitador

## Autoría

- Autor: Juan Estrada
- Fecha: 2026-04-20
- Versión: 1.0.0
- Caso de referencia: Taller 1 · Shared Knowledge Sesión 1 · 21 abril 2026
