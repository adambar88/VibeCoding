---
description: "Initialize a new project from this template. Customizes copilot-instructions.md, instructions, and prompts for your specific tech stack and conventions."
agent: "agent"
tools: [read, edit, search, execute]
---

# Initialize Project from Vibe Coding Template

Set up this project for a new application. Update all template files to match the project's specific needs.

## Project details: {{input}}

## Steps

1. **Update `.github/copilot-instructions.md`**:
   - Replace the `<!-- UPDATE -->` sections with the project's actual stack, code style, architecture, and build commands
   - Remove the `<!-- UPDATE -->` comment markers

2. **Update `.github/instructions/react.instructions.md`**:
   - If NOT using React, rename or replace with instructions for the actual UI framework
   - If using React, adjust patterns to match the project's React version and conventions

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
