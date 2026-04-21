# tools/

Herramientas auxiliares del way of work · más allá de skills y docs.

**Esta carpeta crece con el tiempo** · a medida que el equipo necesita nuevas herramientas (CLI helpers, scripts de automatización, integraciones, etc.) las sumamos acá.

---

## Qué va acá

Cosas que **no son skills** y **no son documentación**. Por ejemplo:

- Scripts para automatizar tareas repetitivas del pipeline
- CLIs helpers (ej: `wow init-repo` que bootstrapea un repo nuevo con CLAUDE.md + estructura)
- Convertidores (ej: `skill-to-rule.sh` que convierte una skill de Claude a una Rule de Cursor)
- Dashboards de métricas del pipeline
- Integraciones con Jira, GitHub, Slack (más allá de MCPs)

---

## Qué NO va acá

- **Skills** · van en `skills/`
- **Documentación** · va en `pipeline/` o `sesiones/`
- **Kit de instalación** · va en `kit/`

---

## Patrón para agregar una herramienta nueva

```
tools/<nombre-herramienta>/
├── README.md              · qué es · cómo se usa · cómo se instala
├── <archivos de la herramienta>
└── tests/                 · opcional
```

Al agregar:
1. Branch `feat/tools/<nombre>`
2. Documentás qué resuelve y por qué
3. PR con al menos 1 reviewer
4. Actualizás este README apuntando a la nueva herramienta

---

## Herramientas actuales

*(vacío por ahora · primera en sumarse: TBD)*

---

**Última actualización** · 2026-04-21
