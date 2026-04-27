I have all the context needed. Here's the complete architecture document:

---

# Phase 4: Architecture

Here is the complete content for `docs/phases/04-architecture.md`:

```markdown
# Phase 4: System Architecture

> Author: @architect
> Date: April 27, 2026
> Status: Ready for @designer + @developer

---

## 1. System Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                      Browser (SPA)                      │
│                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────┐  │
│  │  Auth     │  │ Expenses │  │Dashboard │  │ Import │  │
│  │  Feature  │  │ Feature  │  │ Feature  │  │Feature │  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └───┬────┘  │
│       │              │             │             │       │
│  ┌────▼──────────────▼─────────────▼─────────────▼────┐  │
│  │            TanStack Query (cache layer)            │  │
│  └────────────────────┬───────────────────────────────┘  │
│                       │                                  │
│  ┌────────────────────▼───────────────────────────────┐  │
│  │         Supabase Client (singleton)                │  │
│  │    + Realtime subscriptions (Postgres Changes)     │  │
│  └────────────────────┬───────────────────────────────┘  │
│                       │                                  │
│  ┌────────────────────▼───────────────────────────────┐  │
│  │    Google Sheets API (fetch via API key, import)   │  │
│  └────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                        │
                        │ HTTPS
                        ▼
┌─────────────────────────────────────────────────────────┐
│                    Supabase Cloud                        │
│                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐  │
│  │   Auth    │  │ Realtime │  │  PostgreSQL           │  │
│  │ (GoTrue) │  │  (WS)    │  │  + RLS Policies       │  │
│  └──────────┘  └──────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Auth**: User signs in via Supabase Auth → JWT stored in browser → attached to all Supabase requests automatically.
2. **CRUD**: Components call custom hooks → hooks use TanStack Query → query functions call Supabase client → Supabase enforces RLS → data returned and cached.
3. **Real-time**: Supabase Postgres Changes push events over WebSocket → `useRealtimeInvalidation` hook invalidates TanStack Query cache → affected queries refetch automatically.
4. **Import**: Client fetches Google Sheet via REST API (API key) → parses rows → upserts into Supabase via the client.

### State Management Strategy

| State Type | Solution | Examples |
|---|---|---|
| Server state | TanStack Query | Expenses list, categories, dashboard aggregates |
| Auth state | React Context | Current user, session, loading state |
| UI state | Component-local `useState` | Form inputs, modal open/close, filter selections |
| Real-time sync | Supabase Realtime + TQ invalidation | Cross-user expense updates |

---

## 2. Folder Structure

```
src/
├── App.tsx                          # Router + providers setup
├── main.tsx                         # Entry point
├── index.css                        # Tailwind imports + global styles
│
├── features/
│   ├── auth/
│   │   ├── components/
│   │   │   └── LoginForm.tsx        # Email/password form
│   │   ├── hooks/
│   │   │   └── useAuth.ts           # signIn, signUp, signOut, session
│   │   ├── context/
│   │   │   └── AuthProvider.tsx      # AuthContext + onAuthStateChange listener
│   │   └── pages/
│   │       └── LoginPage.tsx
│   │
│   ├── expenses/
│   │   ├── components/
│   │   │   ├── ExpenseForm.tsx       # Add/Edit form (shared)
│   │   │   ├── ExpenseList.tsx       # Table/list of expenses
│   │   │   ├── ExpenseRow.tsx        # Single row with edit/delete actions
│   │   │   └── ExpenseFilters.tsx    # Category, date range, search filters
│   │   ├── hooks/
│   │   │   ├── useExpenses.ts        # TanStack Query: list, filter, paginate
│   │   │   ├── useExpenseMutations.ts # TanStack Mutation: create, update, delete
│   │   │   └── useRealtimeExpenses.ts # Realtime invalidation for expenses
│   │   └── pages/
│   │       └── ExpensesPage.tsx
│   │
│   ├── categories/
│   │   ├── components/
│   │   │   ├── CategoryForm.tsx
│   │   │   └── CategoryList.tsx
│   │   ├── hooks/
│   │   │   ├── useCategories.ts      # TanStack Query: list all
│   │   │   └── useCategoryMutations.ts
│   │   └── pages/
│   │       └── CategoriesPage.tsx
│   │
│   ├── dashboard/
│   │   ├── components/
│   │   │   ├── SummaryCards.tsx       # Total spend, count, avg
│   │   │   ├── SpendingByCategory.tsx # PieChart (Recharts)
│   │   │   └── SpendingOverTime.tsx   # BarChart / LineChart (Recharts)
│   │   ├── hooks/
│   │   │   └── useDashboardData.ts   # Aggregation queries
│   │   └── pages/
│   │       └── DashboardPage.tsx
│   │
│   └── import/
│       ├── components/
│       │   ├── ImportForm.tsx         # Sheet URL input + trigger
│       │   └── ImportResults.tsx      # Success/failure summary
│       ├── hooks/
│       │   └── useSheetImport.ts     # Fetch, parse, validate, upsert
│       ├── lib/
│       │   ├── sheetsApi.ts          # Google Sheets API fetch wrapper
│       │   └── sheetParser.ts        # Row → expense mapping + validation
│       └── pages/
│           └── ImportPage.tsx
│
├── shared/
│   ├── components/
│   │   ├── Layout.tsx                # App shell: sidebar/header + <Outlet>
│   │   ├── ProtectedRoute.tsx        # Auth guard wrapper
│   │   ├── LoadingSpinner.tsx
│   │   └── ConfirmDialog.tsx         # Reusable delete confirmation
│   ├── hooks/
│   │   └── useRealtimeInvalidation.ts # Generic realtime → TQ invalidation
│   ├── lib/
│   │   ├── supabase.ts              # Supabase client singleton (exists)
│   │   └── queryClient.ts           # TanStack QueryClient config
│   └── types/
│       ├── database.ts              # Generated Supabase types (exists)
│       └── models.ts                # App-level interfaces (see §3)
```

---

## 3. Data Models

### TypeScript Interfaces

```typescript
// src/shared/types/models.ts

