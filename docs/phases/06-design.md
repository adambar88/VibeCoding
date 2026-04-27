The file doesn't exist yet and the create_file tool is disabled. Here's the complete markdown for [docs/phases/06-design.md](docs/phases/06-design.md) — copy it into that file:

---

# Phase 6: UI/UX Design Specification

> Author: @designer  
> Date: April 27, 2026  
> Status: Ready for @developer

---

## 1. Design Direction

**Aesthetic**: Clean, utilitarian finance app. Light theme, generous whitespace, clear data hierarchy. No decorative elements; every pixel serves function.

**Tone**: Calm, trustworthy, efficient.

---

## 2. Design Tokens (Tailwind CSS 4)

### 2.1 Color Palette

| Role | Tailwind Class | Hex | Usage |
|---|---|---|---|
| Background | `bg-gray-50` | #F9FAFB | Page background |
| Surface | `bg-white` | #FFFFFF | Cards, modals, forms |
| Primary | `bg-emerald-600` | #059669 | CTAs, active nav, success |
| Primary hover | `hover:bg-emerald-700` | #047857 | Button hover |
| Danger | `bg-red-500` | #EF4444 | Delete, errors |
| Danger hover | `hover:bg-red-600` | #DC2626 | Delete hover |
| Text primary | `text-gray-900` | #111827 | Headings, body |
| Text secondary | `text-gray-500` | #6B7280 | Labels, captions |
| Text muted | `text-gray-400` | #9CA3AF | Placeholders |
| Border | `border-gray-200` | #E5E7EB | Dividers, card borders |
| Focus ring | `ring-emerald-500` | #10B981 | Focus indicator |

Category colors come from the DB seed data (used in charts/badges).

### 2.2 Typography

| Element | Classes | Size |
|---|---|---|
| Page title | `text-2xl font-bold text-gray-900` | 24px |
| Section heading | `text-lg font-semibold text-gray-900` | 18px |
| Body | `text-sm text-gray-700` | 14px |
| Caption / label | `text-xs font-medium text-gray-500 uppercase tracking-wide` | 12px |
| Table data | `text-sm text-gray-900 tabular-nums` | 14px |
| Amount (large) | `text-3xl font-bold tabular-nums` | 30px |

System font stack (Tailwind default `font-sans`). `tabular-nums` on all monetary values.

### 2.3 Spacing Scale

| Context | Value |
|---|---|
| Page padding | `p-4` mobile, `p-6` md, `p-8` lg |
| Card padding | `p-4` mobile, `p-6` md |
| Card gap (grid) | `gap-4` mobile, `gap-6` md |
| Form field gap | `space-y-4` |
| Button padding | `px-4 py-2` (default), `px-3 py-1.5` (small) |
| Section spacing | `space-y-6` |

### 2.4 Component Tokens

| Component | Classes |
|---|---|
| Card | `bg-white rounded-lg border border-gray-200 shadow-sm` |
| Button primary | `bg-emerald-600 hover:bg-emerald-700 text-white font-medium rounded-lg px-4 py-2 transition-colors focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2` |
| Button secondary | `bg-white hover:bg-gray-50 text-gray-700 font-medium rounded-lg px-4 py-2 border border-gray-300 transition-colors focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2` |
| Button danger | `bg-red-500 hover:bg-red-600 text-white font-medium rounded-lg px-4 py-2 transition-colors focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2` |
| Input | `w-full rounded-lg border border-gray-300 px-3 py-2 text-sm text-gray-900 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 disabled:bg-gray-100 disabled:text-gray-500` |
| Select | Same as Input |
| Badge (category) | `inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium` + dynamic `bg-{color}/10 text-{color}` |
| Table row hover | `hover:bg-gray-50 transition-colors` |

---

## 3. Layout & Responsive Breakpoints

### 3.1 Breakpoints

| Breakpoint | Width | Behavior |
|---|---|---|
| Mobile | < 768px | Single column, bottom nav, stacked cards |
| Tablet | 768px (`md`) | Sidebar nav collapses to icons, 2-col dashboard |
| Desktop | 1024px (`lg`) | Full sidebar with labels, 3-col dashboard |
| Wide | 1280px (`xl`) | Max content width `max-w-7xl mx-auto` |

