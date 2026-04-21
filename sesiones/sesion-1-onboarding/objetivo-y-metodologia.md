# Objetivo + metodología · cómo trabajamos juntos

**Para qué sirve este archivo**
Es el **corazón del taller de mañana** · responde *"por qué estamos acá y cómo vamos a caminar juntos el próximo mes"*.

**Cuánto dura en el taller** · 12 min

---

## Parte 1 · Por qué estamos acá

Somos **20 personas en tech emergentes** trabajando en iniciativas · academy y ittilab en producción · varias más viniendo.

Hoy pasa esto:
- **Cada uno resuelve igual**, con distintos resultados
- **No se reusa el aprendizaje** · lo que Fede descubre, Juan Manuel lo descubre de nuevo la semana siguiente
- **Las decisiones viven en la cabeza** · nadie sabe por qué se eligió X
- **Los nuevos tardan meses en entender cómo trabajamos**

**La hipótesis** · si acordamos un *way of work* común, un lenguaje común, y herramientas que lo soporten · **escalamos sin fricción**.

---

## Parte 2 · Qué queremos lograr juntos (en 1 mes)

Al final de las 5 sesiones del plan, el equipo sabe:

1. **Hablar el mismo idioma** · cuando alguien dice "ADR" o "historia INVEST" · todos entendemos lo mismo
2. **Tener un pipeline común** · idea → PRD → RFC → ADRs → contrato → historias → tasks → código → review · siempre en este orden
3. **Usar herramientas que lo soportan** · skills en Claude Code · rules en Cursor · MCPs para conectar con Jira/Slack/GitHub
4. **Contribuir al sistema** · si notás que falta algo · armás una skill y la compartís

**Meta cuantitativa** · que al fin del mes, **arrancar una iniciativa nueva lleve horas, no semanas**.

---

## Parte 3 · Cómo nos vamos a acompañar

### Rol de cada uno

| Rol | Quién | Qué hace |
|---|---|---|
| **Facilitador principal** | Juan | Diseña sesiones · modera talleres · 1-on-1s |
| **Soporte operativo** | Alejo | Cuida chat del taller · emoji signals · plan B técnico |
| **Líder técnico invitado** | Javier (a veces) | Aporta perspectiva arquitectónica |
| **Participantes** | Los 16 | Traen iniciativas reales · practican el flujo |

### Formato de cada sesión

- **Sesión 1 (hoy)** · onboarding · 1h · video-call · sin ejercicio práctico
- **Sesión 2 en adelante** · formato **des-conferencia** · reglas primero → demo → juego (relay) → teoría al final
- **Todas las sesiones** · se graban · el material queda en `shared_knowledge_iter_N/`

### Cadencia

- **1 sesión por semana** · viernes por defecto · horario que acomode a todos
- **Entre sesiones** · 1-on-1s opcionales con Juan (miércoles) para aplicar a tu iniciativa
- **Slack** · canal permanente `#way-of-work` · preguntas cortas · respuestas asíncronas

### Compromiso del participante

**Lo que pedimos** (realista, no ambicioso):
- Venir a las 5 sesiones (si falta una, recupera con el video)
- Probar al menos **1 skill en 1 iniciativa real** entre sesiones
- Reportar en Slack cuando algo rompe · para mejorar el pipeline

**Lo que NO pedimos** · no pedimos que cambien **cómo codean hoy** · pedimos que **prueben** el flujo en 1 feature.

---

## Parte 4 · Principios del way of work (4 reglas duras)

Estas 4 reglas son **no-negociables** · todo lo demás es ajustable.

### V1 · El PRD de negocio manda
El PRD técnico puede **agregar rigor** · nunca puede **quitar alcance** del PRD de negocio.

**Ejemplo** · PM dice "necesitamos login con Google" · tech dice "mejor GitHub porque es más fácil". **NO**. Tech puede proponer cómo implementar login con Google, no cambiar la decisión.

### V2 · Validar contra el PRD hasta el RFC
Cada paso del pipeline se valida contra el PRD de negocio · hasta que llegamos al RFC. Después ya está el specs técnico como fuente.

**Ejemplo** · Fede arma un RFC que dice "además agregamos logs" · alguien dice "¿eso está en el PRD?" · si no, se saca o se agrega al PRD con aprobación.

### V3 · CLAUDE.md obligatorio antes de codear
Ningún repo arranca a codear sin `CLAUDE.md` en la raíz · ahí viven las convenciones del proyecto (estilo, testing, estructura de carpetas).

**Por qué** · sin CLAUDE.md, cada skill genera código distinto · caos.

### V4 · RFC grande → partir en ADRs
Si un RFC tiene más de 5 decisiones arquitectónicas · se parte en ADRs **antes** de definir contratos. Una decisión por ADR. Así se versiona cada una independientemente.

**Por qué** · si cambia una decisión, cambiás 1 ADR · no re-escribís todo el RFC.

---

## Parte 5 · Cómo medimos si esto funciona

Al mes 2, miramos:

| Métrica | Qué mide |
|---|---|
| Iniciativas que arrancaron con el pipeline | Adopción |
| PRDs en el formato estándar (vs texto libre) | Alineamiento |
| ADRs creados | Decisiones documentadas vs de memoria |
| Tiempo de onboarding de nuevos al equipo | Reducción de fricción |
| Número de skills propias creadas por el equipo | Capacidad de contribución |

Si las métricas mejoran · seguimos. Si no · retro abierta, ajustamos o paramos. **No casamos con el método.**

---

## Parte 6 · Para cerrar el bloque mañana

Juan dice al grupo:

> *"Lo que vamos a construir juntos en el próximo mes no es un proceso más · es el lenguaje común que nos permite crecer sin perder identidad. Vengan curiosos, vengan críticos. Si algo no cierra, lo discutimos y lo ajustamos."*

Y luego · *"Ahora el glosario · los términos clave en 8 min"*.

---

**Última actualización** · 2026-04-21 · Juan Estrada
