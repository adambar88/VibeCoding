# Phase 2: Planning — Task Breakdown & Sprint Plan

## Task Breakdown

### Foundation & Infrastructure

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-001 | Set up Supabase project, configure env vars, create client singleton | S | — | @backend-developer | 1 |
| TASK-002 | Design and apply DB schema (categories, expenses tables with RLS) | M | TASK-001 | @backend-developer | 1 |
| TASK-003 | Generate Supabase TypeScript types | XS | TASK-002 | @backend-developer | 1 |
| TASK-004 | Set up React Router with protected route wrapper and layout shell | S | — | @developer | 1 |
| TASK-005 | Design app layout, color palette, Tailwind theme tokens | S | — | @designer | 1 |

### Auth (US-1, US-2)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-006 | Build Login/SignUp page UI | M | TASK-004, TASK-005 | @developer | 1 |
| TASK-007 | Implement Supabase Auth (signUp, signIn, signOut, onAuthStateChange) | M | TASK-001 | @developer | 1 |
| TASK-008 | Implement auth context provider and useAuth hook | S | TASK-007 | @developer | 1 |
| TASK-009 | Implement protected route redirect | S | TASK-004, TASK-008 | @developer | 1 |

### Categories (US-10)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-010 | Create categories service layer (CRUD against Supabase) | S | TASK-002, TASK-003 | @developer | 1 |
| TASK-011 | Seed default categories via migration | XS | TASK-002 | @backend-developer | 1 |
| TASK-012 | Build Categories management page UI | M | TASK-010, TASK-005 | @developer | 1 |

### Expenses CRUD (US-3, US-4, US-5, US-6)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-013 | Create expenses service layer (CRUD + list with pagination) | M | TASK-002, TASK-003 | @developer | 1 |
| TASK-014 | Build Add Expense form UI | M | TASK-010, TASK-005 | @developer | 1 |
| TASK-015 | Build Expense List page UI | M | TASK-013, TASK-005 | @developer | 1 |
| TASK-016 | Implement Edit Expense flow | S | TASK-014, TASK-015 | @developer | 1 |
| TASK-017 | Implement Delete Expense with confirmation | S | TASK-015 | @developer | 1 |

### Real-Time Sync (US-12)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-018 | Enable Supabase Realtime on expenses table | S | TASK-002 | @backend-developer | 2 |
| TASK-019 | Create useRealtimeExpenses hook | M | TASK-013, TASK-018 | @developer | 2 |

### Dashboard (US-8)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-020 | Build Dashboard page layout with summary cards | M | TASK-005, TASK-013 | @developer | 2 |
| TASK-021 | Implement spending-by-category chart | M | TASK-020 | @developer | 2 |
| TASK-022 | Implement spending-over-time chart | M | TASK-020 | @developer | 2 |
| TASK-023 | Create dashboard data aggregation hooks | M | TASK-013 | @developer | 2 |

### Google Sheets Import (US-11)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-024 | Implement Google Sheets API auth flow | L | TASK-001 | @backend-developer | 2 |
| TASK-025 | Build import parser (read rows, validate, map to schema) | L | TASK-024, TASK-010 | @developer | 2 |
| TASK-026 | Implement idempotent upsert logic | M | TASK-025 | @developer | 2 |
| TASK-027 | Build Import page UI | M | TASK-025, TASK-005 | @developer | 2 |

### Filter & Search — Stretch (US-7)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-028 | Add filter bar to expense list | M | TASK-015 | @developer | 3 |
| TASK-029 | Implement filter/search query logic | S | TASK-013 | @developer | 3 |

### Monthly View — Stretch (US-9)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-030 | Add month selector to dashboard | M | TASK-023 | @developer | 3 |

### Responsive — Stretch (US-14)

| ID | Title | Size | Dependencies | Agent | Sprint |
|---|---|---|---|---|---|
| TASK-031 | Audit and adapt all pages for mobile | M | All UI tasks | @designer | 3 |

## Dependency Map

```
TASK-001 (Supabase) → TASK-002 (Schema) → TASK-003 (Types)
                                         → TASK-010 (Categories svc) → TASK-012 (Categories UI)
                                         → TASK-013 (Expenses svc) → TASK-014,015,016,017 (Expense UI)
                                         → TASK-011 (Seed categories)
                                         → TASK-018 (Realtime) → TASK-019 (Realtime hook)
TASK-004 (Router) → TASK-006 (Login UI) → TASK-009 (Protected routes)
TASK-007 (Auth) → TASK-008 (Auth context) → TASK-009
TASK-013 → TASK-023 (Dashboard queries) → TASK-020,021,022 (Dashboard UI)
TASK-024 (Sheets auth) → TASK-025 (Parser) → TASK-026 (Upsert) → TASK-027 (Import UI)
```

## Sprint Plan

### Sprint 1 — MVP Core (TASK-001 to TASK-017, TASK-032)

Auth + Expense CRUD + Categories. Both users can sign in and manage expenses.

### Sprint 2 — MVP Complete (TASK-018 to TASK-027, TASK-033-036)

Dashboard, Google Sheets import, real-time sync. Full MVP.

### Sprint 3 — Stretch (TASK-028 to TASK-031, TASK-037)

Filters, monthly view, mobile responsive, final review.

## Summary

- **Total tasks:** 37
- **Sprint 1:** 16 tasks (MVP Core)
- **Sprint 2:** 14 tasks (MVP Complete)
- **Sprint 3:** 7 tasks (Stretch + Polish)