### 3.2 App Shell — `Layout.tsx`

```
Desktop (lg+):
┌──────────┬──────────────────────────────────────┐
│          │  Header (page title + user menu)      │
│  Sidebar │──────────────────────────────────────│
│  (w-64)  │                                      │
│  - Logo  │  <Outlet /> (page content)            │
│  - Nav   │  max-w-7xl, centered                  │
│  - Sign  │                                      │
│    out   │                                      │
└──────────┴──────────────────────────────────────┘

Mobile (< md):
┌──────────────────────────────────────────────────┐
│  Header (hamburger + logo + user avatar)          │
│──────────────────────────────────────────────────│
│                                                  │
│  <Outlet /> (page content, p-4)                   │
│                                                  │
│──────────────────────────────────────────────────│
│  Bottom nav (Dashboard, Expenses, Categories,     │
│  Import — 4 icons)                                │
└──────────────────────────────────────────────────┘
```

**Sidebar nav items** (Lucide React icons):
- Dashboard (`/`) — `LayoutDashboard`
- Expenses (`/expenses`) — `Receipt`
- Categories (`/categories`) — `Tags`
- Import (`/import`) — `Upload`
- Sign out (bottom) — `LogOut`

Active: `bg-emerald-50 text-emerald-700 font-semibold`. Inactive: `text-gray-600 hover:bg-gray-100`.

---

## 4. Page-by-Page Component Specs

### 4.1 Login Page (`/login`)

Centered card on `bg-gray-50`, `max-w-sm`. App name above.

**`LoginForm` States:**

| State | Behavior |
|---|---|
| Default | Email + password inputs, "Sign in" button |
| Loading | Button spinner, inputs disabled |
| Error | Red `role="alert"` banner above form |
| Success | Redirect to `/` |

```
┌────────────────────────────┐
│     💰 Budget Tracker      │
│                            │
│  ┌──────────────────────┐  │
│  │ Email                │  │
│  └──────────────────────┘  │
│  ┌──────────────────────┐  │
│  │ Password             │  │
│  └──────────────────────┘  │
│                            │
│  [ Sign in             ]   │
│                            │
│  Don't have an account?    │
│  Sign up                   │
└────────────────────────────┘
```

**A11y:** `<form aria-label="Sign in">`, visible labels, `role="alert"` on errors, submit on Enter.

---

### 4.2 Dashboard Page (`/`)

**Grid:** Mobile 1-col → `md` 2-col summary cards → `lg` 3 summary cards in row, 2 charts side-by-side.

**`SummaryCards`** — 3 cards:
1. **Total Spent** (current month) — emerald
2. **Expense Count** — blue
3. **Average per Expense** — amber

```
┌─────────────────────────┐
│  TOTAL SPENT            │  ← caption
│  $2,847.50              │  ← text-3xl font-bold
│  ↑ 12% vs last month   │  ← text-xs green/red
└─────────────────────────┘
```

| State | Behavior |
|---|---|
| Loading | `animate-pulse` skeleton |
| Error | "Failed to load" + retry |
| Empty | $0.00 + "No expenses this month" |
| Default | Formatted values + month-over-month delta |

**`SpendingByCategory`** — Recharts `PieChart` in card wrapper.

| State | Behavior |
|---|---|
| Loading | Skeleton circle + legend lines |
| Empty | "No data yet" centered |
| Default | Pie + legend with category colors |

**`SpendingOverTime`** — Recharts `BarChart` (daily totals, current month).

Same loading/empty pattern.

**A11y:** `aria-label` on charts, `aria-live="polite"` on summary values, legends supplement color.

---

### 4.3 Expenses Page (`/expenses`)

```
Desktop:
┌──────────────────────────────────────────────────────┐
│  Expenses                          [ + Add Expense ] │
│──────────────────────────────────────────────────────│
│  [Category ▾] [Date from] [Date to] [Search]        │
│──────────────────────────────────────────────────────│
│  Date       │ Description    │ Category  │ Amount    │
│  2026-04-25 │ Whole Foods    │ Groceries │ $127.43   │
│  2026-04-24 │ Uber           │ Transport │  $18.50   │
└──────────────────────────────────────────────────────┘

Mobile: Stacked cards with description, date · category, amount.
```

