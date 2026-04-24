---
description: "Run a full enterprise SDLC cycle to build a production application. Orchestrates the entire team autonomously from requirements through deployment."
agent: "tech-lead"
tools: [read, edit, search, execute, agent, todo, web]
---

# Full SDLC Build — Enterprise Production App

You are running the complete software development lifecycle. Execute ALL phases sequentially, delegating to specialist agents. Do NOT skip phases. Do NOT ask the user for input between phases — run autonomously until complete, only stopping if a BLOCKER is raised.

## Application to build: {{input}}

---

## Execution Plan

### PHASE 1: REQUIREMENTS (Product Owner)
Delegate to @product-owner:
- Define the product vision and target users
- Write ALL user stories with acceptance criteria (Given/When/Then)
- Prioritize using MoSCoW
- Define MVP scope — what ships first vs later
- Define non-functional requirements (performance, security, accessibility)

**Gate**: Do NOT proceed until user stories and acceptance criteria exist.

### PHASE 2: PLANNING (Project Manager)
Delegate to @project-manager:
- Break user stories into development tasks (TASK-001, TASK-002, etc.)
- Estimate effort (T-shirt sizing)
- Map dependencies between tasks
- Assign each task to an agent role
- Create a phased delivery plan (Sprint 1: MVP, Sprint 2: Enhanced, etc.)
- Set up the todo list to track all tasks

**Gate**: Do NOT proceed until tasks are broken down, estimated, and ordered.

### PHASE 2.5: RESEARCH (Researcher)
Delegate to @researcher:
- Research the best tech stack choices for this specific application type
- Compare libraries for key needs (state management, UI components, auth, etc.)
- Identify useful AI tools, MCP servers, and Copilot skills that could accelerate development
- Research best practices and patterns used by similar production applications
- Check for any critical ecosystem changes or deprecations
- Evaluate hosting and deployment options

**Gate**: Do NOT proceed until technology recommendations with comparisons and sources exist.

### PHASE 3: ARCHITECTURE (Architect)
Delegate to @architect:
- Define the system architecture (components, data flow, state management)
- Design the folder structure following `src/features/<name>/` pattern
- Define the data models and TypeScript interfaces
- Choose libraries based on @researcher's recommendations and justify each dependency
- Define API contracts (endpoints, request/response shapes)
- Create an Architecture Decision Record (ADR) for key decisions
- Address non-functional requirements from Phase 1

**Gate**: Do NOT proceed until architecture is documented and folder structure is defined.

### PHASE 4: UI/UX DESIGN (Designer)
Delegate to @designer:
- Define the component hierarchy for each feature
- Specify Tailwind CSS design tokens (colors, spacing, typography)
- Plan responsive breakpoints and mobile behavior
- Define all component states (default, loading, error, empty, success)
- Create an accessibility plan (ARIA, keyboard nav, screen readers)
- Map user flows through the application

**Gate**: Do NOT proceed until component specs and accessibility plan exist.

### PHASE 5: PROJECT SETUP (Developer + DevOps)
Delegate to @developer:
- Initialize the project: `pnpm create vite@latest` with React + TypeScript
- Install dependencies defined by architect
- Set up folder structure from architecture plan
- Configure Tailwind CSS, ESLint, Prettier
- Create shared types, constants, and utility foundations
- Set up routing structure

Then delegate to @devops:
- Create `Dockerfile` and `docker-compose.yml`
- Set up GitHub Actions CI pipeline (lint, test, build)
- Configure environment variable handling

**Gate**: Do NOT proceed until `pnpm dev` runs successfully and CI pipeline is defined.

### PHASE 6: IMPLEMENTATION — CORE (Developer + Backend Developer)
Work through the task list from Phase 2, in dependency order.

Delegate to @developer for each frontend task:
- Implement components following designer's specs
- Use the architecture patterns defined in Phase 3
- Write hooks, utilities, and state management
- Ensure TypeScript strict mode compliance
- Follow all project conventions from copilot-instructions.md

Delegate to @backend-developer for each backend task:
- Implement API endpoints with proper validation
- Set up data persistence layer
- Implement authentication/authorization if required
- Add request logging and error handling

After EACH feature is implemented, mark the task complete in the todo list.

**Gate**: Do NOT proceed until all MVP tasks are implemented and `pnpm build` succeeds.

### PHASE 7: TESTING (Tester)
Delegate to @tester:
- Create a master test plan covering all acceptance criteria from Phase 1
- Write unit tests for all utilities and hooks
- Write component tests for all UI components using React Testing Library
- Write integration tests for API endpoints
- Write E2E test scenarios (even if not automated yet)
- Run `pnpm test` and ensure ALL tests pass
- Report coverage metrics and gaps

**Gate**: Do NOT proceed until all acceptance criteria have corresponding tests and tests pass.

### PHASE 8: CODE REVIEW (Reviewer)
Delegate to @reviewer:
- Review ALL implementation files for:
  - Logic errors and edge cases
  - TypeScript type safety (no `any` leaks)
  - React performance (unnecessary re-renders, missing deps)
  - Error handling completeness
  - Code duplication and refactoring opportunities
  - Naming conventions and readability
- Produce a review report with severity ratings

If Critical issues found → delegate fixes to @developer → re-review.

**Gate**: Do NOT proceed if Critical issues remain unresolved.

### PHASE 9: SECURITY AUDIT (Security)
Delegate to @security:
- Full OWASP Top 10 audit
- Authentication/authorization flow review
- Input validation and sanitization check
- Dependency vulnerability scan (check package.json)
- Secrets management audit
- XSS, CSRF, injection prevention verification
- Produce a security report with remediation steps

If Critical/High vulnerabilities found → delegate fixes to @developer → re-audit.

**Gate**: Do NOT proceed if Critical or High vulnerabilities remain.

### PHASE 10: DOCUMENTATION (Tech Writer)
Delegate to @tech-writer:
- Write/update `README.md` with:
  - Project overview and features
  - Tech stack and architecture overview
  - Setup and installation instructions
  - Environment variables reference
  - Development workflow
  - Deployment instructions
- Create `CONTRIBUTING.md` with coding standards
- Create `docs/architecture.md` with system design details
- Document API endpoints (if applicable)

### PHASE 11: DEPLOYMENT PREP (DevOps)
Delegate to @devops:
- Finalize Docker configuration
- Verify CI pipeline runs green
- Create production build configuration
- Document deployment process
- Set up health check endpoint

### FINAL: SHIP REPORT
After all phases complete, produce a final report:

```
━━━ SHIP REPORT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Application Summary
[What was built, key features]

## Architecture
[Tech stack, major patterns, folder structure]

## Quality Metrics
- Tests: [count] tests, [pass/fail]
- Review: [critical/warning/info counts]
- Security: [critical/high/medium/low counts]
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
