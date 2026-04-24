---
applyTo: "**/*.test.{ts,tsx,js,jsx,spec.ts,spec.tsx}"
description: "Use when writing or modifying tests. Covers testing patterns, mocking strategies, and quality standards. UPDATE this file via /init-project or manually for your test framework."
---

# Testing Guidelines

<!-- UPDATE: Replace framework-specific details after running /init-project -->

## Test Structure
- Use `describe` / `it` blocks for clear organization
- Name tests as behaviors: `it('should redirect unauthenticated users')`
- One assertion focus per test — test one behavior, not many
- Each test must be independent — no shared mutable state between tests

## What to Test
- **Business logic**: Validation, calculations, state transitions, data transformations
- **User interactions**: Click, type, submit, navigate — test what users do
- **Edge cases**: Empty states, error states, boundary values, null/undefined inputs
- **Integration points**: API calls, database queries, external service interactions

## What NOT to Test
- Framework internals or library code
- Implementation details (private methods, internal state shape)
- Exact CSS/styling (use visual regression tools instead)
- Third-party library behavior

## Mocking Strategy
- Mock at module/system boundaries only (APIs, databases, file system)
- Prefer real implementations over mocks when feasible
- Never mock the module under test
- Use factories or fixtures for test data — avoid hardcoded magic values

## Quality Standards
- Tests must be deterministic — no flaky tests depending on timing or order
- Tests must be fast — mock slow I/O, use in-memory databases for integration tests
- Cover the happy path AND at least one error path per function
- Aim for meaningful coverage, not arbitrary percentage targets