**`ExpenseFilters`:**

| State | Behavior |
|---|---|
| Default | All empty = show all |
| Active | Badge count on mobile filter icon |
| Clearing | "Clear filters" link when any active |

Mobile: collapsed behind filter icon.

**`ExpenseList`:**

| State | Behavior |
|---|---|
| Loading | 5 skeleton rows |
| Empty | "No expenses yet" + CTA |
| Empty (filtered) | "No matches" + "Clear filters" |
| Error | "Failed to load" + retry |
| Default | Sorted date desc, 20/page |

**`ExpenseRow`:** Click → edit modal. Delete icon → `ConfirmDialog`. Category as colored badge.

**`ExpenseForm`** (modal, shared Add/Edit):

| State | Behavior |
|---|---|
| Add | Empty form, "Add Expense" title |
| Edit | Pre-filled, "Edit Expense" title |
| Submitting | Spinner, disabled |
| Validation | Inline red text below fields |
| Success | Close modal, toast "Expense saved" |

Fields: Amount (number, required), Date (date, required, default today), Category (select, required), Description (text, optional).

**A11y:** Semantic `<table>` with `<th scope="col">`, `role="list"` on mobile cards, `aria-label` on delete buttons, modal focus trap + Escape.

---

### 4.4 Categories Page (`/categories`)

```
┌──────────────────────────────────────────┐
│  Categories                [+ Add]       │
│──────────────────────────────────────────│
│  ● Groceries         [Edit] [Delete]     │
│  ● Dining Out        [Edit] [Delete]     │
└──────────────────────────────────────────┘
```

**`CategoryList`:** Loading → skeleton rows. Empty → CTA. Default → alphabetical.

**`CategoryForm`** (modal): Name (required, unique) + Color (preset swatches). Same state pattern as ExpenseForm.

**A11y:** Color dot `aria-hidden="true"`, delete requires confirmation.

---

### 4.5 Import Page (`/import`)

```
┌──────────────────────────────────────────┐
│  Import from Google Sheets               │
│──────────────────────────────────────────│
│  ┌────────────────────────────────────┐  │
│  │ Paste Google Sheets URL...         │  │
│  └────────────────────────────────────┘  │
│  [ Import ]                              │
│──────────────────────────────────────────│
│  (Results appear after import)           │
└──────────────────────────────────────────┘
```

**`ImportForm`:** Default → URL + button. Importing → progress text, disabled. Error → red alert.

**`ImportResults`:** Success → green banner. Partial → amber + expandable error list. Failure → red.

**A11y:** `aria-live="polite"` on progress, `role="status"` on results.

---

### 4.6 Shared Components

**`ConfirmDialog`:** `role="alertdialog"`, `aria-modal="true"`, `aria-describedby`, focus trap, Escape to cancel. Cancel (secondary) + Confirm (danger).

**`LoadingSpinner`:** `animate-spin` SVG, `role="status"`, `aria-label="Loading"`.

**`Layout`:** `<nav aria-label="Main navigation">`, skip-to-content link (`sr-only focus:not-sr-only`).

---

## 5. User Flow Map

```
                    ┌─────────┐
                    │  Start  │
                    └────┬────┘
                         │
                    ┌────▼────┐
               ┌────│ Authed? │────┐
               │NO  └─────────┘ YES│
               │                   │
          ┌────▼────┐         ┌────▼──────┐
          │  Login  │────────►│ Dashboard │◄─────────────┐
          └─────────┘ success └─────┬─────┘              │
                                    │                    │
                       ┌────────────┼────────────┐       │
                       │            │            │       │
                 ┌─────▼────┐ ┌────▼─────┐ ┌────▼──┐    │
                 │ Expenses │ │Categories│ │Import │    │
                 └─────┬────┘ └────┬─────┘ └────┬──┘    │
                       │          │             │       │
                  Add/Edit/    Add/Edit/    Import      │
                  Delete       Delete       Results     │
                  (modals)     (modals)                 │
                       │          │             │       │
                       └──────────┴─────────────┴───────┘
                              (nav between pages)
```

