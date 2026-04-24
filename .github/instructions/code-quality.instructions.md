---
applyTo: "**/*.{ts,tsx,js,jsx,py,go,rs,java,cs}"
description: "Code quality standards applied to all source code. Covers naming, error handling, security basics, and maintainability. UPDATE framework-specific details via /init-project."
---

# Code Quality Standards

## Naming
- Use descriptive, intention-revealing names — avoid abbreviations
- Functions: verb + noun (`getUserById`, `validateEmail`, `calculateTotal`)
- Booleans: prefix with `is`, `has`, `should`, `can` (`isLoading`, `hasPermission`)
- Constants: UPPER_SNAKE_CASE for true constants, camelCase for derived values
- Files: match the primary export name

## Error Handling
- Handle errors at system boundaries (API calls, user input, file I/O)
- Use typed errors or error codes — avoid bare `throw new Error('something')`
- Never swallow errors silently — log or propagate
- Provide user-friendly error messages for UI, detailed messages for logs
- Validate external input early, fail fast on invalid data

## Security Basics
- Never hardcode secrets, tokens, or credentials — use environment variables
- Validate and sanitize all user input before processing
- Use parameterized queries for database operations — never string concatenation
- Apply the principle of least privilege for API permissions
- Escape output in templates to prevent XSS

## Maintainability
- Keep functions short — if it needs a comment to explain WHAT it does, split it
- Prefer pure functions where possible — same input, same output, no side effects
- Avoid deep nesting — use early returns and guard clauses
- Don't repeat yourself, but don't over-abstract either — duplicate is better than wrong abstraction
- Delete dead code — version control is your backup

## Dependencies
- Justify every dependency — is the utility worth the bundle/maintenance cost?
- Pin versions in lockfiles
- Prefer well-maintained packages with active communities
- Audit dependencies periodically for vulnerabilities
