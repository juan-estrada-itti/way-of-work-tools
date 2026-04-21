---
name: create-prd
version: 2.1.0
author: tech-emergentes-team
description: "Document a Product Requirements Document based on completed discovery work. Translate research findings, user insights, and validated problems into a clear specification answering WHAT to build and WHY. Use when documenting product requirements after discovery, preparing a feature spec, or aligning stakeholders."

triggers:
  - create-prd
  - write-prd
  - prd-document
  - product-requirements
  - crear-prd

# ─── NUEVO en v2 · schema del grafo de dependencias ─────────
pipeline:
  phase: prd
  applies_to: [greenfield, brownfield]
  position_greenfield: 2
  position_brownfield: 5

dependencies:
  consumes:
    - artifact: discovery.md
      produced_by: office-hours
      path_hint: docs/00-discovery/discovery.md
      required: true
      note: "el discovery puede venir de /office-hours o de research existente"
    - artifact: user-interviews
      produced_by: null
      path_hint: docs/00-discovery/interviews/
      required: false
    - artifact: assessment.md
      produced_by: journey-ddd-evaluator
      path_hint: docs/00-brownfield-discovery/assessment.md
      required: false
      note: "solo en brownfield · aporta contexto de sistema existente"

  produces:
    - artifact: prd.md
      path_hint: docs/01-prd/prd.md
      cardinality: 1..1

  upstream: [office-hours]
  downstream: [rfc-builder, prd-slice]
---

# Create a Product Requirements Document

## Purpose

You are documenting a PRD based on **discovery work already completed** for $ARGUMENTS.

The PRD answers two critical questions:
- **WHAT** will we build? (feature description, scope, wireframes)
- **WHY** are we building it? (the problem, user evidence, success metrics)

This document is written for **PM, engineers, designers, and stakeholders** to understand the problem and proposed solution without technical implementation details.

## Context

A practical PRD is:
- **Evidence-based** — grounded in discovery findings, user interviews, and validated assumptions
- **User-centered** — focused on the problem users validated and the jobs they need to do
- **Scope-clear** — explicit about what ships in v1 and what doesn't
- **Measurable** — defines how you'll know if it worked
- **Not a spec** — no code, SQL, API endpoints, or technical decisions here; that's for technical design docs

## ⚠️ CRITICAL RULE: No Hallucination

**You MUST NOT invent, assume, or guess information. Every statement comes from discovery.**

- **If user didn't validate something** → Mark as "❌ [Not validated in discovery]"
- **If metrics weren't defined** → Write "[To be defined with team]"
- **If competitive advantage is unclear** → "Competitive advantage: [Needs validation]"
- **If scope is undefined** → "Scope: [Pending clarification with stakeholders]"

**Missing information = incomplete discovery. Flag it. Don't invent it.**


## Instructions

### Step 0: MANDATORY — Gather & Validate Discovery

#### PART A: Validate the Problem is Real (Not Invented)

⚠️ **CRITICAL:** Before documenting anything, CHALLENGE the problem statement:

**Ask the user these validation questions:**

