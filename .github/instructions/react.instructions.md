---
applyTo: "**/*.tsx"
description: "Use when creating or editing React components. Covers component patterns, hooks, and JSX conventions."
---

# React Component Guidelines

- Prefer explicit prop interfaces over `React.FC`
- Extract custom hooks when logic is reused across 2+ components
- Use `Suspense` boundaries for async components
- Prefer composition over prop drilling
- Colocate tests: `Component.test.tsx` next to `Component.tsx`
