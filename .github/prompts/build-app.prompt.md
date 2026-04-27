---
description: "Run a full enterprise SDLC cycle to build a production application. Orchestrates the entire team autonomously from requirements through deployment."
agent: "tech-lead"
tools: [read, edit, search, execute, agent, todo, web]
---

# Full SDLC Build — Enterprise Production App

You are running the complete software development lifecycle. Execute ALL phases sequentially, delegating to specialist agents. Do NOT ask the user for input between phases — run autonomously until complete.

## CRITICAL RULES — READ BEFORE STARTING

1. **NEVER skip phases** — Every phase must execute. If not applicable, still run the agent and save "Evaluated — not needed" to the deliverable file.
2. **Save all deliverables as markdown** — Every phase produces a file in `docs/phases/`. Create this directory first. Agent outputs must NOT exist only in chat.
3. **Setup ≠ Implementation** — Phase 5 (Setup) creates the project skeleton with ZERO feature code. Phase 6 (Implementation) writes ALL feature code. Never combine them.
4. **Fix loops must actually loop** — When @reviewer or @security finds Critical issues, delegate fixes to @developer, then send BACK to the auditor for re-review. Repeat up to 3 times.
5. **Review and Security are SEPARATE phases** — Never combine them.

## Application to build: {{input}}

---

## Step 0: Initialize

Create the `docs/phases/` directory.

## Execution Plan

### PHASE 1: REQUIREMENTS (Product Owner)
Delegate to @product-owner:
- Define the product vision and target users
- Write ALL user stories with acceptance criteria (Given/When/Then)
- Prioritize using MoSCoW
- Define MVP scope — what ships first vs later
- Define non-functional requirements (performance, security, accessibility)

**Save output → `docs/phases/01-requirements.md`**

**Gate**: File exists with user stories and acceptance criteria.

### PHASE 2: PLANNING (Project Manager)
Delegate to @project-manager:
- Break user stories into development tasks (TASK-001, TASK-002, etc.)
- Estimate effort (T-shirt sizing)
- Map dependencies between tasks
- Assign each task to an agent role
- Create a phased delivery plan (Sprint 1: MVP, Sprint 2: Enhanced, etc.)
- Set up the todo list to track all tasks

**Save output → `docs/phases/02-planning.md`**

**Gate**: File exists with tasks broken down, estimated, and ordered.

### PHASE 2.5: RESEARCH (Researcher)
Delegate to @researcher:
- Research the best tech stack choices for this specific application type
- Compare libraries for key needs (state management, UI components, auth, etc.)
- Identify useful AI tools, MCP servers, and Copilot skills that could accelerate development
- Research best practices and patterns used by similar production applications
- Check for any critical ecosystem changes or deprecations
- Evaluate hosting and deployment options

**Save output → `docs/phases/03-research.md`**

**Gate**: File exists with technology recommendations, comparisons, and sources.

### PHASE 3: ARCHITECTURE (Architect)
Delegate to @architect:
- Define the system architecture (components, data flow, state management)
- Design the folder structure
- Define the data models and interfaces/types
- Choose libraries based on @researcher's recommendations and justify each dependency
- Define API contracts (endpoints, request/response shapes)
- Create an Architecture Decision Record (ADR) for key decisions
- Address non-functional requirements from Phase 1

**Save output → `docs/phases/04-architecture.md`**

**Gate**: File exists with architecture documented and folder structure defined.

### PHASE 3.5: RECRUITMENT (Recruiter)
Delegate to @recruiter:
- Review the architecture decisions and tech stack from Phase 3
- Identify technologies that need specialist expertise beyond @developer/@backend-developer
- For each specialist needed: create a new `.agent.md` file with expert-level instructions
- If no specialists needed, document why the existing team is sufficient

**Save output → `docs/phases/05-recruitment.md`** (even if "none needed")

**Gate**: File exists. Specialists recruited OR documented as not needed.

### PHASE 4: UI/UX DESIGN (Designer)
Delegate to @designer:
- Define the component hierarchy for each feature
- Specify design tokens (colors, spacing, typography)
- Plan responsive breakpoints and mobile behavior
- Define all component states (default, loading, error, empty, success)
- Create an accessibility plan (ARIA, keyboard nav, screen readers)
- Map user flows through the application

**Save output → `docs/phases/06-design.md`**

**Gate**: File exists with component specs and accessibility plan.

### PHASE 4.5: SKILLS DISCOVERY (Skills Scout)
Delegate to @skills-scout:
- Analyze the full tech stack from architecture decisions
- Search skills.sh, anthropics/skills repo, and GitHub for relevant Copilot skills
- Check user-level skills (~/.agents/skills/) to avoid duplicates
- Install high-quality skills into `.github/skills/`
- Report which skills were installed, already existed, or were unavailable

**Save output → `docs/phases/07-skills.md`**

**Gate**: File exists with skills installed or confirmed unavailable.

### PHASE 5: PROJECT SETUP — SCAFFOLDING ONLY (Developer + DevOps + Instructions Engineer)

⚠️ **This phase creates the project skeleton. Do NOT write any feature code, components, API routes, or business logic. That happens in Phase 6.**

Delegate to @developer:
- Initialize the project using the stack from Phase 3 (e.g., `create-expo-app`, `create-vite`, `create-next-app`)
- Install dependencies defined by architect
- Set up folder structure from architecture plan (empty directories)
- Configure linting, formatting, styling tools
- Create shared types/constants foundations ONLY (no feature code)
- Set up routing structure (placeholder content only)

Then delegate to @devops:
- Create `Dockerfile` and `docker-compose.yml`
- Set up CI pipeline (lint, test, build)
- Configure environment variable handling

