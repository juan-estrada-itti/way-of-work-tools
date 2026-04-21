# Proyecto ejemplo · Favoritos de skills

**Para qué sirve este archivo**
Es el **seed** del relay · la idea inicial que Juan pega en `/office-hours` para arrancar la Pareja 1.

Este proyecto es **greenfield puro** · no hay código previo · no hay usuarios · todo se decide en el taller.

---

## La idea en 3 frases

Los 20 miembros de tech emergentes usamos Claude Code con decenas de skills.
Cuando hacemos `/`, aparecen todas en orden alfabético.
Queremos marcar 5-10 como **favoritas** para verlas primero · ahorrar segundos cada vez que invocamos una.

---

## Por qué greenfield

- **No existe todavía** · ni en Claude Code oficial, ni como skill nuestra, ni como extensión
- **No hay código previo** del equipo sobre esto
- **No hay usuarios actuales** del feature (obvio · no existe)
- Cada artefacto del relay será **el primero** · ideal para aprender

---

## Contexto mínimo para `/office-hours`

Cuando Juan arranca la demo, pega esto como input:

```
Tengo una idea: los 20 del equipo usamos decenas de skills en Claude Code.
Cuando hacemos "/" aparecen todas en orden alfabético.
Quiero una feature "favoritos" para marcar las que uso más seguido y verlas arriba.

Quiero explorar con office-hours si esto vale la pena construir.
```

`/office-hours` en modo startup hará las 6 preguntas · Juan las responde con sentido común:

1. **¿Quién tiene el problema?** · los 20 del equipo · yo el primero
2. **¿Qué tan doloroso?** · cada invocación tarda 3-5 seg extra buscando · x50 veces al día · minutos perdidos
3. **¿Qué hacen hoy?** · memorizan nombres exactos · tipean `/rfc-` y esperan autocompletado
4. **Wedge más angosto** · 5 skills favoritas por persona · botón "star" en la lista
5. **Observación directa** · el propio Juan scrollando la lista · lo vio en Fede y Sergio también
6. **3 años si funciona** · feature nativa en Claude Code · o extensión que se adopta globalmente

---

## Seed para cada pareja (por si acaso)

Si alguna pareja se queda sin input de la anterior (por retraso o error), usá estos fallbacks:

### Fase 2 · PRD (Pareja 2)
> **Discovery resumido** · Los 20 del equipo perdemos minutos al día scrolleando skills. Queremos marcar 5-10 favoritas. Wedge: 5 skills por persona, botón star en la lista. Observación: todos hacen lo mismo hoy.

### Fase 3 · RFC (Pareja 3)
> **PRD resumido** · Feature "favoritos de skills" · marcar/desmarcar skill como favorita · verla primero al abrir `/` · métrica: tiempo promedio de invocación baja de 3s a 1s · usuario: los 20 del equipo · fuera de alcance: compartir favoritas entre usuarios.

### Fase 4 · ADRs (Pareja 4)
> **RFC resumido con 4 decisiones técnicas** · (1) stack: frontend vanilla JS · backend Node + SQLite · (2) auth: header simple con nombre · (3) persistencia: tabla `favorites(user, skill_name, marked_at)` · (4) API: REST con 3 endpoints (list, mark, unmark).

### Fase 5 · Contrato (Pareja 5)
> **ADRs + RFC resumidos** · Decidimos REST + SQLite + auth por header. Definan el contrato API.

### Fase 6 · Historias (Pareja 6)
> **Contrato resumido** · 3 endpoints: `GET /favorites` (lista), `POST /favorites/:skill` (marca), `DELETE /favorites/:skill` (desmarca). Ahora · historias INVEST para cubrir el flujo.

### Fase 7 · Tasks (Pareja 7)
> **Historias resumidas** · (H1) Como user quiero ver mis favoritas arriba · (H2) Como user quiero marcar una skill como favorita · (H3) Como user quiero desmarcar una favorita · (H4) Como user quiero que persista entre sesiones. Descompongan en tasks técnicas con grafo.

### Fase 8 · Code review (Pareja 8)
> **PR de ejemplo** · Sergio tiene un PR listo con el endpoint `POST /favorites/:skill`. Revísenlo contra el PRD, RFC y Contrato.

> Si no hay PR real de Sergio · Alejo les pasa un PR mock pre-armado.

---

## Cómo se ven los artefactos esperados (aproximados)

Los artefactos que generen en el taller son **chicos pero completos** · no tienen que ser de producción. Alcanza con que cada uno:

### `discovery.md` (~200 palabras)
Responde las 6 preguntas de YC office-hours · 2-3 líneas cada una.

### `prd.md` (~300 palabras)
Problema · usuario · casos de uso (3-4) · métrica de éxito · fuera de alcance.

### `rfc.md` (~400 palabras)
Contexto técnico · 2-3 opciones consideradas · decisión técnica · arquitectura en texto (o 1 diagrama) · consideraciones.

### `ADR-*.md` (3-4 ADRs, ~150 palabras cada uno)
Contexto · decisión considerada (2-3 alternativas) · decisión tomada · consecuencias · status Proposed.

### `api-contract.md` (~200 palabras)
3 endpoints con request/response schema · codes 200/404/500.

### `stories.md` (~250 palabras)
4 historias INVEST · "Como [rol] quiero [acción] para [beneficio]" · criterios de aceptación en 2-3 bullets.

### `tasks.md` + grafo (~300 palabras)
8-12 tasks técnicas · identificador · depende-de · estimación · grafo Mermaid.

### `review.md` (~150 palabras)
Checklist contra PRD/RFC/Contrato · apto / cambios requeridos · bullets.

**Total en Google Doc al final del taller** · ~2000 palabras de specs coherentes · creadas por 16 personas en 55 min.

---

## Por qué este ejemplo (y no otro)

Consideré:
- **Clon de Twitter** · muy grande, no cabe en 55 min
- **Todo list app** · muy trillado, no genera sorpresa
- **Feature de academy** · brownfield, no aplica hoy
- **Favoritos de skills** · relevante al equipo · greenfield · size justo · genera debate real sobre storage, auth, UI

Elegí favoritos de skills porque:
- Cada uno **usaría** el feature el martes a la mañana
- Es **chico** · cabe en el tiempo
- Tiene **decisiones reales** · no obvias (dónde persistir, cómo autenticar)
- Deja **output usable** · si el resultado del taller es bueno, podemos construirlo de verdad la semana siguiente

---

## Post-taller · opción de seguir construyendo

Si el relay sale bien y hay ganas, podríamos:
- **Semana siguiente** · Sergio + Fede toman las tasks del DAG y las implementan
- **2 semanas** · PR listo · lo reviwean con `/code-review`
- **Mes 1** · skill `/favorites` disponible para todos · dogfood real

No lo prometemos hoy · pero si sale, queda de demo para Taller 2.

---

**Última actualización** · 2026-04-21 · Juan Estrada
