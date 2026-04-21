# create-prd

Skill para documentar Product Requirements Documents (PRD) basados en **discovery completado**.

## Descripción

Este skill transforma hallazgos de discovery (investigación de usuario, dolor validado, restricciones) en un PRD pragmático que responde:
- **QUÉ** construiremos (features, scope, wireframes)
- **POR QUÉ** lo construimos (problema, evidencia, métricas de éxito)

El PRD está diseñado para ingenieros, diseñadores, PMs y stakeholders. **NO incluye detalles técnicos** (esos van en documentos de diseño técnico separados).

## Cuándo Usar

✅ **Usa este skill DESPUÉS de discovery completado:**
- Tienes notas de entrevistas de usuario
- Validaste el problema con usuarios reales
- Tienes diseños/wireframes o sabes si serán TBD
- Definiste métricas de éxito básicas
- Identificaste scope (MVP vs. futuro)

❌ **NO uses si:**
- No has hecho discovery aún → crea hipótesis primero
- Necesitas especificación técnica → usa un technical design doc
- No tienes evidencia de usuario → no inventes

## Cómo Invocar

### En Copilot Chat

Abre Copilot (`Ctrl+Alt+I`) y escribe:

```
Create-prd para app de control de acceso de edificios.
Aquí están mis notas de discovery: [adjunta archivo o describe hallazgos]
```

```
Write a PRD for unified inbox based on these user interviews [adjunta]
```

```
crear-prd: documentar feature de notificaciones automáticas
Tengo wireframes, no tengo métricas aún — ayuda a definirlas
```

## Estructura del PRD (8 Secciones)

### 1. Contacts
Stakeholders clave con rol y autoridad de decisión.

### 2. Problem
Qué dolor tiene el usuario hoy. Con evidencia de discovery (quotes, frecuencia, # usuarios).

### 3. Hypothesis
If [solución], then [resultado esperado], measured by [métrica].

### 4. User Stories
4-6 historias con formato: "As a [rol], I want [acción], so that [resultado]"
Incluye acceptance criteria.

### 5. Design
Wireframes, mockups, flujos de usuario. O marca claramente "TBD".

### 6. Scope
MVP vs. futuro. Qué entra en v1, qué no (y por qué).

### 7. Success Metrics
Baseline → Target. Cómo vas a medir. Owner.

### 8. NFRs
Requerimientos no-funcionales: performance, security, scalability, reliability.
Alto nivel. Sin especificar HOW.

## Ejemplo de Uso

**Input:**
```
Create-prd para feature de consolidado de requests.
Discovery:
- 6/8 PMs entrevistados gastan 4+ horas/semana consolidando requests
- Usan 5 canales: Slack, email, Intercom, GitHub, Asana
- Pierden solicitudes en threads de Slack
- Wireframes: tengo 3 pantallas en Figma
- Métricas: reducir a <5 min/día, 85%+ unificado en v1
```

**Output:** PRD estructurado con Problema (evidencia), Hipótesis, 4 User Stories, Scope claro (MVP = consolidado básico, futuro = AI), Métricas con baseline/target.

## Lenguaje

- Accesible para PMs, diseñadores e ingenieros sin jerga técnica
- Específico: "ahorra 3+ horas/semana" no "mejora productividad"
- Basado en evidencia: todas las claims traceable a discovery
- Honesto: marca gaps como "[To be researched]" — no inventes

## Regla Crítica: No Alucinación

⚠️ Si NO sabes algo → No lo inventes.

| Situación | ❌ MALO | ✅ BUENO |
|-----------|--------|---------|
| No validaste métrica | "Adopción será 60%" | "Adopción: [To be defined with eng]" |
| No sabes competencia | "Competidores: Slack, Teams" | "Competitive landscape: [Needs research]" |
| No tienes diseño | "Landing page con 3 secciones..." | "Design: TBD — pending user validation" |
| Info incompleta | Sales pitch | "Discovery gap: Falta validar con 3 más PMs" |

## Metadata

- **Version:** 2.0.0
- **Author:** tech-emergentes-team
- **Status:** Production Ready
- **Approach:** Post-Discovery, Pragmatic, Evidence-Based

## Triggers Soportados

- `create-prd` / `write-prd` / `prd-document`
- `product-requirements` / `crear-prd`

## Qué NO Incluye Este PRD

❌ Código, clases, functions
❌ SQL, queries, database design
❌ API specs → documento separado
❌ Decisiones de arquitectura → technical design doc
❌ Pipelines, deployment
❌ Detalles de implementación

## Notas

- Sé específico en tus requisitos iniciales para PRDs más precisos
- El skill puede buscar información web si proporcionás URLs o menciones de investigación
- Markdownify el output automáticamente para fácil edición
- Los supuestos se flagean claramente para validación futura

---

**Listo para usar.** Este skill detecta automáticamente discovery artifacts y construye PRDs pragmáticos.
