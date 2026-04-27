---
applyTo: ".github/agents/*.agent.md"
description: "Communication protocol for agent-to-agent handoffs. Defines the standard format agents use to pass work products between phases."
---

# Agent Communication Protocol

Every agent MUST follow this protocol when completing work and handing off to the next agent.

## Shared Project Context (`docs/project-context.md`)

This is the **single source of truth** for the entire project. The tech-lead creates it at the start of Phase 1 and every agent reads it before starting work and appends to it after completing work.

### Structure

```markdown
# Project Context

## App Description
[One-paragraph description of the app]

## Stack
[Language, framework, styling, testing, package manager]

## User Stories
[Numbered list — copied from Phase 1]

## Architecture Decisions
[Appended by @architect — folder structure, patterns, key libraries]

## Design Decisions
[Appended by @designer — layout approach, component hierarchy, accessibility notes]

## API Contracts
[Appended by @architect or @backend-developer — endpoints, request/response shapes]

## Implementation Notes
[Appended by @developer/@backend-developer — deviations from plan, workarounds, known limitations]

## Test Coverage
[Appended by @tester — coverage matrix summary, test counts by category]

## Open Issues
[Any agent can append — unresolved items with owner tags]
```

### Rules for Project Context
1. **Tech-lead creates** this file at the start with App Description, Stack, and User Stories
2. **Every agent reads** `docs/project-context.md` before starting their phase
3. **Every agent appends** their decisions to the relevant section after completing work
4. **Never delete** another agent's entries — only append or annotate
5. **Keep entries concise** — reference `docs/phases/*.md` for full details

## Briefing Protocol

When the tech-lead delegates to an agent, the briefing MUST include:

```
### Task for @[agent-name]

**Read first**: docs/project-context.md
**Phase docs**: [list specific docs/phases/*.md files relevant to this agent]
**Your deliverable**: docs/phases/[NN]-[phase].md
**Specific instructions**: [what to do]
```

This ensures every agent has the full project context WITHOUT relying on the tech-lead to summarize it correctly.

## Handoff Format

When you complete your work, structure your output as:

```
## [ROLE] Phase Complete: [Phase Name]

### Deliverables
[List what you produced — with file paths]

### Context Updates
[What you added to docs/project-context.md]

### Decisions Made
[Key decisions and rationale]

### Constraints Discovered
[Anything the next agent needs to know]

### Open Questions
[Unresolved items — tag which agent should answer]

### Handoff To: @[next-agent]
[Specific instructions for what the next agent should do with your output]
```

## Rules
1. ALWAYS read `docs/project-context.md` before starting your phase
2. ALWAYS append your decisions to `docs/project-context.md` after completing
3. ALWAYS state what you produced and what's unresolved
4. ALWAYS name the next agent explicitly in the handoff
5. ALWAYS reference specific file paths and line numbers for artifacts
6. NEVER assume context — if it's not in project-context.md or your phase docs, ask
7. If you find a blocker, escalate to @tech-lead with `### BLOCKER:` prefix
