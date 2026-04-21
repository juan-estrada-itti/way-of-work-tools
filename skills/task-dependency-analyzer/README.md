# Task Dependency Analyzer / Analizador de Dependencias de Tareas

## Descripción / Description

Skill para descomponer planes técnicos en un grafo de dependencias que muestra qué tareas pueden ejecutarse en paralelo y cuáles deben ser secuenciales. Produce diagramas Mermaid con fases de ejecución, ruta crítica, y un JSON compatible con Agents Kanban Local.

Skill to decompose technical plans into a dependency graph showing which tasks can run in parallel and which must be sequential. Produces Mermaid diagrams with execution phases, critical path, and an Agents Kanban Local compatible JSON.

## Tipos de Dependencia / Dependency Types

1. **Data/Schema** — Task B necesita un schema que Task A crea / Task B needs a schema that Task A creates
2. **Interface/Contract** — Task B llama una función que Task A implementa / Task B calls a function that Task A implements
3. **Infrastructure** — Task B necesita infra que Task A provisiona / Task B needs infra that Task A provisions
4. **Logical/Semantic** — Decisiones de diseño en A restringen B / Design decisions in A constrain B

## Falsas Dependencias / False Dependencies

El skill también identifica y alerta sobre falsas dependencias:
- Archivo compartido pero secciones diferentes / Shared file but different sections
- Mismo dominio pero features diferentes / Same domain but different features
- Lectura compartida sin escritura / Read-only sharing
- Dependencias de convención (no reales) / Convention dependencies (not real)

## Output

### Diagrama Mermaid / Mermaid Diagram
Grafo con tareas agrupadas por fase de ejecución, arrows con tipo de dependencia, y ruta crítica resaltada.

### Tabla de Análisis / Analysis Table
Resumen con: total de tareas, fases, máximo paralelismo, ruta crítica, y razonamiento por dependencia.

### JSON para Kanban / Kanban JSON
Payload listo para POST a `/api/tasks/bulk` del Agents Kanban Local.

## Uso / Usage

Activa el skill con frases como:
- "Analiza las dependencias de estas tareas"
- "¿Cuáles de estas tareas pueden correr en paralelo?"
- "Genera un DAG de ejecución para este plan"
- "What depends on what in this task list?"
- "Show me the critical path"

## Archivos / Files

| Archivo / File | Propósito / Purpose |
|---|---|
| `SKILL.md` | Instrucciones completas del skill / Complete skill instructions |
| `skill.json` | Metadatos y triggers / Metadata and triggers |

## Compatibilidad / Compatibility

- **Claude Code Skills** (`.claude/skills/task-dependency-analyzer/`)
- **GitHub Copilot Agent Skills** (`.github/skills/task-dependency-analyzer/`)
- **Claude Desktop / Cowork** (como skill independiente)
