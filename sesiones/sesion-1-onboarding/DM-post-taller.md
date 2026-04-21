# DM post-taller · para los 16 participantes

**Cuándo mandarlo** · hoy mismo (21/4) · dentro de las próximas 4 horas · que llegue fresco
**Cómo** · uno a uno por Slack · no grupal · así cada uno responde si algo no anda
**Plazo del kit** · 3 días · hasta el jueves 24/4 a la noche (para llegar con todo listo al viernes)

---

## 4 placeholders a completar antes de mandar

Reemplazá estos 4 datos en la plantilla:

| Placeholder | Qué va |
|---|---|
| `<NOMBRE>` | Primer nombre del participante |
| `<LINK_KIT>` | URL del kit de instalación (repo público / Google Doc / Notion) |
| `<CANAL_SLACK>` | `#way-of-work` o el canal nuevo que crees |
| `<FECHA_VIERNES>` | Fecha + hora exacta del viernes (ej: *"viernes 25/4 a las 11:00"*) |

---

## Plantilla principal · para los 16

```
Hola <NOMBRE> ·

Gracias por el taller de hoy · buena energía, buenas preguntas.

Te dejo 2 cosas para que llegues listo/a al próximo viernes (<FECHA_VIERNES>):

1 · Instalá el kit en tu compu (30-40 min async)
   → <LINK_KIT>

   Es Claude Code + las 8 skills del pipeline. Está todo automatizado
   con un script · corrés 1 comando y listo.

   Plazo · antes del jueves a la noche. Si te trabás, pedime ayuda
   en <CANAL_SLACK> · respondo rápido.

2 · Pensá 1 idea de feature "greenfield" que te gustaría construir
   No la desarrolles · solo tenela en la cabeza · puede ser algo
   real de tu iniciativa o algo inventado.

   El viernes la usamos de input para el ejercicio en vivo ·
   relay de 8 parejas · vas a vivir el pipeline end-to-end.

La próxima es 2 horas · vamos al ejercicio real. Vale la pena.

Cualquier cosa me escribís ·
Juan
```

---

## Variante para los 4 no-técnicos · Ana María · Juan Pa · Leonardo · Juan Manuel

Mismo mensaje · pero cambiá el punto 1 por esto (más hand-holding):

```
1 · Instalá el kit en tu compu
   → <LINK_KIT>

   Si nunca usaste Claude Code desde terminal, no te asustes ·
   la guía te lleva paso a paso · tardás 40 min máximo.

   Agendá conmigo 20 min entre miércoles y jueves si preferís
   instalarlo juntos · <LINK_CALENDLY>. Cero problema.

   Plazo · jueves a la noche. En el canal <CANAL_SLACK> también
   te responden Sergio o Fede si me demoro.
```

---

## Variante para Alejo (soporte)

```
Alejo ·

Gracias por cuidar el chat hoy · impecable.

Para el viernes (<FECHA_VIERNES>) necesito que mantengas el rol:

1 · Monitoreo del canal <CANAL_SLACK> desde mañana · te van a pedir
   ayuda con la instalación. 5-6 preguntas esperables (FAQ abajo).

2 · El viernes · emoji signals otra vez:
   👀 atento · 🆘 ayuda · ✅ ok · 🔥 algo roto
   Esta vez el taller es de 2 horas · más espacio para que la
   cosa se enrede.

3 · Instalá el kit vos también (10 min) → <LINK_KIT>
   Así podés probar localmente lo que los demás te pregunten.

FAQ troubleshooting la armamos juntos esta tarde si podés ·
20 min de call y queda pineada en el canal.

Gracias máquina ·
Juan
```

---

## Variante para Javier (VP sponsor · Pareja 2)

```
Javier ·

Gracias por bancar el taller hoy · la presencia del VP cambia el tono.

Dos cosas:

1 · El kit de instalación · <LINK_KIT> · tu setup con Docker que
   me pasaste me sirvió de referencia para el setup-claude-docker.sh
   alternativo · si querés lo revisás en <RUTA_DOCKER_SCRIPT>.

2 · El próximo viernes (<FECHA_VIERNES>) · 2 horas · arrancamos con
   el relay de 8 parejas sobre greenfield. Tu pareja es con Sergio
   otra vez · fase PRD. Si podés estar 100% es clave para el
   seniority del grupo.

Si el timing no va, me avisás y ajustamos · pero ideal venir.

Cualquier cosa ·
Juan
```

---

## Mensaje al grupo (1 solo · en el canal #way-of-work)

Después de los DMs individuales, mandás esto al canal general:

```
Equipo ·

Taller 1 cerrado · tengo buenos aprendizajes.
Material completo acá · <LINK_KIT>

Para el próximo viernes (<FECHA_VIERNES>) · 2 horas · ejercicio
real end-to-end · relay de 8 parejas.

2 tareas async esta semana:

  • Instalar el kit (30-40 min)
  • Pensar 1 idea greenfield para traer al relay

Soporte en <CANAL_SLACK> · respondo durante la semana.

Feliz de cómo arrancamos. Vamos al toque ·
```

---

## FAQ interno · qué NO decir en los DMs

- ❌ *"es urgente"* · genera ansiedad innecesaria · es async, tienen 3 días
- ❌ *"si no instalás no venís"* · el viernes hacen relay por pareja · quien tenga setup ayuda al otro
- ❌ detalles técnicos del kit · eso está en el link · el DM solo tiene la ACCIÓN
- ❌ copiar-pegar el contenido del kit en el DM · demasiado · link suelto

---

## Timing sugerido de envío

| Hora | Qué |
|---|---|
| **Hoy 14:00** | DMs a los 16 técnicos primero (Sergio, Fede, Hugo, Luciano, Nicolás, German, Fernando...) |
| **Hoy 15:00** | DMs a los 4 no-técnicos (con variante) |
| **Hoy 15:30** | DMs especiales (Alejo, Javier, Andrés) |
| **Hoy 16:00** | Mensaje grupal al canal |
| **Martes 11:00** | Primer nudge en el canal · *"¿cómo va la instalación?"* |
| **Miércoles 15:00** | 1-on-1s con los no-técnicos que no pudieron |
| **Jueves 18:00** | Último nudge · *"los que faltan ajustan mañana a la mañana"* |

---

## Checklist antes de apretar send

- [ ] Los 4 placeholders están reemplazados (nada de `<NOMBRE>` suelto)
- [ ] El `<LINK_KIT>` funciona · abrilo en incógnito antes de mandar
- [ ] El `<CANAL_SLACK>` existe y los 16 están invitados
- [ ] Saludás con el nombre correcto (no confundir los 2 Nicolás)
- [ ] Uno a uno, no grupal

---

**Última actualización** · 2026-04-21 · Juan Estrada
