# lessons-harvester

Captura las lessons de cada iteración del pipeline SDD automáticamente, preservando el rigor de las retros manuales (ulab: 18 lessons, academy: 21 lessons) sin que cueste 4-6 horas.

## Qué resuelve

Cada vez que un humano interviene en el pipeline SDD (edita un artefacto generado, resuelve un comentario de Confluence, corrige un PR), ese momento es evidencia de que el pipeline no cubrió algo. Sin captura sistemática, el siguiente equipo repite los mismos errores.

Esta skill convierte esas **intervenciones humanas** en lessons estructuradas, escritas al `lessons.md` del proyecto con la validación del experto.

## Cuándo se activa

Triggers explícitos (lista completa en `skill.json`):
- *"capturar lecciones"*, *"lecciones aprendidas"*, *"que aprendimos"*
- *"retrospectiva del proceso"*, *"cerrar iteración"*
- *"human in the loop feedback"*, *"harvest lessons"*
- *"lessons.md"*

Triggers implícitos (por contexto):
- Al cerrar un epic en Jira
- Al mergear un batch grande de PRs de una iteración
- Al terminar una ronda de cross-validate con múltiples findings

## Cómo se usa

### Ejemplo 1 · Cerrar iteración de academy

```
Usuario: "Terminamos la iter 2 de academy. Capturemos las lecciones."

lessons-harvester:
  Fase 1 · Discovery
  - Encontré specs/iter-2/ con PRD v3, RFC v2, contracts v1
  - Encontré lessons.md previo con 12 lessons (continuaré desde L-013)
  - Encontré 5 comentarios resueltos y 2 abiertos en Confluence
  - Jira epic ACADEMY-42 con 8 subtasks
  - ¿Confirmás autor validador = Juan Estrada?

Usuario: "Sí, dale."

lessons-harvester:
  Fase 2 · Análisis
  - 6 cambios significativos en PRD (v1 → v3)
  - 3 cambios en RFC (v1 → v2)
  - 2 cambios en contracts
  - 5 comentarios de Confluence gatillaron cambios
  - Total: 16 candidatos

  Voy uno por uno. Primer candidato:

  === L-013 [DRAFT] ===
  Problema: sdd-prd-builder eliminó el endpoint de export al generar PRD técnico v2.
  Causa raíz: V1 (validación contra PRD negocio) no se aplicó.
  Solución: agregado manualmente en v3 tras review del Experto Producto.
  Clave: sdd-prd-builder debe correr con tabla de reconciliación explícita contra PRD negocio.

  ¿Aceptar / editar / descartar / fusionar con L-010?

Usuario: "Aceptar."

lessons-harvester: Guardada. Siguiente candidato...
```

### Ejemplo 2 · Smoke test contra ulab (caso de referencia)

```
Usuario: "Probemos el harvester contra el caso ulab existente."

lessons-harvester:
  Leyendo /Users/juan.estrada/projects/sdd/ulab/specs/iteration-3/...
  Fase 1 - inputs encontrados:
  - 11 archivos de specs con 3 iteraciones
  - retrospectiva-proceso-sdd.md ya existe (18 lessons manuales escritas por Juan Diego)

  Modo smoke test: voy a intentar generar las lessons sin leer retrospectiva-proceso-sdd.md
  y comparar cuántas coinciden con las manuales al final.

  Resultado del análisis:
  - 14 de 18 lessons manuales detectadas automáticamente (78%)
  - 2 que requieren contexto externo que no tengo acceso (L-011 comments resolved — necesito MCP)
  - 2 que son juicios del experto (L-018, L-021) — no evidenciables por diff

  Con 78% de cobertura, la skill está por encima del umbral (75%). Lista para usar en iteraciones nuevas.
```

## Caso validado por experto

- **ulab retrospectiva-proceso-sdd.md** (18 lessons manuales) — target: detectar ≥14 correctamente
- **academy case-appsec-q1-2026 lessons.md** (21 lessons manuales) — target: detectar ≥16 correctamente

## Limitaciones conocidas

1. **No detecta lessons "filosóficas"** — las que surgen del criterio humano sin evidencia en el repo (ej: "necesitamos mejor onboarding"). Para esas, el humano debe agregarlas manualmente.
2. **Requiere Confluence MCP** para leer comentarios resueltos. Sin MCP, baja la cobertura ~10%.
3. **No corre sin autor validador** — es colaborativa por diseño. No queremos lessons escritas sin supervisión humana.
4. **No resuelve lessons conflictivas** — si dos iteraciones aprendieron cosas contrarias, las escribe ambas y deja que el humano decida.

## Reglas de oro

- **No inventa lessons.** Evidencia o descartar.
- **No escribe sin validación.** Cada lesson pasa por "aceptar / editar / descartar".
- **No edita lessons previas.** Solo append (usa "supersedes" si hay que corregir).
- **No expone secretos.** Flag si aparecen, no copy.
- **Preserva formato.** Misma estructura que las retros manuales de referencia (ulab + academy).

## Integración con el pipeline SDD

```
pipeline SDD completo termina una iteración
  ↓
spec-library-update (docs vivas post-implementación)
  ↓
lessons-harvester (esta skill)
  ↓
lessons.md actualizado + recomendaciones
  ↓
iteration-state-loader (Mes 3+) · usa lessons.md como contexto de siguiente iter
```

La skill es el **penúltimo paso** del pipeline — antes de arrancar la siguiente iteración.

## Autoría

- Autor: Juan Estrada
- Revisor: [TBD con experto Producto]
- Versión: 1.0.0
- Fecha: 2026-04-17
- Referencia base: retrospectivas manuales de ulab (Juan Diego) y academy AppSec (automático parcial)
