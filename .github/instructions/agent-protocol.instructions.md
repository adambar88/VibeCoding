---
applyTo: ".github/agents/*.agent.md"
description: "Communication protocol for agent-to-agent handoffs. Defines the standard format agents use to pass work products between phases."
---

# Agent Communication Protocol

Every agent MUST follow this protocol when completing work and handing off to the next agent.

## Handoff Format

When you complete your work, structure your output as:

```
## [ROLE] Phase Complete: [Phase Name]

### Deliverables
[List what you produced]

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
1. ALWAYS state what you produced and what's unresolved
2. ALWAYS name the next agent explicitly in the handoff
3. NEVER assume context — include all information the next agent needs
4. REFERENCE specific files, line numbers, or artifacts you created
5. If you find a blocker, escalate to @tech-lead with `### BLOCKER:` prefix
