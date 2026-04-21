# taller-participante

Skill que guía a las 16 personas del Taller 1 del Way of Work durante el relay SDD end-to-end.

## Qué resuelve

Cuando te toca una fase del relay (1-8) y no sabés:
- Qué skill correr
- Dónde está el input que la pareja anterior dejó
- Qué plantilla de output usar
- Cómo armar tu frase de show & tell

Esta skill te lleva de la mano en 15 minutos.

## Cómo se activa

Triggers:
- *"soy pareja [X]"*
- *"me tocó fase [Y]"*
- *"ayuda en el relay"*
- *"taller-participante"*

## Cómo se usa

```
Usuario: "Soy pareja 5, me tocó Contratos, ayudame"

taller-participante:
  "Contexto confirmado · Pareja 5 · Contratos API
  Driver: Hugo · Navigator: Juan Pablo
  Skill: /contract-define

  Paso 1 · leer RFC de Pareja 3 y ADRs de Pareja 4 (3 min)
  → Buscalos en el Google Doc, secciones Fase 3 y Fase 4

  Paso 2 · correr la skill (10 min)
  → Pegá este comando:
  [comando listo]

  Paso 3 · chequeo (2 min)
  → Validar que incluye endpoints para marcar favorita + listar

  Paso 4 · frase show & tell
  → Escribí 'lo que más nos sorprendió fue ___'

  Tiempo total: 15 min · Tu fase cierra a las [hora]."
```

## Quienes la usan

Los 16 participantes del Taller 1 · una por pareja.

| Pareja | Driver | Navigator | Fase |
|---|---|---|---|
| 1 | Juan Manuel Salazar | Stephany Rivera | Discovery (Juan la hace) |
| 2 | Sergio Amarilla | Javier Durán | PRD |
| 3 | Fede Correa | Andrés López | RFC |
| 4 | Hugo Escobar | Juan Pablo Fernández | ADRs |
| 5 | Luciano Pérez | Ana María Villegas | Contratos |
| 6 | Leonardo Villa | Carlos Espinosa | User Stories |
| 7 | Nicolás Canese | Nicolás Cóppola | Tasks |
| 8 | German Insuasty | Fernando López | Code Review |

## Relación con otras skills

| Otra skill | Relación |
|---|---|
| `/facilitar-taller` | Para el facilitador (Juan) · esta es para los 16 participantes |
| `/sdd-router` | Para navegar el pipeline SDD general · esta es específica del taller |
| `/skill-creator` | Para crear skills nuevas (Sesión 2) · esta es para recorrer el relay |
| `/code-review` | La usa Pareja 8 directamente en su fase |

## Limitaciones

1. **Específica del Taller 1 del 21/4** · para otros talleres, se adapta
2. **Asume que los docs del repo y Google Doc existen** · si no, te avisa
3. **No hace el trabajo** · te guía · la pareja ejecuta

## Plan B integrado

La skill ya incluye plan B para:
- Claude Code no anda → usá Cursor o Copilot
- Skill no se activa → pedí plantilla backup en el chat
- Google Doc colapsa → escribí en chat de Meet con prefijo

## Autoría

- Autor: Juan Estrada
- Fecha: 2026-04-20
- Versión: 1.0.0
- Contexto: Taller 1 · Shared Knowledge Sesión 1 · 21 abril 2026