export interface Category {
  id: string;           // uuid, PK
  name: string;         // e.g. "Groceries"
  color: string;        // hex color for charts, e.g. "#34D399"
  created_at: string;   // ISO timestamp
}

export interface Expense {
  id: string;           // uuid, PK
  amount: number;       // positive decimal, stored as numeric(10,2)
  date: string;         // ISO date string "YYYY-MM-DD"
  description: string | null;
  category_id: string;  // FK → categories.id
  user_id: string;      // FK → auth.users.id (who entered it)
  created_at: string;   // ISO timestamp
  updated_at: string;   // ISO timestamp
}

// Joined type for display
export interface ExpenseWithCategory extends Expense {
  category: Pick<Category, 'name' | 'color'>;
}

// Form input types (no id, no timestamps, no user_id)
export interface ExpenseFormData {
  amount: number;
  date: string;
  description?: string;
  category_id: string;
}

export interface CategoryFormData {
  name: string;
  color: string;
}

// Import types
export interface ImportResult {
  total_rows: number;
  imported: number;
  skipped: number;
  errors: ImportError[];
}

export interface ImportError {
  row: number;
  message: string;
}
```

---

## 4. Supabase Database Schema

### SQL Migrations

```sql
-- 001_create_categories.sql

create table public.categories (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  color text not null default '#6B7280',
  created_at timestamptz not null default now()
);

-- Enable RLS
alter table public.categories enable row level security;

-- All authenticated users can read categories (shared resource)
create policy "Authenticated users can read categories"
  on public.categories for select
  to authenticated
  using (true);

-- All authenticated users can insert categories
create policy "Authenticated users can insert categories"
  on public.categories for insert
  to authenticated
  with check (true);

-- All authenticated users can update categories
create policy "Authenticated users can update categories"
  on public.categories for update
  to authenticated
  using (true)
  with check (true);

-- All authenticated users can delete categories
create policy "Authenticated users can delete categories"
  on public.categories for delete
  to authenticated
  using (true);
```

```sql
-- 002_create_expenses.sql