Then delegate to @instructions-engineer:
- Create tailored `.instructions.md` files for every layer of the chosen stack
- Update `copilot-instructions.md` to match the actual project stack
- Ensure all instruction files have proper `applyTo` patterns

**Save output → `docs/phases/08-setup.md`** (list config files created, deps installed)

**Gate**: Project skeleton runs (`dev` command succeeds). NO feature code exists.

### PHASE 6: IMPLEMENTATION — ALL FEATURE CODE (Developer + Backend Developer)
Work through the task list from `docs/phases/02-planning.md`, in dependency order.

Delegate to @developer for each frontend task:
- Implement components following designer's specs from `docs/phases/06-design.md`
- Use architecture patterns from `docs/phases/04-architecture.md`
- Write hooks, utilities, and state management
- Ensure strict type compliance

Delegate to @backend-developer for each backend task:
- Implement API endpoints with proper validation
- Set up data persistence layer
- Implement authentication/authorization if required
- Add request logging and error handling

Delegate specialist tasks to any recruited agents from Phase 3.5.

After EACH feature: mark the task complete in the todo list.

**Save output → `docs/phases/09-implementation.md`** (features built, files created, tasks completed)

**Gate**: All MVP tasks done, build succeeds.

### PHASE 7: TESTING (Tester)
Delegate to @tester:
- Create a master test plan covering all acceptance criteria from `docs/phases/01-requirements.md`
- Write unit tests for all utilities and business logic
- Write component tests for all UI components
- Write integration tests for API endpoints
- Write E2E test scenarios (even if not automated yet)
- Run tests and ensure ALL pass
- Report coverage metrics and gaps

**Save output → `docs/phases/10-testing.md`** (test plan, coverage, pass/fail)

**Gate**: All acceptance criteria have corresponding tests and tests pass.

### PHASE 8: CODE REVIEW (Reviewer) — WITH FIX LOOP
Delegate to @reviewer:
- Review ALL implementation files for:
  - Logic errors and edge cases
  - Type safety (no `any` leaks)
  - Performance issues
  - Error handling completeness
  - Code duplication
  - Naming conventions and readability
- Produce a review report with severity ratings (Critical/Warning/Info)

**Save initial report → `docs/phases/11-review.md`**

**FIX LOOP** (if Critical issues found):

```text
Iteration 1:
  1. Extract Critical issues with exact file paths and line numbers
  2. Delegate to @developer: "Fix these Critical issues: [exact list]"
  3. After fixes, delegate to @reviewer: "Re-review. Previous issues: [list]"
  4. Append results to docs/phases/11-review.md

Iteration 2 (if still Critical): Repeat steps 1-4
Iteration 3 (if still Critical): Escalate to user
```

**Gate**: No Critical issues remain.

### PHASE 9: SECURITY AUDIT (Security) — WITH FIX LOOP
Delegate to @security:
- Full OWASP Top 10 audit
- Authentication/authorization flow review
- Input validation and sanitization check
- Dependency vulnerability scan
- Secrets management audit
- XSS, CSRF, injection prevention verification
- Produce a security report with remediation steps

**Save initial report → `docs/phases/12-security.md`**

**FIX LOOP** (if Critical/High vulnerabilities found):

```text
Iteration 1:
  1. Extract Critical/High issues with file paths and remediation steps
  2. Delegate to @developer: "Fix these vulnerabilities: [exact list]"
  3. After fixes, delegate to @security: "Re-audit. Previous issues: [list]"
  4. Append results to docs/phases/12-security.md

Iteration 2 (if still Critical/High): Repeat steps 1-4
Iteration 3 (if still Critical/High): Escalate to user
```

**Gate**: No Critical or High vulnerabilities remain.

### PHASE 10: DOCUMENTATION (Tech Writer)
Delegate to @tech-writer:
- Write/update `README.md` with project overview, setup, dev workflow, deployment
- Create `CONTRIBUTING.md` with coding standards
- Create `docs/architecture.md` with system design details
- Document API endpoints (if applicable)

**Save output → `docs/phases/13-documentation.md`** (list of docs created)

### PHASE 11: DEPLOYMENT PREP (DevOps)
Delegate to @devops:
- Finalize Docker configuration
- Verify CI pipeline runs green
- Create production build configuration
- Document deployment process
- Set up health check endpoint

**Save output → `docs/phases/14-deployment.md`**

### FINAL: SHIP REPORT
After all phases complete, produce a final report:

```text
━━━ SHIP REPORT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Application Summary
[What was built, key features]

## Architecture
[Tech stack, major patterns, folder structure]

## Phase Deliverables (docs/phases/)
- 01-requirements.md — [summary]
- 02-planning.md — [summary]
- 03-research.md — [summary]
- 04-architecture.md — [summary]
- 05-recruitment.md — [summary]
- 06-design.md — [summary]
- 07-skills.md — [summary]
- 08-setup.md — [summary]
- 09-implementation.md — [summary]
- 10-testing.md — [summary]
- 11-review.md — [summary + fix iterations: N]
- 12-security.md — [summary + fix iterations: N]
- 13-documentation.md — [summary]
- 14-deployment.md — [summary]

## Quality Metrics
- Tests: [count] tests, [pass/fail]
- Review: [critical/warning/info], fix loop iterations: [N]
- Security: [critical/high/medium/low], fix loop iterations: [N]
- Build: [pass/fail]

## Files Created
[List all files organized by feature]

## How to Run
[Commands to install, dev, test, build, deploy]

## Known Limitations
[What was deferred, known issues]

## Next Steps
[Recommended improvements for Sprint 2]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
