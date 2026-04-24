# Vibe Coding with GitHub Copilot — Complete Guide

> **Vibe coding** = describing what you want in natural language and letting AI build it. This guide covers every GitHub Copilot feature that makes vibe coding fast, reliable, and production-ready.

---

## Table of Contents

1. [Core Setup](#1-core-setup)
2. [The 7 Customization Primitives](#2-the-7-customization-primitives)
3. [Workspace Instructions](#3-workspace-instructions)
4. [File-Specific Instructions](#4-file-specific-instructions)
5. [Reusable Prompts](#5-reusable-prompts)
6. [Custom Agents](#6-custom-agents)
7. [Skills](#7-skills)
8. [Hooks](#8-hooks)
9. [MCP Servers](#9-mcp-servers)
10. [Vibe Coding Workflow](#10-vibe-coding-workflow)
11. [Team Collaboration — Agent Team](#11-team-collaboration--agent-team)
12. [Autonomous SDLC — Building a Full App](#12-autonomous-sdlc--building-a-full-app)
13. [Power Features & Integrations](#13-power-features--integrations)
14. [Recommended Extensions](#14-recommended-extensions)
15. [Tips for Maximum Efficiency](#15-tips-for-maximum-efficiency)

---

## 1. Core Setup

### VS Code Settings

Enable these in your `settings.json`:

```jsonc
{
  // Use Agent mode by default (full autonomous coding)
  "chat.agent.enabled": true,

  // Show prompt file recommendations when starting new chats
  "chat.promptFilesRecommendations": true,

  // Enable MCP servers
  "chat.mcp.enabled": true,

  // Enable hooks
  "chat.agent.hooks": true
}
```

### Project Structure

Create this folder structure in any project to unlock all features:

```
your-project/
├── .github/
│   ├── copilot-instructions.md    # Workspace-wide instructions (always loaded)
│   ├── instructions/              # File-specific instructions (loaded on-demand)
│   │   ├── react.instructions.md
│   │   ├── testing.instructions.md
│   │   └── api.instructions.md
│   ├── prompts/                   # Reusable task templates (slash commands)
│   │   ├── create-component.prompt.md
│   │   ├── write-tests.prompt.md
│   │   └── review-code.prompt.md
│   ├── agents/                    # Custom AI agents with specific roles
│   │   ├── reviewer.agent.md
│   │   ├── architect.agent.md
│   │   └── tester.agent.md
│   ├── skills/                    # On-demand workflows with bundled assets
│   │   └── deploy/
│   │       ├── SKILL.md
│   │       ├── scripts/
│   │       └── references/
│   └── hooks/                     # Lifecycle automation
│       └── pre-commit.json
├── .vscode/
│   ├── mcp.json                   # MCP server configuration
│   └── settings.json
└── ...
```

---

## 2. The 7 Customization Primitives

| Primitive | When to Use | Loaded |
|-----------|-------------|--------|
| **Workspace Instructions** | Always-on project standards | Automatically, every request |
| **File Instructions** | Language/framework specific rules | On file match or task relevance |
| **Prompts** | Reusable single-task templates | On-demand via `/` slash command |
| **Custom Agents** | Role-specific personas with tool restrictions | Manual selection or subagent |
| **Skills** | Multi-step workflows with scripts/templates | On-demand via `/` or auto-detected |
| **Hooks** | Deterministic enforcement (block, validate, format) | At lifecycle events |
| **MCP Servers** | External system integration (GitHub, DB, APIs) | Configured in `.vscode/mcp.json` |

### Decision Flowchart

```
Does it apply to EVERY task?
  → Yes → Workspace Instructions (copilot-instructions.md)
  → No  → Does it apply to specific FILE TYPES?
            → Yes → File Instructions (.instructions.md with applyTo)
            → No  → Is it a SINGLE focused task?
                      → Yes → Prompt (.prompt.md)
                      → No  → Does it need TOOL RESTRICTIONS or role isolation?
                                → Yes → Custom Agent (.agent.md)
                                → No  → Is it a MULTI-STEP workflow with assets?
                                          → Yes → Skill (SKILL.md)
                                          → No  → Does it need EXTERNAL system access?
                                                    → Yes → MCP Server
                                                    → No  → Must behavior be GUARANTEED?
                                                              → Yes → Hook (.json)
```

---

## 3. Workspace Instructions

**File**: `.github/copilot-instructions.md`  
**Purpose**: Always-on rules for every chat request.

### Example

```markdown
# Project Guidelines

## Stack
- React 19 + TypeScript 5 + Vite
- Tailwind CSS for styling
- Vitest + React Testing Library for tests

## Code Style
- Functional components only, no class components
- Use named exports, not default exports
- Prefer `const` arrow functions for components
- Use `interface` over `type` for object shapes

## Architecture
- Feature-based folder structure: `src/features/<name>/`
- Each feature has: components/, hooks/, utils/, types.ts
- Shared utilities in `src/shared/`

## Conventions
- All API calls go through `src/shared/api/client.ts`
- Use React Query for server state
- Use Zustand for client state
- Test files colocated: `Component.test.tsx` next to `Component.tsx`

## Build & Test
- Install: `pnpm install`
- Dev: `pnpm dev`
- Test: `pnpm test`
- Build: `pnpm build`
```

> **Tip**: Keep this concise. Link to detailed docs instead of embedding them.

---

## 4. File-Specific Instructions

**Location**: `.github/instructions/*.instructions.md`  
**Purpose**: Guidelines that load only when relevant.

### Two Discovery Modes

1. **Explicit** (`applyTo`): Auto-attached when matching files are in context
2. **On-demand** (`description`): Agent loads when task matches keywords

### Example: React Instructions

```markdown
---
applyTo: "**/*.tsx"
description: "Use when creating or editing React components. Covers component patterns, hooks, and JSX conventions."
---

# React Component Guidelines

- Use `React.FC` sparingly — prefer explicit prop types
- Extract custom hooks when logic is reused across 2+ components
- Use `Suspense` boundaries for async components
- Prefer composition over prop drilling (use Context or Zustand)

## Component Template
```tsx
interface Props {
  title: string;
  onAction: () => void;
}

export const MyComponent = ({ title, onAction }: Props) => {
  return <button onClick={onAction}>{title}</button>;
};
```

### Example: Testing Instructions

```markdown
---
applyTo: "**/*.test.{ts,tsx}"
description: "Use when writing or modifying tests. Covers Vitest patterns, React Testing Library usage, and mocking strategies."
---

# Testing Guidelines

- Use `describe` / `it` blocks, not `test`
- Test behavior, not implementation
- Use `screen.getByRole()` over `getByTestId()`
- Mock at the module boundary, not internal functions
- Each test should be independent — no shared mutable state
```

### Example: API Instructions (On-Demand)

```markdown
---
description: "Use when working with REST APIs, HTTP clients, fetch calls, Axios, or API route handlers. Covers error handling, authentication, and response typing."
---

# API Guidelines

- All API calls use the shared client at `src/shared/api/client.ts`
- Always type request and response bodies
- Handle errors with the `ApiError` class
- Include retry logic for transient failures (503, 429)
- Never store tokens in localStorage — use httpOnly cookies
```

---

## 5. Reusable Prompts

**Location**: `.github/prompts/*.prompt.md`  
**Purpose**: Slash-command templates for common tasks.

### Example: Create Component

```markdown
---
description: "Scaffold a new React component with types, tests, and story file"
agent: "agent"
tools: [read, edit, search]
---

Create a new React component with the following:
1. Component file with TypeScript props interface
2. Colocated test file using Vitest + React Testing Library
3. Follow existing patterns found in `src/features/`

Component name and requirements: {{input}}
```

### Example: Write Tests

```markdown
---
description: "Generate comprehensive tests for the selected code"
agent: "agent"
tools: [read, edit, search, execute]
---

Write tests for the provided code:
- Cover happy path, edge cases, and error scenarios
- Use Vitest + React Testing Library
- Follow patterns from existing test files
- Run `pnpm test` to verify tests pass
```

### Example: Code Review

```markdown
---
description: "Review code for bugs, performance issues, and best practice violations"
agent: "agent"
tools: [read, search]
---

Review the provided code for:
1. **Bugs**: Logic errors, null/undefined risks, race conditions
2. **Performance**: Unnecessary re-renders, missing memoization, N+1 queries
3. **Security**: XSS, injection, exposed secrets
4. **Maintainability**: Naming, complexity, missing types

Format: List issues by severity (Critical > Warning > Suggestion)
```

### Invoking Prompts

- Type `/` in chat → pick from the list
- Or: `Cmd+Shift+P` → "Chat: Run Prompt..."
- Or: Open the `.prompt.md` file → click the play button

---

## 6. Custom Agents

**Location**: `.github/agents/*.agent.md`  
**Purpose**: Specialized AI personas with specific tools and behaviors.

### Example: Code Reviewer Agent

```markdown
---
description: "Use for code review, security audits, and quality checks. Read-only — never modifies code."
tools: [read, search]
---

You are a senior code reviewer. Your job is to find bugs, security issues, and anti-patterns.

## Constraints
- NEVER edit or create files
- NEVER run commands
- ONLY analyze and report

## Review Checklist
1. Security vulnerabilities (OWASP Top 10)
2. Performance anti-patterns
3. Error handling gaps
4. Type safety issues
5. Test coverage gaps

## Output Format
For each issue:
- **File**: path and line
- **Severity**: Critical / Warning / Info
- **Issue**: What's wrong
- **Fix**: How to resolve
```

### Example: Architect Agent

```markdown
---
description: "Use for system design, architecture decisions, folder structure, and dependency management. Research-only."
tools: [read, search, web]
---

You are a software architect. Analyze codebases and propose architectural improvements.

## Constraints
- DO NOT modify code directly
- DO propose changes with clear rationale
- DO reference existing patterns in the codebase

## Approach
1. Analyze current architecture and dependencies
2. Identify coupling, complexity, and scalability issues
3. Propose improvements with trade-off analysis
```

### Example: Tester Agent

```markdown
---
description: "Use when writing, fixing, or running tests. Specialized in test strategy and debugging test failures."
tools: [read, edit, search, execute]
---

You are a testing specialist. Write comprehensive tests and debug test failures.

## Approach
1. Analyze the code under test
2. Identify all code paths and edge cases
3. Write tests following project conventions
4. Run tests and fix failures
5. Verify coverage improvements
```

### Subagent Orchestration

Agents can invoke other agents. For example, a "lead developer" agent can delegate:

```markdown
---
description: "Full-stack development lead. Delegates to specialist agents."
tools: [read, edit, search, execute, agent]
agents: [reviewer, tester, architect]
---

You are a development lead. For complex tasks:
1. Use @architect for design decisions
2. Implement the solution yourself
3. Use @reviewer to check your work
4. Use @tester to write and run tests
```

---

## 7. Skills

**Location**: `.github/skills/<name>/SKILL.md`  
**Purpose**: On-demand multi-step workflows with bundled scripts and references.

### Example: Deploy Skill

```
.github/skills/deploy/
├── SKILL.md
├── scripts/
│   └── deploy.sh
└── references/
    └── environments.md
```

**SKILL.md**:

```markdown
---
name: deploy
description: "Deploy the application to staging or production. Use when asked to deploy, release, or push to environments."
---

# Deployment Workflow

## Procedure
1. Run tests: `pnpm test`
2. Build: `pnpm build`
3. Check environment config in [environments reference](./references/environments.md)
4. Run [deploy script](./scripts/deploy.sh) with target environment
5. Verify deployment health check

## Environments
- `staging`: Auto-deploy from `develop` branch
- `production`: Manual deploy from `main` branch, requires approval
```

### Skills vs Prompts

| Feature | Prompt | Skill |
|---------|--------|-------|
| Slash command | Yes | Yes |
| Bundled scripts | No | Yes |
| Reference docs | No | Yes |
| Multi-step workflow | No | Yes |
| Parameterized input | Yes | Yes |

---

## 8. Hooks

**Location**: `.github/hooks/*.json`  
**Purpose**: Deterministic enforcement at agent lifecycle events.

### Available Events

| Event | When |
|-------|------|
| `SessionStart` | First prompt of session |
| `UserPromptSubmit` | User sends a message |
| `PreToolUse` | Before any tool runs |
| `PostToolUse` | After tool completes |
| `Stop` | Session ends |

### Example: Auto-Format After Edit

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "type": "command",
        "command": "pnpm prettier --write",
        "timeout": 10
      }
    ]
  }
}
```

### Example: Block Dangerous Commands

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "type": "command",
        "command": "./scripts/validate-command.sh",
        "timeout": 5
      }
    ]
  }
}
```

### Hooks vs Instructions

| Need | Use |
|------|-----|
| "Prefer functional components" | Instructions (guidance) |
| "Always run prettier after editing" | Hook (guaranteed) |
| "Never run `rm -rf /`" | Hook (enforcement) |

---

## 9. MCP Servers

**Location**: `.vscode/mcp.json`  
**Purpose**: Connect Copilot to external tools and APIs.

### Example Configuration

```jsonc
{
  "servers": {
    "github": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${input:github_token}"
      }
    },
    "postgres": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "${input:db_url}"
      }
    },
    "filesystem": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./docs"]
    }
  }
}
```

### Popular MCP Servers

| Server | Purpose |
|--------|---------|
| `server-github` | Issues, PRs, repos, code search |
| `server-postgres` | Query databases directly |
| `server-filesystem` | Extended file access |
| `server-brave-search` | Web search |
| `server-puppeteer` | Browser automation |
| `server-memory` | Persistent knowledge graph |
| `server-sequential-thinking` | Complex reasoning |

### Using MCP Tools in Agents

```yaml
---
description: "Database admin agent with direct DB access"
tools: [read, search, postgres/*]
---
```

---

## 10. Vibe Coding Workflow

### The Loop

```
1. DESCRIBE what you want in natural language
2. Let the agent BUILD it (Agent mode)
3. REVIEW the changes
4. ITERATE with follow-up instructions
5. COMMIT when satisfied
```

### Practical Session Example

```
You: "Create a user authentication feature with login, register,
      and password reset. Use React Query, Zustand for auth state,
      and the API client pattern from our shared folder."

Copilot: [reads copilot-instructions.md → understands stack]
         [reads react.instructions.md → follows component patterns]
         [reads api.instructions.md → uses shared API client]
         [creates feature folder, components, hooks, API calls, tests]

You: "The login form needs email validation and rate limiting"

Copilot: [builds on previous context, adds validation + rate limit]

You: "@reviewer check the auth feature for security issues"

Copilot: [reviewer agent analyzes without modifying]
         [reports: missing CSRF token, password stored in state]

You: "Fix those issues"

Copilot: [applies fixes based on reviewer feedback]
```

### Agent Mode vs Ask Mode vs Edit Mode

| Mode | Purpose | When to Use |
|------|---------|-------------|
| **Agent** | Autonomous coding — reads, writes, searches, runs commands | Building features, refactoring, debugging |
| **Ask** | Q&A and explanations — read-only | Understanding code, learning, design discussions |
| **Edit** | Inline edits with diff view | Quick targeted changes to specific files |

---

## 11. Team Collaboration — Agent Team

Your project now includes a full team of specialized agents that simulate a real development team. Here's who's on the team and how to make them work together.

### The Team

| Agent | Role | Tools | Read-Only? |
|-------|------|-------|------------|
| `@tech-lead` | **Orchestrator** — coordinates all agents through the full SDLC | all + agent delegation | No |
| `@product-owner` | Defines requirements, user stories, acceptance criteria, priorities | read, search, web | Yes |
| `@project-manager` | Task breakdown, sprint planning, effort estimation, progress tracking | read, search, todo | Yes |
| `@researcher` | Technology research, library comparison, AI tool discovery | read, search, web | Yes |
| `@recruiter` | Hires specialist developers, creates new agent files for specific tech | read, edit, search, web | No |
| `@architect` | System design, folder structure, dependency analysis | read, search, web | Yes |
| `@designer` | UI/UX decisions, accessibility audits, responsive design | read, search, web | Yes |
| `@instructions-engineer` | Creates tailored .instructions.md files for the chosen stack | read, edit, search, web | No |
| `@developer` | Frontend implementation — React, TypeScript, Tailwind | read, edit, search, execute | No |
| `@backend-developer` | API design, server-side logic, database operations | read, edit, search, execute | No |
| `@tester` | Test planning, test writing, QA verification | read, edit, search, execute | No |
| `@reviewer` | Code review, bug finding, quality audit | read, search | Yes |
| `@security` | Security audits, vulnerability assessment, OWASP analysis | read, search, web | Yes |
| `@devops` | CI/CD pipelines, Docker, deployment, infrastructure | read, edit, search, execute | No |
| `@tech-writer` | Documentation, READMEs, API docs, ADRs | read, search, edit | No |

### How to Use: Three Approaches

#### Approach 1: Tech Lead Orchestration (Recommended for Large Features)

Let the tech lead run the full process:

```
You: @tech-lead Build a user authentication system with login,
     register, password reset, and OAuth support.
```

The tech lead will:

1. Ask `@product-owner` to define user stories and acceptance criteria
2. Ask `@project-manager` to break tasks down and estimate
3. Ask `@researcher` to find the best technologies and libraries
4. Ask `@architect` to propose the technical approach (using research findings)
5. Ask `@designer` to plan the UI components
6. Delegate coding to `@developer` and `@backend-developer`
7. Get `@tester` to write tests
8. Get `@reviewer` and `@security` to audit
9. Ask `@tech-writer` to document

#### Approach 2: Direct Agent Selection (Best for Targeted Work)

Pick the right specialist for a focused task:

```
You: @product-owner Write user stories for a shopping cart feature

You: @architect Should we use a monorepo or separate repos for
     our microservices?

You: @designer Review this component for accessibility issues

You: @security Audit the authentication flow in src/features/auth/

You: @researcher What's the best state management library for
     React in 2026? Compare Zustand, Jotai, and Redux Toolkit.

You: @devops Set up a GitHub Actions CI pipeline for this project
```

#### Approach 3: Sequential Pipeline (Best for Medium Features)

Run agents in sequence yourself, carrying context forward:

```
Step 1:
You: @product-owner Define the user stories for a dark mode feature

Step 2 (after PO responds):
You: @project-manager Break these stories into tasks:
     [paste or reference PO output]

Step 3:
You: @developer Implement the dark mode toggle component.
     Here are the requirements: [paste task details]

Step 4:
You: @tester Write tests for the dark mode feature

Step 5:
You: @reviewer Review the dark mode implementation
```

### Real-World Team Workflow Example

Here's a complete session building a notification system:

```
━━━ PHASE 1: DEFINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You: @product-owner We need an in-app notification system.
     Users should see a bell icon with unread count,
     a dropdown with recent notifications, and the ability
     to mark as read. Define the user stories.

PO Response:
  → 4 user stories with acceptance criteria
  → MoSCoW prioritization
  → MVP scope defined

━━━ PHASE 2: PLAN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You: @project-manager Break down these user stories into
     development tasks with estimates and dependencies.

PM Response:
  → 8 tasks identified (TASK-001 through TASK-008)
  → T-shirt sizing: 2 S, 3 M, 2 L, 1 XL
  → Dependency graph showing build order
  → Assigned each task to an agent role

━━━ PHASE 3: DESIGN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You: @architect Design the notification system architecture.
     We need real-time updates, persistence, and the ability
     to support different notification types.

Architect Response:
  → Proposed WebSocket + REST hybrid
  → Data model for notifications
  → Folder structure under src/features/notifications/

You: @designer Design the notification bell and dropdown.
     It should match our existing Tailwind design system.

Designer Response:
  → Component hierarchy: NotificationBell → NotificationDropdown → NotificationItem
  → Responsive behavior
  → Accessibility: ARIA live region for new notifications
  → All interactive states defined

━━━ PHASE 4: BUILD ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You: @developer Build the notification components following
     the architecture and design specs above.

Developer Response:
  → Creates src/features/notifications/
  → Implements components, hooks, types
  → Verifies compilation

You: @backend-developer Build the notification API endpoints
     with WebSocket support.

Backend Response:
  → Creates API routes, WebSocket handlers
  → Implements data persistence layer

━━━ PHASE 5: VERIFY ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You: @tester Create a test plan and write tests for
     the notification feature.

Tester Response:
  → Test plan covering all acceptance criteria
  → Unit tests for hooks and utilities
  → Component tests for UI
  → All tests passing

You: @reviewer Review the entire notification feature.

Reviewer Response:
  → 2 warnings, 1 suggestion
  → No critical issues

You: @security Audit the notification feature for
     vulnerabilities.

Security Response:
  → WebSocket auth verified
  → No XSS in notification content rendering
  → Rate limiting recommended for API

━━━ PHASE 6: SHIP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You: @tech-writer Document the notification feature
     in the project README.

You: @devops Add the WebSocket service to our Docker
     Compose configuration.
```

### Tips for Effective Team Use

1. **Start with `@tech-lead` for big features** — it knows the workflow and delegates automatically
2. **Use read-only agents freely** — `@product-owner`, `@researcher`, `@architect`, `@designer`, `@reviewer`, `@security` can't break anything
3. **Chain context forward** — reference previous agent outputs when talking to the next agent
4. **Use `@project-manager` to track progress** — it manages the todo list for you
5. **Always end with `@reviewer` + `@security`** — quality gates before considering work done
6. **`@designer` before `@developer`** — design decisions first, implementation second
7. **Combine agents with prompts** — use `/create-component` with `@developer` for scaffolding

---

## 12. Autonomous SDLC — Building a Full App

This is the most powerful feature: a single command that runs your entire agent team through a complete software development lifecycle, autonomously.

### The `/build-app` Prompt

Type `/build-app` in chat and describe what you want to build. The tech lead takes over and runs 11 phases without stopping:

```
/build-app A task management app with user authentication,
          project boards, drag-and-drop task cards, real-time
          collaboration, and dark mode support.
```

### What Happens Automatically

```
┌─────────────────────────────────────────────────────────┐
│  PHASE 1: REQUIREMENTS          @product-owner          │
│  → User stories, acceptance criteria, MVP scope          │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 2: PLANNING              @project-manager         │
│  → Task breakdown, estimates, sprint plan, todo list     │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 2.5: RESEARCH            @researcher              │
│  → Tech stack research, library comparison, AI tools     │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 3: ARCHITECTURE          @architect               │
│  → System design, folder structure, data models, ADRs    │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 3.5: RECRUITMENT         @recruiter               │
│  → Hire specialist devs, create agent files for stack   │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 4: UI/UX DESIGN          @designer                │
│  → Component specs, design tokens, accessibility plan    │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 5: PROJECT SETUP         @dev + @devops + @instr  │
│  → Project init, Docker, CI, tailored instructions       │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 6: IMPLEMENTATION        @developer + @backend    │
│  → All features built, task list tracked                 │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 7: TESTING               @tester                  │
│  → Test plan, unit/component/integration tests           │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 8: CODE REVIEW           @reviewer                │
│  → Quality audit, fix loop if Critical issues found      │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 9: SECURITY AUDIT        @security                │
│  → OWASP scan, vulnerability fix loop if needed          │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 10: DOCUMENTATION        @tech-writer             │
│  → README, CONTRIBUTING, architecture docs               │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  PHASE 11: DEPLOYMENT PREP      @devops                  │
│  → Production Docker, CI verification, deploy docs       │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│  SHIP REPORT                    @tech-lead               │
│  → Summary, quality metrics, how to run, next steps      │
└─────────────────────────────────────────────────────────┘
```

### How Agents Communicate

Each agent follows a **handoff protocol** defined in `.github/instructions/agent-protocol.instructions.md`:

1. **Completes** their deliverables
2. **Documents** decisions and constraints discovered
3. **Hands off** to the next agent with explicit context
4. **Escalates** blockers to `@tech-lead` if stuck

The `@tech-lead` orchestrator:

- Passes ALL relevant context from previous phases to the next agent
- Validates **phase gates** before proceeding (e.g., won't start coding until architecture exists)
- Runs **fix loops**: if `@reviewer` finds Critical bugs, sends `@developer` back to fix, then re-reviews
- Tracks progress in the **todo list** visible to you in real-time

### Phase Gates (Quality Enforcement)

The pipeline will NOT proceed past a gate until criteria are met:

| Phase | Gate Criteria |
|-------|---------------|
| Requirements | User stories + acceptance criteria exist |
| Planning | Tasks broken down, estimated, assigned |
| Research | Tech stack researched, alternatives compared, recommendations made |
| Architecture | System design + folder structure + data models documented |
| Design | Component specs + accessibility plan exist |
| Setup | `pnpm dev` runs successfully |
| Implementation | All MVP tasks done, `pnpm build` succeeds |
| Testing | All acceptance criteria have tests, `pnpm test` passes |
| Review | No Critical issues open |
| Security | No Critical/High vulnerabilities open |
| Documentation | README + architecture docs exist |
| Deployment | Docker config + CI pipeline defined |

### Fix Loops

When a gatekeeper agent (reviewer, security, tester) finds blocking issues:

```
@reviewer finds Critical bug in auth flow
    ↓
@tech-lead routes fix request to @developer with exact details
    ↓
@developer fixes the code
    ↓
@tech-lead sends back to @reviewer for re-review
    ↓
@reviewer confirms fix → PASS → proceed to @security
```

### Example: Building an Enterprise App

```
You: /build-app An enterprise project management platform with:
     - User authentication (email + OAuth)
     - Team workspaces with role-based access
     - Kanban boards with drag-and-drop
     - Real-time updates via WebSocket
     - Activity feed and notifications
     - Dark mode and responsive design
     - Export to CSV/PDF
```

Then sit back. The team will:

1. Define 15-20 user stories with acceptance criteria
2. Break into 30-40 tasks across 3 sprints
3. Design the full architecture with data models
4. Create component specs for every UI element
5. Set up the project with all tooling
6. Implement every feature with proper types and error handling
7. Write 50+ tests covering all acceptance criteria
8. Review every file for bugs and quality
9. Audit for OWASP Top 10 vulnerabilities
10. Generate README, architecture docs, and contributing guide
11. Prepare Docker and CI/CD configuration
12. Deliver a ship report with quality metrics

### Tips for Best Results

1. **Be specific in your description** — the more detail you give, the better the user stories
2. **Let it run** — don't interrupt between phases unless asked
3. **Review the ship report** — it tells you exactly what was built and what's deferred
4. **Iterate with individual agents** — after the full build, use `@developer` or `@tester` directly for tweaks
5. **The todo list is your dashboard** — watch task progress in real-time
6. **For smaller features** — use `@tech-lead` directly instead of `/build-app`

### Other Autonomous Prompts

| Prompt | What It Does |
|--------|--------------|
| `/build-app` | Full SDLC from scratch |
| `/create-component` | Scaffold a single component with tests |
| `/write-tests` | Generate tests for existing code |

---

## 13. Power Features & Integrations

### 1. GitHub Copilot Code Review (PR Agent)

Request AI reviews on pull requests directly from GitHub:

- Go to any PR → click "Copilot" in the reviewer dropdown
- Gets automated review comments with suggested fixes
- Works with your workspace instructions for project-aware reviews

### 2. Copilot in the Terminal

- Type a command description in natural language in the terminal
- `Ctrl+I` in the integrated terminal → describe what you want
- Copilot suggests the exact command

### 3. Copilot for Commit Messages

- Stage changes → go to Source Control → click the sparkle icon
- Copilot generates contextual commit messages from your diffs

### 4. Copilot Inline Chat

- Select code → `Ctrl+I` → describe the change
- See diff preview before accepting
- Great for quick refactors without opening the chat panel

### 5. Copilot in the Debug Console

- While debugging, ask Copilot about variable states
- Get fix suggestions for runtime errors

### 6. Copilot for Documentation

- Select code → ask "explain this" or "document this"
- Generate JSDoc, README sections, ADRs

### 7. Vision (Image Understanding)

- Drag images into chat (mockups, screenshots, diagrams)
- Copilot generates code matching the visual design
- Great for UI implementation from Figma screenshots

### 8. Multi-File Editing

- In Agent mode, Copilot can edit multiple files simultaneously
- Ask for cross-cutting changes: "Add error logging to all API handlers"

### 9. `@workspace` and Context Variables

| Variable | Purpose |
|----------|---------|
| `@workspace` | Search entire codebase for context |
| `#file` | Attach specific file to context |
| `#selection` | Include selected code |
| `#editor` | Include visible editor content |
| `#terminalLastCommand` | Include last terminal output |
| `#terminalSelection` | Include selected terminal text |
| `#problems` | Include VS Code Problems panel |
| `#codebase` | Deep codebase search |

### 10. Copilot Chat Participants

| Participant | Purpose |
|-------------|---------|
| `@workspace` | Workspace-aware questions |
| `@terminal` | Terminal command help |
| `@vscode` | VS Code settings and features |
| `@github` | GitHub-specific operations (with MCP) |

---

## 14. Recommended Extensions & Integrations

### Extensions That Supercharge Vibe Coding

| Extension | Why |
|-----------|-----|
| **GitHub Copilot** | Core AI pair programmer |
| **GitHub Copilot Chat** | Conversational AI with Agent mode |
| **Error Lens** | Inline error display — Copilot can see these via `#problems` |
| **GitLens** | Rich Git history — helps Copilot understand code evolution |
| **Todo Tree** | Track TODOs that Copilot can help resolve |
| **Playwright Test** | Browser testing that integrates with Copilot's execute tools |
| **REST Client** | Test APIs inline — share results with Copilot via context |
| **Dev Containers** | Reproducible environments for consistent vibe coding |
| **Docker** | Container management accessible through MCP |
| **ESLint / Prettier** | Auto-formatting that hooks can enforce |

### MCP Integrations Worth Setting Up

| Integration | Value |
|-------------|-------|
| **GitHub MCP** | Manage issues, PRs, and code search from chat |
| **Database MCP** | Query and understand your data schema |
| **Brave Search MCP** | Research docs, libraries, and solutions |
| **Playwright MCP** | Test web apps visually from chat |
| **Memory MCP** | Persistent knowledge across sessions |

---

## 15. Tips for Maximum Efficiency

### Do's

1. **Start with workspace instructions** — even a 10-line file dramatically improves output quality
2. **Use Agent mode by default** — it's the full vibe coding experience
3. **Create prompts for repeated tasks** — component scaffolding, test writing, reviews
4. **Use images** — drag mockups into chat for UI generation
5. **Build a library of instructions** — they compound over time
6. **Use `#file` and `#selection`** — precise context = better results
7. **Chain agents** — let specialist agents handle their domain
8. **Trust but verify** — review agent output, especially for security-sensitive code
9. **Use hooks for enforcement** — don't rely on instructions for critical rules
10. **Iterate in small steps** — better results than one massive prompt

### Don'ts

1. **Don't write novels in instructions** — concise > verbose
2. **Don't use `applyTo: "**"` everywhere** — it burns your context window
3. **Don't skip workspace instructions** — they're the highest-ROI customization
4. **Don't fight the agent** — if it keeps going a different direction, clarify your instructions
5. **Don't forget to test** — vibe coding still needs verification

### The Vibe Coding Maturity Model

```
Level 0: Using autocomplete only
Level 1: Using Copilot Chat for Q&A
Level 2: Using Agent mode for feature building
Level 3: Custom instructions + prompts for your project
Level 4: Custom agents + skills + hooks for team workflows
Level 5: Full MCP integration + orchestrated multi-agent pipelines
```

---

## Quick Start Checklist

- [ ] Create `.github/copilot-instructions.md` with your project standards
- [ ] Create 2-3 `.instructions.md` files for your main tech stack
- [ ] Create 1-2 `.prompt.md` files for tasks you repeat daily
- [ ] Set up at least one custom agent (reviewer is a great first one)
- [ ] Configure GitHub MCP server for issue/PR management
- [ ] Enable Agent mode as default in settings
- [ ] Try dragging a mockup image into chat
- [ ] Use `Ctrl+I` in the terminal for command generation

---

*Generated for the VibeCoding workspace. Start with the Quick Start Checklist and build up from there.*
