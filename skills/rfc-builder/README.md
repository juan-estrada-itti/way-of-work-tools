# RFC Builder Skill / Skill Constructor de RFCs

## Descripción / Description

Skill interactiva para construir documentos RFC (Request for Comments) técnicos a partir de un PRD (Product Requirements Document) o descripción de problema. Utiliza un flujo híbrido de 4 fases que combina descubrimiento interactivo con análisis automático del codebase.

Interactive skill to build technical RFC (Request for Comments) documents from a PRD (Product Requirements Document) or problem description. Uses a 4-phase hybrid flow combining interactive discovery with automatic codebase analysis.

## Flujo de Trabajo / Workflow

### Fase 1: Descubrimiento / Discovery
Se realizan 5-6 preguntas clave para entender el contexto:
- Tipo de RFC (Feature, Infraestructura, Migración, etc.)
- Problema que resuelve
- Sistemas impactados
- Restricciones y requerimientos no funcionales
- Audiencia del documento

### Fase 2: Análisis de Codebase / Codebase Analysis
Exploración automática del código fuente para identificar:
- Estructura del proyecto y stack tecnológico
- Patrones existentes y convenciones
- Puntos de integración
- Configuraciones de CI/CD

### Fase 3: Generación del Draft / Draft Generation
Genera un RFC completo en Markdown con 9 secciones estándar:
1. Contexto y problema
2. Impacto y métricas
3. Objetivos y requerimientos
4. Propuesta de solución
5. Alternativas consideradas
6. Plan de implementación
7. Testing y validación
8. Riesgos y mitigaciones
9. Glosario

### Fase 4: Iteración / Iteration
Refinamiento sección por sección hasta satisfacción completa.

## Uso / Usage

Activa el skill con frases como:
- "Necesito crear un RFC para..."
- "Construir una propuesta técnica basada en este PRD"
- "Generar un RFC de migración para..."

## Archivos de Referencia / Reference Files

| Archivo / File | Propósito / Purpose |
|---|---|
| `SKILL.md` | Instrucciones principales del skill / Main skill instructions |
| `references/rfc-template.md` | Template completo con 9 secciones / Complete template with 9 sections |
| `references/rfc-sections-guide.md` | Guía de énfasis por tipo de RFC / Emphasis guide by RFC type |
| `references/quality-checklist.md` | Checklist de calidad de 12 puntos / 12-point quality checklist |
| `references/rfc-example-summary.md` | Ejemplo resumido de un RFC real / Summarized example of a real RFC |

## Compatibilidad / Compatibility

Este skill es compatible con:
- **GitHub Copilot Agent Skills** (`.github/skills/rfc-builder/`)
- **Claude Code Skills** (`.claude/skills/rfc-builder/`)
- **Claude Desktop / Cowork** (como skill independiente)

This skill is compatible with:
- **GitHub Copilot Agent Skills** (`.github/skills/rfc-builder/`)
- **Claude Code Skills** (`.claude/skills/rfc-builder/`)
- **Claude Desktop / Cowork** (as standalone skill)
