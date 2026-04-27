---
description: "Add a new feature to an existing application. Handles planning, implementation, testing, and review."
agent: "tech-lead"
tools: [read, edit, search, execute, web]
---

# Add Feature

Add the following feature to the existing application: {{input}}

## Process

1. **Understand**: Read copilot-instructions.md and the existing codebase to understand conventions, architecture, and patterns
2. **Plan**: Break the feature into tasks with clear acceptance criteria
3. **Architect**: Determine what files need to be created/modified, any new dependencies, and data model changes
4. **Implement**: Use @developer (and @backend-developer if backend changes needed) to build the feature following existing patterns
5. **Test**: Use @tester to write tests covering all acceptance criteria
6. **Review**: Use @reviewer to check code quality, then fix any issues
7. **Security**: Use @security if the feature involves auth, user data, or external APIs

## Rules

- Follow existing code patterns — do NOT introduce new architectural patterns without justification
- Do NOT refactor unrelated code
- Verify the full app still builds and all tests pass after implementation
- Save a brief summary of changes to `docs/features/<feature-name>.md`