1. **Evidence of the problem:**
   - How many users did you actually interview about this pain? (If <3, it's not validated)
   - What evidence do you have? (Quotes, frequency data, impact metrics)
   - Did users spontaneously mention this, or did you have to probe to get them to say it?
   - ❌ BAD: "Users mentioned they lose time searching" (vague)
   - ✅ GOOD: "6/8 users interviewed said finding old visitor records takes 2+ hours. One quote: 'I've lost searches in five different spreadsheets'"

2. **Is this worth solving?**
   - What's the impact if this problem goes unsolved? (User frustration, compliance risk, business cost)
   - How many users have this problem? (10? 100? 1000?)
   - Who owns solving this? Is the user/company actually willing to invest in a solution?
   - ❌ BAD: "This would be nice to fix" (nice-to-have, not validated)
   - ✅ GOOD: "This causes 2+ hours of wasted time per week. It's a compliance liability if we can't audit access."

3. **Is this the real problem, or a symptom?**
   - Why does this pain exist? What's the root cause?
   - Have users suggested solutions, or just complained about the pain?
   - ❌ ACCEPTING: "Users want a mobile app" (premature solution)
   - ✅ PUSHING BACK: "Actually, WHY do they want mobile? They're desk-bound. Real problem might be visibility, not location."

**Flag discovery gaps explicitly:**
- If you interviewed <3 users → "[Problem validated with N users only — recommend broader validation]"
- If impact is unclear → "[Impact: claimed to save 2h/week — needs measurement baseline]"
- If only anecdotal → "[Anecdotal evidence only — recommend quantifying impact]"


#### PART B: Discover the Job to Be Done (Before Writing User Stories)

⚠️ **CRITICAL:** User Stories WITHOUT JTBD are just feature lists. Before Step 2, extract the JTBD:

**Ask the user:**

1. **What is the user trying to accomplish?** (The job, not the feature)
   - ❌ "Register visitor entries"
   - ✅ "Know who is in the building at any moment and audit access if needed"

2. **Why does the user want to do this job?** (The motivation)
   - "Because I need to comply with security regulations"
   - "Because I need to respond to security incidents fast"
   - "Because unauthorized people entering is a compliance liability"

3. **What's the outcome the user wants?** (Success definition)
   - "I can audit who was here in <5 minutes vs. 2 hours currently"
   - "I can immediately prove compliance if audited"
   - "I can spot unauthorized access patterns"

**Document JTBD for each user segment:**

| User | What Job | Why | Desired Outcome |
|------|----------|-----|------------------|
| Portero | Register entry/exit cleanly | Track who's in building | System of record, not scattered notes |
| Gerente Seguridad | Audit access quickly | Compliance + incident response | <5 min lookup vs. 2h manual search |
| Ocupante | Know who visited | Security awareness | Confirmation when visitor arrives |

**Do NOT write User Stories until JTBD is crystal clear.** Stories should flow from jobs, not from guessing what features sound useful.


⚠️ **CRITICAL - Apply No-Hallucination Rule:**
- If a detail was NOT mentioned in discovery → DO NOT ADD IT to the PRD
- Examples of hallucinations to avoid:
  - ❌ "small building" (building size not mentioned)
  - ❌ "50+ daily entries" (volume never specified)
  - ❌ "mediocre performance PCs" (unless explicitly told)
  - ❌ Any adjective or number not directly from user
- ✅ Instead, mark unknowns: "[To be determined]" or "[Not specified in discovery]"

Before writing, collect ALL discovery artifacts:

**Ask the user to provide:**
- Discovery research notes, user interview transcripts, or summaries
- List of validated user problems and pain points with evidence
- User personas or segments that were researched
- Design artifacts (wireframes, prototypes, flows) from discovery
- Success metrics or KPIs already discussed with stakeholders
- Constraints discovered (regulatory, technical, budget, timeline)
- Competitive analysis or substitute solutions users mentioned

**Clarifying questions:**
- Which user problem did you validate the most? (With how many users?)
- Who owns this decision? Who are the key stakeholders?
- What does success look like? (Early metrics, OKRs, or baseline to target)
- What hard constraints were discovered?
- Does design already exist, or is it TBD?

**Only after you have discovery artifacts, proceed to Step 1.**


### Step 1: Extract Insights from Discovery

- Identify **validated assumptions** vs. **remaining unknowns**
- Extract **user pain points** directly from interview notes
- Collect **user quotes** that illustrate the pain
- Document **design decisions** already validated with users
- Note **evidence** (frequency, impact, number of users mentioning it)


### Step 2: Write User Stories (ONLY After JTBD is Clear)

⚠️ **PRECONDITION:** If JTBD is unclear, STOP. Don't write stories yet. Unclear JTBD = you'll write feature lists, not user-centered stories.

**Validate before proceeding:**
- ✅ Can you describe each user's job in 1 sentence?
- ✅ For each job, can you explain WHY it matters?
- ✅ Do you know what success looks like for each job?

**If any are NO:** Go back to Part B above. Interview more, ask deeper questions. Do not proceed.

**If all are YES:** Write stories FROM the JTBD, not FROM feature hunches.

Format: "As a [role doing a JOB], I want to [action that serves the job], so that [job outcome is achieved]"

Example FROM JTBD:
- JTBD: Portero needs to "register access cleanly in one system"
- Story: "As a Portero, I want to search for a visitor and confirm arrival in <3 clicks, so that I don't return to manual paper logs"

Example WRONG (feature-driven, not JTBD-driven):
- Story: "As a Portero, I want a mobile app, so that I can register access from anywhere"
- Problem: No JTBD. Why mobile? Portero is desk-bound. This is hallucination masquerading as a story.


### Step 2b: Document the PRD Using This Structure


## PRD Template — 8 Sections

### **1. Contacts**

List key stakeholders with role and decision authority.

| Stakeholder | Role | Contact | Notes |
|------------|------|---------|-------|
| [Name] | PM / Dev Lead / Designer | [Email] | Decision authority |


### **2. Problem**

**What pain does the user have today?** Ground this entirely in discovery.

State the problem clearly. Include:
- **Who** experiences this problem (persona/segment validated in discovery)
- **What** is the specific pain point
- **Evidence** from discovery (user quotes, frequency, how many users mentioned it)
- **Current workaround** or how they solve it today

Example format:
> "Product managers at mid-size SaaS struggle to consolidate feature requests from 5+ channels (Slack, email, Intercom, GitHub). Today they spend 4+ hours/week manually copying notes into a spreadsheet.
>
> *Evidence: 6/8 interviewed PMs mentioned this pain. Average time reported: 3-5 hours/week. Quotes: 'I'm constantly switching between five apps,' 'I've lost important requests in Slack threads.'*"


### **3. Hypothesis**

**If we do X, then Y, measured by Z.**

This translates discovery findings into an expected outcome.

Format:
- **If** [describe solution idea from discovery / user feedback]
- **Then** [expected outcome for user]
- **Measured by** [how you'll validate this assumption post-launch]

Example:
> "If we build a unified inbox for feature requests across all channels, then product managers will save 3+ hours/week, measured by time tracking before/after launch and user surveys."


### **4. User Stories** (Grounded in JTBD)

**How does the user accomplish their job? What actions serve their job-to-be-done?**

⚠️ **These stories MUST trace back to JTBD identified in Step 0 Part B.** If they don't, they're feature lists, not user stories.

**Format:** "As a [role DOING A JOB], I want to [action SERVING THE JOB], so that [JOB OUTCOME is achieved]"

**Link to JTBD explicitly in each story.**

Example (CORRECT - JTBD-grounded):
```
**JTBD: Portero needs to register access in one system of record (not scattered notes)**

Story 1: Register visitor cleanly
As a Portero working to maintain a single system of record,
I want to search for a visitor by name/DNI and confirm arrival in <3 clicks,
so that I'm never tempted to go back to scattered notes/paper logs.

Acceptance Criteria:
- [ ] Search field auto-suggests names as I type
- [ ] Visitor shows authorization status and destination office
- [ ] One-click "Confirm Entry" with auto-timestamp
- [ ] Confirmation appears in instant feed so next person can see who just arrived
```

Example (WRONG - feature-driven, not JTBD-grounded):
```
Story: Mobile app for visitor registration
As a Portero,
I want a mobile app,
so that I can register access from anywhere.

Problem: This story doesn't serve JTBD. Portero is desk-bound. "Anywhere" is hallucination.
It's a feature guess, not a validated job. REJECT this story.
```

**Include 4-6 stories that cover core user jobs.** Each story should:
1. Link explicitly to JTBD
2. Use job-oriented language ("in order to," "maintain," "ensure") not feature language ("add," "build," "integrate")
3. Have acceptance criteria testable against JTBD success


### **5. Design (Wireframes + Flows)**

**How does the solution look to the user?**

Include:
- **Wireframes** or screenshots showing the main screens
- **User flows** showing the journey through the solution
- **Key interactions** (what happens when user clicks X?)

**Status:**
- ✅ If design exists from discovery: Embed links or attach screenshots
- ⚠️ If design is TBD: Clearly state "Design phase: [TBD / Pending / In progress]"

Do NOT include:
- Technical architecture diagrams
- API endpoint specs
- Database schemas
- Code snippets


### **6. Scope (MVP vs. Future)**

**What goes in v1? What doesn't (yet)?**

Create two lists:

**V1 (MVP — this release):**
- [Feature A]
- [Feature B]
- [User Stories 1, 2, 3]

**Future (not in MVP — nice-to-have or post-PMF):**
- [Feature C — discover demand first]
- [Performance optimization — build after PMF]
- [Admin dashboard — post-launch]

**Why it matters:** Scope discipline prevents feature creep and keeps focus on core problem.


### **7. Success Metrics & Baseline**

**How will you know this worked?**

Define for each metric:
- **Baseline** — current state (before launch) or starting point
- **Target** — desired state (1 month post-launch, or next quarter)
- **How to measure** — the mechanism (analytics, surveys, etc.)
- **Owner** — who tracks this

Example:

| Metric | Baseline | Target (1mo) | How to measure | Owner |
|--------|----------|-------------|-----------------|-------|
| Time per day consolidating | 4 hrs/week | <5 min/day | Session tracking | Analytics |
| % Requests unified | 0% | 85%+ channels connected | Manual audit | PM |
| User satisfaction | N/A | 8+/10 NPS | Post-launch survey | Product |
| Adoption rate | N/A | 60%+ of target users | Product funnel | Analytics |


### **8. NFRs (Non-Functional Requirements)**

**Quality attributes needed for this to work.** High-level only — no HOW.

- **Performance:** API responses <200ms; UI loads in <2s
- **Security:** [Compliance requirement discovered] — e.g., "Users' email must be encrypted"
- **Scalability:** Handle 10k requests/month by launch
- **Reliability:** 99.5% uptime SLA

Do NOT specify HOW to achieve these. That's for technical design docs and architecture decisions.


## What This PRD Does NOT Include

⛔ **NOT in scope:**
- Code, classes, functions, endpoints
- SQL queries or database design
- API specifications → separate API spec doc
- Technical architecture decisions
- Deployment pipelines
- Implementation details
- System design or infrastructure decisions

These belong in **technical design documents, architecture decision records (ADRs), and API specs** — not the PRD.


## Writing Guidelines

1. **Use plain language** — a PM, designer, and engineer should all understand it without jargon
2. **Be specific** — avoid vague terms like "improve," "better," "faster" without context
3. **Ground everything in discovery** — every claim should trace back to user research
4. **Be honest about unknowns** — flag discovery gaps; don't invent data
5. **Keep it concise** — 5-10 pages max (including wireframes)
6. **Reference evidence** — include user quotes, interview counts, frequency data


## Notes

### Critical Validation Points

1. **Problem Validity:**
   - ❌ DON'T accept "users mentioned" without evidence (quotes, frequency, impact)
   - ✅ DO ask: "With how many users? What exactly did they say? What's the impact?"
   - ❌ DON'T include problems validated with <3 users without flagging it
   - ✅ DO mark: "[Problem validated with 2 users only — recommend broader validation]"

2. **JTBD Clarity:**
   - ❌ DON'T write User Stories until JTBD is clear
   - ✅ DO require: "What is the user trying to accomplish (the job)? Why? What outcome?"
   - ❌ DON'T accept feature-driven stories ("I want a mobile app")
   - ✅ DO demand job-oriented stories ("I want to maintain one system of record")

3. **Discovery Completeness:**
   - A PRD built from discovery is faster to write and more defensible
   - **If sections feel empty, that's a signal: you may have incomplete discovery**
   - Flag discovery gaps explicitly — that's useful info for the team
   - Share this PRD with engineers and designers early; collect feedback; iterate
   - Revisit after launch: what assumptions held? what surprised you? Learn for next PRD


## References

See `REFERENCES.md` for supplementary resources on discovery, OKRs, user story writing, JTBD frameworks, and post-launch analysis.
