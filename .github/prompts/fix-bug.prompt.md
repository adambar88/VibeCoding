---
description: "Diagnose and fix a bug. Tech-lead orchestrates the right agents for root cause analysis, fix, regression test, review, and deployment."
agent: "tech-lead"
tools: [read, edit, search, execute, web]
---

# Fix Bug

Bug report: {{input}}

## Process

1. **Triage**: Read copilot-instructions.md and understand the codebase. Determine which area is affected and which agent(s) should own the fix
2. **Diagnose**: Delegate to @developer (or @backend-developer for server-side issues) to reproduce and identify root cause. Trace data/control flow to understand WHY, not just WHERE
3. **Fix**: The assigned developer implements the minimal fix that addresses the root cause — no refactoring of surrounding code
4. **Regression Test**: Delegate to @tester to write a test that fails without the fix and passes with it. Run the full test suite
5. **Review**: Delegate to @reviewer to check fix quality, ensure no regressions, and verify conventions are followed. Fix any issues raised
6. **Security**: If the bug involves auth, user data, or external APIs, delegate to @security for a targeted audit
7. **Deploy**: If CI/CD exists, delegate to @devops to verify the pipeline passes and the fix is ready to ship

## Rules

- Minimal changes only — fix the bug, nothing else
- Always add a regression test
- If the fix requires architectural changes, stop and explain the scope before proceeding
- Verify the full app builds and all tests pass after the fix
- Report back a summary: root cause, fix applied, tests added, review status