create table public.expenses (
  id uuid primary key default gen_random_uuid(),
  amount numeric(10,2) not null check (amount > 0),
  date date not null,
  description text,
  category_id uuid not null references public.categories(id) on delete restrict,
  user_id uuid not null default auth.uid() references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Indexes for common queries
create index idx_expenses_date on public.expenses(date desc);
create index idx_expenses_category on public.expenses(category_id);
create index idx_expenses_user on public.expenses(user_id);

-- Enable RLS
alter table public.expenses enable row level security;

-- All authenticated users can read all expenses (shared household)
create policy "Authenticated users can read all expenses"
  on public.expenses for select
  to authenticated
  using (true);

-- Authenticated users can insert expenses (user_id auto-set)
create policy "Authenticated users can insert expenses"
  on public.expenses for insert
  to authenticated
  with check (auth.uid() = user_id);

-- Authenticated users can update any expense (shared household)
create policy "Authenticated users can update expenses"
  on public.expenses for update
  to authenticated
  using (true)
  with check (true);

-- Authenticated users can delete any expense (shared household)
create policy "Authenticated users can delete expenses"
  on public.expenses for delete
  to authenticated
  using (true);
```

```sql
-- 003_seed_categories.sql

insert into public.categories (name, color) values
  ('Groceries',       '#34D399'),
  ('Dining Out',      '#F87171'),
  ('Transportation',  '#60A5FA'),
  ('Utilities',       '#A78BFA'),
  ('Entertainment',   '#FBBF24'),
  ('Health',          '#F472B6'),
  ('Shopping',        '#FB923C'),
  ('Housing',         '#2DD4BF'),
  ('Education',       '#818CF8'),
  ('Other',           '#6B7280');
```

```sql
-- 004_enable_realtime.sql

alter publication supabase_realtime add table public.expenses;
alter publication supabase_realtime add table public.categories;
```

```sql
-- 005_updated_at_trigger.sql

create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger set_updated_at
  before update on public.expenses
  for each row
  execute function public.handle_updated_at();
```

### RLS Policy Summary

| Table | Operation | Policy | Rationale |
|---|---|---|---|
| categories | SELECT | All authenticated | Shared categories for both users |
| categories | INSERT/UPDATE/DELETE | All authenticated | Both users manage categories |
| expenses | SELECT | All authenticated | Both users see all expenses |
| expenses | INSERT | `auth.uid() = user_id` | Records who entered the expense |
| expenses | UPDATE/DELETE | All authenticated | Either user can edit/delete any expense |

> **Design Decision**: RLS is permissive because this is a trusted two-person household. There is no multi-tenant isolation. If the app expanded to multiple households, a `household_id` column and stricter policies would be needed.

---

## 5. Routing Structure

```typescript
// Route definitions (React Router v7)

/login              → LoginPage           (public)
/                   → DashboardPage       (protected, default)
/expenses           → ExpensesPage        (protected)
/categories         → CategoriesPage      (protected)
/import             → ImportPage          (protected)
```

### Route Configuration

```typescript
// App.tsx structure
<AuthProvider>
  <QueryClientProvider client={queryClient}>
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route element={<ProtectedRoute />}>
          <Route element={<Layout />}>
            <Route path="/" element={<DashboardPage />} />
            <Route path="/expenses" element={<ExpensesPage />} />
            <Route path="/categories" element={<CategoriesPage />} />
            <Route path="/import" element={<ImportPage />} />
          </Route>
        </Route>
      </Routes>
    </BrowserRouter>
  </QueryClientProvider>
</AuthProvider>
```

`ProtectedRoute` checks `useAuth()` — if no session, redirects to `/login`. `Layout` renders the app shell (nav sidebar/header + `<Outlet />`).

---

## 6. Dependencies

### To Install

```bash
# Runtime
pnpm add @tanstack/react-query recharts

# Dev (already installed: vitest, testing-library, etc.)
pnpm add -D @tanstack/react-query-devtools
```

### Already Installed
- `react`, `react-dom` (19.x)
- `react-router-dom` (7.x)
- `@supabase/supabase-js` (2.x)
- `tailwindcss` (4.x) + `@tailwindcss/vite`

### Not Installing (per research decisions)
- ❌ `react-hook-form` / `zod` — Research recommended it, but for 4-field forms, native controlled inputs with inline validation are sufficient. Revisit if forms grow complex.
- ❌ `zustand` — Only add if complex client state emerges.
- ❌ `react-datepicker` — Native `<input type="date">` is sufficient.

### Environment Variables Required

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=eyJ...
VITE_GOOGLE_SHEETS_API_KEY=AIza...
```

---

## 7. Architecture Decision Records (ADRs)

### ADR-001: TanStack Query as Primary Data Layer

**Context**: The app needs to fetch, cache, and sync data from Supabase across multiple pages and two concurrent users.

**Decision**: Use TanStack Query (v5) for all server state management.

**Rationale**:
- Eliminates manual `useEffect` + `useState` data fetching boilerplate
- Built-in cache with stale-while-revalidate strategy
- `invalidateQueries` integrates cleanly with Supabase Realtime for cross-user sync
- Loading, error, and refetching states handled automatically
- 51M weekly downloads, mature and well-maintained

**Trade-offs**:
- (+) Drastically simpler data fetching code
- (+) Automatic background refetching keeps data fresh
- (-) 13 kB bundle addition
- (-) One more abstraction layer to learn

**Alternatives rejected**: Raw `useEffect` fetching (too much boilerplate), SWR (less mature mutation support), Zustand (not designed for server state).

---

### ADR-002: Supabase Realtime via Cache Invalidation (Not Direct State Sync)

**Context**: Both users need to see each other's changes in real-time (US-12).

**Decision**: Subscribe to Postgres Changes and invalidate TanStack Query cache on events, rather than directly mutating local state from WebSocket payloads.

**Rationale**:
- Simpler mental model: WebSocket event → invalidate query → TQ refetches from server → UI updates
- No risk of local state diverging from server state
- Works with all existing query hooks without modification
- At this app's scale (two users, low write frequency), the extra network round-trip is negligible

**Trade-offs**:
- (+) Single source of truth (always the server)
- (+) No manual state reconciliation
- (-) Extra network request per change event (refetch after invalidation)
- (-) Slightly higher latency vs. direct state injection (~100-200ms)

**Alternatives rejected**: Direct state mutation from WS payload (complex, risk of inconsistency), polling (wasteful, higher latency).

---

### ADR-003: Permissive RLS (Shared Household Model)

**Context**: The app is used by exactly two people in a trusted household.

**Decision**: RLS policies allow all authenticated users to read/update/delete all expenses. Insert policy ensures `user_id` matches `auth.uid()` for attribution.

**Rationale**:
- Both users need to see and manage all expenses (shared budget)
- No multi-tenant isolation needed
- Simplest policy set that still enforces authentication

**Trade-offs**:
- (+) Simple policies, easy to reason about
- (+) Matches the shared-household use case exactly
- (-) Not suitable if the app scales to multiple households (would need `household_id`)
- (-) Any authenticated user can modify any expense (acceptable for two trusted users)

**Migration path**: If multi-household support is needed, add a `households` table, `household_id` FK on expenses/categories, and scope all RLS policies to `household_id`.

---

### ADR-004: Google Sheets API Key (Client-Side Import)

**Context**: One-time import of historical expense data from a Google Sheet.

**Decision**: Use Google Sheets API v4 with a restricted API key, fetching client-side.

**Rationale**:
- Simplest approach for a one-time operation
- No backend or server-side code needed
- API key restricted to app domain + read-only Sheets scope
- User makes sheet "Anyone with link" → pastes URL → import runs

**Trade-offs**:
- (+) Zero backend infrastructure
- (+) Simple implementation (~50 lines)
- (-) API key is visible in client bundle (mitigated by HTTP referrer restriction + read-only scope)
- (-) Requires user to make sheet publicly viewable (temporarily)

**Alternatives rejected**: OAuth 2.0 (adds second auth flow for one-time use), Service Account (requires backend to keep key secret).

---

### ADR-005: No Form Library for MVP

**Context**: Research recommended React Hook Form + Zod, but the app has only two simple forms (expense: 4 fields, category: 2 fields).

**Decision**: Use native controlled inputs with inline validation for MVP. No form library.

**Rationale**:
- Only two forms in the entire app, each with ≤4 fields
- React 19 controlled inputs are sufficient for this complexity
- Saves 9 kB (RHF) + 13 kB (Zod) bundle cost
- Validation requirements are minimal (required fields, positive number)

**Trade-offs**:
- (+) Zero bundle cost for forms
- (+) Fewer abstractions to learn
- (-) Manual error state management
- (-) If forms grow complex, will need to add a library later

**Revisit trigger**: If a form exceeds 6 fields or needs complex validation (conditional fields, async validation).

---

### ADR-006: Recharts for Data Visualization

**Context**: Dashboard requires pie chart (category breakdown) and bar/line chart (spending over time).

**Decision**: Use Recharts for all charts.

**Rationale**:
- Declarative JSX API matches React mental model
- 51M weekly downloads, actively maintained
- Responsive container built-in
- Covers all needed chart types (Pie, Bar, Line)

**Trade-offs**:
- (+) Best React DX of all options
- (+) Large community and ecosystem
- (-) 117.5 kB gzip (largest option)
- (-) SVG rendering less performant than Canvas for very large datasets (not a concern here)

**Alternatives rejected**: Chart.js (imperative API, worse DX), Nivo (maintenance risk, fragmented packages).

---

## 8. Component Data Flow Diagram

```
LoginPage
  └── LoginForm → useAuth().signIn() → Supabase Auth → redirect to /

DashboardPage
  ├── SummaryCards → useDashboardData() → useQuery(['dashboard', month])
  ├── SpendingByCategory → useDashboardData() → Recharts <PieChart>
  └── SpendingOverTime → useDashboardData() → Recharts <BarChart>

ExpensesPage
  ├── ExpenseFilters → local state (category, dateRange, search)
  ├── ExpenseList → useExpenses(filters) → useQuery(['expenses', filters])
  │   └── ExpenseRow → useExpenseMutations().delete → useMutation
  └── ExpenseForm (modal/inline) → useExpenseMutations().create/update → useMutation
  └── useRealtimeExpenses() → subscribes → invalidates ['expenses']

CategoriesPage
  ├── CategoryList → useCategories() → useQuery(['categories'])
  └── CategoryForm → useCategoryMutations() → useMutation

ImportPage
  ├── ImportForm → useSheetImport() → sheetsApi.fetch → sheetParser.parse → supabase.upsert
  └── ImportResults → displays ImportResult
```

---

### Handoff To: @designer + @developer
Folder structure: See §2 above
Data models: `Category`, `Expense`, `ExpenseWithCategory`, `ExpenseFormData`, `CategoryFormData`, `ImportResult`, `ImportError`
Dependencies to install: `@tanstack/react-query`, `recharts`, `@tanstack/react-query-devtools` (dev)
Key patterns:
- TanStack Query for all Supabase data fetching (no raw useEffect)
- `useRealtimeInvalidation(table)` hook for real-time sync
- Feature-based folders with `components/`, `hooks/`, `pages/` subfolders
- Supabase client singleton at `shared/lib/supabase.ts`
- Auth via React Context + `useAuth()` hook
- RLS enforces auth at the database level — no client-side access control logic needed
- Native controlled forms (no form library)
- SQL migrations run in order: schema → seed → realtime → triggers
```

This is the complete proposed architecture. Key architectural highlights:

1. **TanStack Query as the data layer** bridges Supabase and React cleanly, with realtime sync via cache invalidation rather than direct state manipulation.
2. **Permissive RLS** reflects the trusted two-person household — all authenticated users share everything.
3. **Minimal dependencies** — only adding `@tanstack/react-query` and `recharts` beyond what's already installed. No form library, no state management library, no date picker library.
4. **`on delete restrict`** on `category_id` FK prevents orphaned expenses — the UI must handle the "category in use" case per US-10.
5. **Import is client-side only** — no Edge Functions or backend needed for the Google Sheets one-time import.