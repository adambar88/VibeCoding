---
applyTo: "**"
description: "Core vibe coding workflow instructions. Defines how agents should collaborate, how to use prompts and skills, and the autonomous development philosophy. Always active."
---

# Vibe Coding Workflow

## Philosophy
- Describe WHAT you want, not HOW to build it
- Let agents handle implementation details
- Review and iterate — don't micromanage
- Trust the pipeline: requirements → design → build → verify → ship

## Working with the Agent Team
- Use `@tech-lead` for complex multi-phase work — it orchestrates the full team
- Use individual agents (`@developer`, `@tester`, etc.) for focused single tasks
- Use `/build-app` to run the full autonomous SDLC pipeline
- Use `/add-feature` to add a feature to an existing app
- Use `/fix-bug` to diagnose and fix a bug with regression test
- Use `/init-project` to customize this template for a new tech stack

## Agent Communication Rules
- Agents pass context through structured handoffs (see agent-protocol.instructions.md)
- The tech-lead is the only agent that sees the full picture
- When delegating to an agent, include ALL context they need — agents have no memory of prior phases
- If an agent reports a BLOCKER, the tech-lead resolves it or escalates to the user

## Iteration Patterns
- After `/build-app` completes, iterate with targeted agent calls
- Use `@reviewer` to audit before committing
- Use `@security` before deploying anything with auth or user data
- Use `@tester` to cover new code paths after changes

## Quality Gates
- Every feature must pass: implementation → tests → review → security audit
- Do not skip phases to save time — the pipeline exists for a reason
- If a gate fails, fix and re-validate before proceeding