**Key flows:**
1. **First visit** → Login → Dashboard
2. **Add expense** → Expenses → "+ Add" → Modal → Submit → Real-time list update
3. **Review spending** → Dashboard → Charts
4. **Import history** → Import → Paste URL → Results → Verify in Expenses
5. **Manage categories** → Categories → Add/Edit/Delete
6. **Sign out** → Sidebar → Sign out → Login

---

## 6. Accessibility Plan

### 6.1 Standards
WCAG 2.1 AA. All interactive elements keyboard-accessible.

### 6.2 Keyboard Navigation

| Context | Keys | Action |
|---|---|---|
| Global | `Tab` / `Shift+Tab` | Navigate focusable elements |
| Modal | `Tab` cycle | Focus trapped |
| Modal | `Escape` | Close |
| Table | `Tab` | Focus row action buttons |
| Form | `Enter` | Submit |

### 6.3 ARIA Patterns

| Component | Pattern |
|---|---|
| Sidebar | `<nav aria-label="Main navigation">` |
| Modal (form) | `role="dialog"`, `aria-modal="true"`, `aria-labelledby` |
| Confirm dialog | `role="alertdialog"`, `aria-describedby` |
| Loading | `role="status"`, `aria-label="Loading"` |
| Error alert | `role="alert"` |
| Toast | `role="status"`, `aria-live="polite"` |
| Data table | Semantic `<table>`, `<th scope="col">` |
| Skip link | `.sr-only.focus:not-sr-only` first in body |
| Charts | `aria-label` describing data |

### 6.4 Color & Contrast
- gray-900 on white = 17.4:1, gray-500 on white = 4.6:1 (both pass AA)
- Focus rings: 2px emerald-500 with offset
- Danger uses icon + color + text (not color alone)
- Charts use legends, not color only

### 6.5 Motion
- `prefers-reduced-motion: reduce` → disable `animate-pulse`, use static placeholders
- Transitions: 150ms

---

## 7. Interaction Details

### Toasts
- Top-right desktop, top-center mobile
- Auto-dismiss 4s
- Types: success (emerald), error (red), info (blue)
- Stack max 3

### Empty States
- Centered text + single CTA, no illustrations

### Loading
- Skeleton screens for page loads (match content shape)
- Inline spinners for button actions only

### Errors
- Inline below fields for validation
- Banner for API failures with retry
- Never show raw error messages

---

## 8. Recharts Styling

```typescript
const CHART_THEME = {
  tooltip: {
    contentStyle: {
      backgroundColor: '#fff',
      border: '1px solid #E5E7EB',
      borderRadius: '0.5rem',
      fontSize: '0.875rem',
      boxShadow: '0 1px 2px rgba(0,0,0,0.05)',
    },
  },
  axis: {
    tick: { fontSize: 12, fill: '#6B7280' },
    axisLine: { stroke: '#E5E7EB' },
    tickLine: false,
  },
  grid: { strokeDasharray: '3 3', stroke: '#F3F4F6' },
};
```

- Pie: category colors from DB, 2px white stroke between segments
- Bar: emerald-500 fill, emerald-600 hover, rounded top
- Line: emerald-500, 2px, dot on hover only
- All charts: `<ResponsiveContainer width="100%" height={300}>`

---

### Handoff To: @developer
Components: LoginForm, LoginPage, Layout, ProtectedRoute, LoadingSpinner, ConfirmDialog, SummaryCards, SpendingByCategory, SpendingOverTime, DashboardPage, ExpenseForm, ExpenseList, ExpenseRow, ExpenseFilters, ExpensesPage, CategoryForm, CategoryList, CategoriesPage, ImportForm, ImportResults, ImportPage
Design tokens: Tailwind defaults — emerald-600 primary, gray-50 bg, gray-900 text, system font stack, tabular-nums for money
Accessibility requirements: WCAG 2.1 AA, semantic HTML, focus traps in modals, aria-labels on all interactive elements, skip-to-content link, prefers-reduced-motion support, 4.5:1 contrast ratios, role="alert" for errors, role="dialog" for modals
User flows: 6 flows defined