---
description: "Initialize a new project from this template. Customizes copilot-instructions.md, instructions, and prompts for your specific tech stack and conventions."
agent: "agent"
tools: [read, edit, search, execute]
---

# Initialize Project from Vibe Coding Template

Set up this project for a new application. Update all template files to match the project's specific needs.

## Project details: {{input}}

## CRITICAL: Protected Template Files

Do NOT delete, remove, or replace any of these template files. You may EDIT them to customize for the new stack, but they must continue to exist:
- `.github/copilot-instructions.md`
- `.github/instructions/*.instructions.md` (all instruction files)
- `.github/prompts/*.prompt.md` (all prompt files)
- `.github/agents/*.agent.md` (all agent files)
- `.vscode/mcp.json`
- `TUTORIAL.md`

If a file is not relevant to the new stack (e.g., component instructions for a CLI tool), update its content to match the new stack rather than deleting it.

## Steps

1. **Update `.github/copilot-instructions.md`**:
   - Replace the `<!-- UPDATE -->` sections with the project's actual stack, code style, architecture, and build commands
   - Remove the `<!-- UPDATE -->` comment markers

2. **Update `.github/instructions/component.instructions.md`**:
   - Adjust component/UI patterns to match the project's actual framework
   - If the project has no UI (CLI, API-only), repurpose for the primary code pattern

3. **Update `.github/instructions/testing.instructions.md`**:
   - Adjust to match the project's actual test framework (Vitest, Jest, Playwright, etc.)

4. **Update `.github/prompts/create-component.prompt.md`**:
   - Adjust component scaffolding to match the project's framework and folder structure

5. **Update `.github/prompts/build-app.prompt.md`**:
   - Adjust project init command (e.g., `pnpm create vite@latest` vs `npx create-next-app`)
   - Adjust build/test commands to match the stack

6. **Update agent tool constraints if needed**:
   - Backend agents only needed if project has a backend
   - Designer agent only needed for UI projects

7. **Create the project's `README.md`** with:
   - Project name and description
   - Quick start instructions
   - Link to TUTORIAL.md for Copilot usage

8. **Initialize the project** if not already done:
   - Run the appropriate scaffolding command
   - Install dependencies
   - Verify `dev` and `build` commands work

Confirm each change with the user before proceeding.
