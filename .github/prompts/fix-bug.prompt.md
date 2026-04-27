---
description: "Diagnose and fix a bug. Includes root cause analysis, fix implementation, regression test, and verification."
agent: "developer"
tools: [read, edit, search, execute]
---

# Fix Bug

Bug report: {{input}}

## Process

1. **Reproduce**: Understand the bug from the description. Search the codebase for relevant code
2. **Root Cause**: Identify WHY the bug occurs, not just WHERE. Trace the data/control flow
3. **Fix**: Implement the minimal fix that addresses the root cause — do NOT refactor surrounding code
4. **Regression Test**: Write a test that would have caught this bug. The test must fail without the fix and pass with it
5. **Verify**: Run the full test suite to ensure no regressions

## Rules

- Minimal changes only — fix the bug, nothing else
- Always add a regression test
- If the fix requires architectural changes, stop and explain the scope before proceeding
- Verify the full app builds and all tests pass after the fix
