# Vibe Coding Template

A GitHub template repository with a full AI-powered development team for GitHub Copilot Agent mode.

## What's Included

### 16 Custom Agents (`.github/agents/`)

A complete development team that works autonomously:

| Agent | Role |
| ------- | ------ |
| `@tech-lead` | Orchestrates all agents through the full SDLC |
| `@product-owner` | User stories, acceptance criteria, prioritization |
| `@project-manager` | Task breakdown, sprint planning, progress tracking |
| `@researcher` | Technology research, library comparison, AI tool discovery |
| `@recruiter` | Hires specialist developers, creates new agent files dynamically |
| `@architect` | System design, folder structure, data models |
| `@designer` | UI/UX, accessibility, responsive design |
| `@instructions-engineer` | Creates tailored Copilot instructions for any stack |
| `@skills-scout` | Discovers and installs Copilot skills for your tech stack |
| `@developer` | Frontend implementation |
| `@backend-developer` | APIs, server logic, databases |
| `@tester` | Test planning, test writing, QA |
| `@reviewer` | Code review, quality audit |
| `@security` | OWASP audits, vulnerability scanning |
| `@devops` | CI/CD, Docker, deployment |
| `@tech-writer` | Documentation, READMEs, ADRs |

### Reusable Prompts (`.github/prompts/`)

| Prompt | What It Does |
| -------- | ------------- |
| `/build-app` | Run the full SDLC autonomously — 14 phases, 16 agents |
| `/add-feature` | Add a feature to an existing app (plan → build → test → review) |
| `/fix-bug` | Diagnose and fix a bug with regression test |
| `/init-project` | Customize this template for your specific stack |
| `/create-component` | Scaffold a component with types and tests |
| `/write-tests` | Generate tests for existing code |

### Instructions (`.github/instructions/`)

- **Vibe coding** — Core workflow and agent collaboration patterns
- **Code quality** — Naming, error handling, security, maintainability
- **Component** — UI component patterns (customize for your framework)
- **Testing** — Testing patterns (customize for your test framework)
- **Agent protocol** — Inter-agent communication standard

### MCP Servers (`.vscode/mcp.json`)

| Server | Purpose | Used By |
|--------|---------|---------|
| **GitHub** | Issues, PRs, branches, code search | @devops, @tech-lead |
| **Playwright** | Browser automation, E2E testing, visual validation | @tester, @designer |
| **Fetch** | HTTP requests, API docs, package research | @researcher, @security |
| **Memory** | Persistent knowledge graph across sessions | @tech-lead |
| **Filesystem** | Read/write files outside workspace | @devops |

## Quick Start

### 1. Create a new repo from this template

Click **"Use this template"** on GitHub, or clone and reinitialize:

```bash
# Option A: GitHub template (recommended)
# Click "Use this template" → "Create a new repository" on GitHub

# Option B: Manual clone
git clone https://github.com/YOUR_USERNAME/VibeCoding.git my-new-project
cd my-new-project
rm -rf .git              # bash/macOS/Linux
# Remove-Item -Recurse -Force .git   # PowerShell (Windows)
git init
git add .
git commit -m "Initial commit from Vibe Coding template"
```

### 2. Open in VS Code and initialize

```text
/init-project A SaaS dashboard built with Next.js, Prisma, and PostgreSQL
```

This customizes all template files for your specific stack.

### 3. Build your app

```text
/build-app [describe your application in detail]
```

The full team runs autonomously: requirements → planning → research → architecture → recruitment → design → skills discovery → setup + instructions → implementation → testing → review → security → docs → deployment.

### 4. Iterate with individual agents

```text
@developer Add a dark mode toggle to the settings page
@tester Write tests for the new auth flow
@reviewer Check the API routes for issues
@security Audit the payment processing feature
```

## Customizing the Template

### For a different tech stack

Edit `.github/copilot-instructions.md` — the `<!-- UPDATE -->` sections mark what to change.

### For a different project structure

Edit `.github/instructions/component.instructions.md` or create new instruction files for your framework.

### For additional prompts

Add `.prompt.md` files to `.github/prompts/` — they appear as `/` commands in chat.

### For additional agents

Add `.agent.md` files to `.github/agents/` and reference them in `tech-lead.agent.md`.

## Tutorial

See [TUTORIAL.md](TUTORIAL.md) for the complete guide covering all Copilot customization features.

## License

MIT
