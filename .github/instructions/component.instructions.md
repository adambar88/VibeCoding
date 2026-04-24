---
applyTo: "**/*.{tsx,jsx,vue,svelte,astro}"
description: "Use when creating or editing UI components. Covers component patterns, state management, and rendering conventions. UPDATE this file via /init-project or manually for your framework."
---

# UI Component Guidelines

<!-- UPDATE: Replace these with your framework's conventions after running /init-project -->

## General Principles
- Prefer composition over inheritance
- Keep components small and focused — one responsibility per component
- Extract reusable logic into custom hooks or composables
- Colocate tests next to components: `Component.test.{ts,tsx}`
- Colocate styles when using CSS modules or scoped styles

## Props & State
- Define explicit prop interfaces/types — avoid `any`
- Minimize component state — lift shared state to the nearest common parent
- Derive values from state rather than storing computed data

## Rendering
- Avoid unnecessary re-renders — memoize expensive computations
- Use lazy loading for routes and heavy components
- Handle all states: loading, error, empty, and success

## Accessibility
- Use semantic HTML elements (`button`, `nav`, `main`, not `div` for everything)
- Ensure keyboard navigation works for all interactive elements
- Add ARIA attributes where semantic HTML isn't sufficient
- Maintain a logical heading hierarchy

## File Organization
<!-- UPDATE: Adjust to your project's structure -->
- Feature-based folders: `src/features/<name>/`
- Shared UI components: `src/shared/components/`
- Each feature folder contains its components, hooks, types, and tests

