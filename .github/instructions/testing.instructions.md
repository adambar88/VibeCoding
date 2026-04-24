---
applyTo: "**/*.test.{ts,tsx}"
description: "Use when writing or modifying tests. Covers Vitest patterns, React Testing Library, and mocking strategies."
---

# Testing Guidelines

- Use `describe` / `it` blocks
- Test behavior, not implementation details
- Use `screen.getByRole()` over `getByTestId()`
- Mock at module boundaries only
- Each test must be independent — no shared mutable state
