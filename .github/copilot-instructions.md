# Project Guidelines

## Stack
<!-- UPDATE: Replace with your project's tech stack after running /init-project -->
- TypeScript + React 19 + Vite
- Tailwind CSS for styling
- Vitest + React Testing Library for tests
- pnpm as package manager

## Code Style
<!-- UPDATE: Adjust to your team's preferences -->
- Functional components only
- Named exports, no default exports
- `const` arrow functions for components
- `interface` over `type` for object shapes

## Architecture
<!-- UPDATE: Match your project's structure -->
- Feature-based folders: `src/features/<name>/`
- Shared utilities in `src/shared/`

## Build & Test
<!-- UPDATE: Replace with your project's commands -->
- Install: `pnpm install`
- Dev: `pnpm dev`
- Test: `pnpm test`
- Build: `pnpm build`

## Agent Team
This project uses a 16-agent autonomous development team. See `.github/agents/` for all agents. Key workflows:
- `/build-app` — Full SDLC pipeline (all agents, all phases)
- `/add-feature` — Add a feature to an existing app (plan → build → test → review)
- `/fix-bug` — Diagnose and fix a bug with regression test
- `/init-project` — Customize this template for a new stack
- `@tech-lead` — Orchestrates the full team for complex features
- Individual agents (`@developer`, `@tester`, `@security`, etc.) for focused tasks

## Instructions
Stack-specific conventions are in `.github/instructions/`:
- `vibe-coding.instructions.md` — Core workflow and agent collaboration patterns
- `code-quality.instructions.md` — Naming, error handling, security, maintainability
- `component.instructions.md` — UI component patterns (UPDATE for your framework)
- `testing.instructions.md` — Testing patterns (UPDATE for your test framework)
- `agent-protocol.instructions.md` — Inter-agent handoff format
