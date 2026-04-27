I have all the context I need. Here is the complete research document for `docs/phases/03-research.md`:

---

# Phase 3: Technology Research

> Researched: April 27, 2026
> Status: Ready for @architect / @tech-lead review

---

## 1. Charting Library

### Options Compared

| Criteria | Recharts | Chart.js + react-chartjs-2 | Nivo |
|---|---|---|---|
| npm Downloads/wk | ~51M | ~3.5M (wrapper) / chart.js much higher | ~1.8M |
| Bundle Size (gzip) | **117.5 kB** | **~67 kB** (chart.js 66.1 + wrapper 1 kB) | **65.1 kB** (pie alone) |
| Rendering | SVG | Canvas | SVG |
| TypeScript | ✅ Built-in | ✅ Built-in | ✅ Built-in |
| Latest Version | 3.8.1 | chart.js 4.4.8 / react-chartjs-2 5.3.1 | 0.99.0 |
| Last Publish | ~1 month ago | wrapper 6 months ago | ~1 year ago |
| License | MIT | MIT | MIT |
| Tree-shakeable | ✅ side-effect free | ✅ (wrapper); chart.js partial | Limited (not side-effect free) |
| React Integration | Native (declarative JSX) | Thin wrapper over imperative lib | Native (declarative JSX) |

### Analysis

- **Recharts**: Most popular React charting lib. Fully declarative — `<PieChart>`, `<BarChart>`, `<LineChart>` compose like React components. Downside: **largest bundle** at 117.5 kB gzip. Extensive docs, active development (v3 recently released). Supports responsive containers out of the box.

- **Chart.js + react-chartjs-2**: Smallest combined bundle (~67 kB). Canvas-based rendering is more performant with large datasets. Downside: imperative API under the hood — configuration is via options objects, not JSX composition. Doughnut/Pie, Bar, Line all built-in. Huge ecosystem and plugin system.

- **Nivo**: Beautiful defaults and animations (react-spring). But: last published ~1 year ago, single maintainer (`plouc`), each chart type is a separate heavy package (pie alone is 65 kB). You'd need `@nivo/pie` + `@nivo/bar` + `@nivo/line` = potentially 150+ kB. Maintenance risk.

### Recommendation

**Recharts** — Best DX for a React project. Declarative JSX composition aligns with React mental model. The 117.5 kB cost is acceptable for a dashboard-centric app (it's the main feature). Massive community (51M downloads/wk), active maintenance. If bundle size becomes a concern later, Chart.js is the fallback.

### Sources
- [Recharts npm](https://www.npmjs.com/package/recharts)
- [Recharts bundlephobia](https://bundlephobia.com/package/recharts@2.15.3)
- [Chart.js bundlephobia](https://bundlephobia.com/package/chart.js@4.4.8)
- [react-chartjs-2 npm](https://www.npmjs.com/package/react-chartjs-2)
- [Nivo npm](https://www.npmjs.com/package/@nivo/core)
- [@nivo/pie bundlephobia](https://bundlephobia.com/package/@nivo/pie@0.88.0)

---

## 2. Date Picker

### Options Compared

| Criteria | Native `<input type="date">` | react-datepicker | @radix-ui/react-popover + custom |
|---|---|---|---|
| Bundle Size | **0 kB** | ~30 kB gzip | ~5 kB |
| Styling | OS-native (inconsistent) | Custom CSS | Full Tailwind control |
| TypeScript | ✅ | ✅ | ✅ |
| Mobile UX | ✅ Excellent (native pickers) | Decent | Requires work |
| Accessibility | ✅ Built-in | Good | DIY |

### Analysis

- **Native `<input type="date">`**: Zero bundle cost. Excellent mobile UX (OS date pickers). Consistent enough for an expense entry form where the date is secondary to the amount/category. Styled via Tailwind. Supports `min`/`max` attributes for validation.

- **react-datepicker**: Most popular React date picker (~13M downloads/wk). Adds ~30 kB. Overkill for a single date field on an expense form. Worth it only if you need date range selection for filtering.

- **Custom with Radix**: Maximum control but significant effort for minimal gain in this context.

### Recommendation

**Native `<input type="date">`** — For a simple expense entry date, the native input is sufficient. Zero bundle cost, excellent mobile UX, and trivial to implement. If date range filtering is needed on the dashboard later, evaluate `react-datepicker` at that point.

### Sources
- [MDN input type=date](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/date)
- [react-datepicker npm](https://www.npmjs.com/package/react-datepicker)

---

## 3. Google Sheets API — One-Time Import

### Options Compared

| Approach | API Key (restricted) | OAuth 2.0 (user consent) | Service Account |
|---|---|---|---|
| Setup Complexity | Low | Medium | Medium |
| Client-side safe? | ✅ (with HTTP referrer restriction) | ✅ | ❌ (requires server — leaks private key) |
| Sheet must be... | Public or unlisted | Any (user grants access) | Shared with service account email |
| User experience | Paste sheet URL → import | Google sign-in popup → pick sheet | N/A (backend only) |
| Security risk | Low (read-only, restricted key) | Low (scoped to Sheets read-only) | High if key exposed client-side |

### Analysis

- **API Key**: Simplest for a one-time import of the user's own sheet. User makes sheet "Anyone with link can view", pastes the URL, app fetches via `https://sheets.googleapis.com/v4/spreadsheets/{id}/values/{range}?key=API_KEY`. API key restricted to your domain via Google Cloud Console.

- **OAuth 2.0**: Better UX (no need to make sheet public) but adds Google sign-in flow complexity. The app already uses Supabase Auth — adding a second auth flow for a one-time import is overkill.

- **Service Account**: Requires a backend to keep the key secret. Overkill for client-side one-time import.

### Recommendation

**API Key with HTTP referrer restriction** — Simplest approach for one-time import. User makes their Google Sheet viewable via link, pastes the Sheet ID/URL into the import UI, and the app fetches data client-side via the Sheets API v4 REST endpoint. The API key is restricted to your domain in Google Cloud Console (read-only Sheets scope). After import, data lives in Supabase and the Sheet is never accessed again.

Implementation pattern:
```typescript
const SHEETS_API_KEY = import.meta.env.VITE_GOOGLE_SHEETS_API_KEY;

const fetchSheetData = async (spreadsheetId: string, range: string) => {
  const url = `https://sheets.googleapis.com/v4/spreadsheets/${encodeURIComponent(spreadsheetId)}/values/${encodeURIComponent(range)}?key=${SHEETS_API_KEY}`;
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Sheets API error: ${res.status}`);
  const data = await res.json();
  return data.values; // string[][]
};
```

### Sources
- [Google Sheets API v4 docs](https://developers.google.com/sheets/api/guides/concepts)
- [API key restrictions](https://cloud.google.com/docs/authentication/api-keys)

---

## 4. State Management

### Options Compared

| Criteria | React Context | Zustand | TanStack Query |
|---|---|---|---|
| npm Downloads/wk | N/A (built-in) | ~32M | ~51M |
| Bundle Size (gzip) | 0 kB | ~1.1 kB | ~13 kB |
| Purpose | Prop drilling avoidance | Client state | Server/async state |
| Caching | Manual | Manual | ✅ Built-in (stale-while-revalidate) |
| Devtools | React DevTools | Redux DevTools | ✅ Dedicated devtools |
| Re-render optimization | ❌ (all consumers) | ✅ (selector-based) | ✅ (query-key based) |
| TypeScript | ✅ | ✅ | ✅ |
| License | MIT | MIT | MIT |

### Analysis

- **React Context**: Free but causes unnecessary re-renders. Fine for rarely-changing values (theme, auth user). Not suitable for frequently-updated expense lists.

- **Zustand**: Tiny (1.1 kB), zero boilerplate, selector-based re-renders. Great for client-only state (UI state, filters, form drafts). No providers needed.

- **TanStack Query**: Purpose-built for server state. Handles caching, background refetching, optimistic updates, pagination. Perfect for Supabase data fetching — wraps `supabase.from('expenses').select()` calls with automatic cache management and loading/error states.

### Recommendation

**TanStack Query for server state + Zustand for client state (if needed)**

- Use **TanStack Query** as the primary data layer. Every Supabase query (`expenses`, `categories`, etc.) becomes a `useQuery` with cache keys. Mutations use `useMutation` with `queryClient.invalidateQueries()` for automatic refetch. This eliminates manual loading/error state management.
- Use **React Context** for auth state (already simple — just the Supabase user).
- Add **Zustand** only if complex client-only state emerges (e.g., multi-step import wizard state). Don't add it preemptively.

Pattern for Supabase + TanStack Query:
```typescript
const useExpenses = () => {
  return useQuery({
    queryKey: ['expenses'],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('expenses')
        .select('*, categories(name, color)')
        .order('date', { ascending: false });
      if (error) throw error;
      return data;
    },
  });
};
```

### Sources
- [TanStack Query docs](https://tanstack.com/query/latest)
- [TanStack Query npm](https://www.npmjs.com/package/@tanstack/react-query) — 51M downloads/wk, v5.100.5, MIT
- [Zustand npm](https://www.npmjs.com/package/zustand) — 32M downloads/wk, v5.0.12, MIT

---

## 5. Form Handling

### Options Compared

| Criteria | React Hook Form | Native forms (React 19 `useActionState`) |
|---|---|---|
| npm Downloads/wk | ~52M | N/A (built-in) |
| Bundle Size (gzip) | ~9 kB | 0 kB |
| Validation | ✅ Built-in + resolver ecosystem (Zod) | Manual |
| TypeScript | ✅ First-class | ✅ |
| Re-renders | Minimal (uncontrolled) | Depends on implementation |
| Learning curve | Low | Lower |

### Analysis

- **React Hook Form**: Industry standard. Uncontrolled inputs = minimal re-renders. Built-in validation with `register()`. Zod integration via `@hookform/resolvers` for type-safe schema validation. Handles dirty tracking, touched states, submission states.

- **Native forms**: React 19 has `useActionState` and form actions. Sufficient for a simple expense form (amount, date, category, description — 4 fields). But no built-in validation messaging, no dirty tracking.

### Recommendation

**React Hook Form + Zod** — The expense form has validation needs (required amount, valid date, category selection) that RHF handles elegantly. Zod provides type-safe validation schemas that double as TypeScript types. The 9 kB cost is trivial. This is the industry standard pattern.

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const expenseSchema = z.object({
  amount: z.number().positive(),
  date: z.string().min(1),
  category_id: z.string().uuid(),
  description: z.string().optional(),
});

type ExpenseFormData = z.infer<typeof expenseSchema>;
```

### Sources
- [React Hook Form npm](https://www.npmjs.com/package/react-hook-form) — 52M downloads/wk, v7.74.0, MIT
- [React Hook Form docs](https://react-hook-form.com/)
- [@hookform/resolvers](https://www.npmjs.com/package/@hookform/resolvers)

---

## 6. Supabase + React Real-Time Patterns

### Recommended Pattern: TanStack Query + Postgres Changes Invalidation

For this app's scale (single-user expense tracker), the simplest approach is **Postgres Changes** (not Broadcast) combined with TanStack Query cache invalidation:

```typescript
// useRealtimeInvalidation.ts
import { useEffect } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/shared/lib/supabase';

export const useRealtimeInvalidation = (table: string) => {
  const queryClient = useQueryClient();

  useEffect(() => {
    const channel = supabase
      .channel(`${table}-changes`)
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table },
        () => {
          queryClient.invalidateQueries({ queryKey: [table] });
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [table, queryClient]);
};
```

**Usage**: Call `useRealtimeInvalidation('expenses')` in the dashboard or expense list component. Any INSERT/UPDATE/DELETE on the `expenses` table will automatically invalidate the TanStack Query cache, triggering a refetch.

**Why not Broadcast?** Broadcast requires trigger setup in Postgres and Realtime Authorization policies. For a personal budget app, Postgres Changes is simpler and sufficient. Supabase docs note Broadcast scales better, but that's irrelevant at single-user scale.

**Key considerations**:
- Enable the `supabase_realtime` publication for your tables (see Supabase docs)
- Clean up channels on unmount (the `return` in `useEffect`)
- Don't subscribe to every table globally — only where real-time matters (dashboard)

### Sources
- [Supabase Realtime: Subscribing to Database Changes](https://supabase.com/docs/guides/realtime/subscribing-to-database-changes)
- [Supabase Realtime: Postgres Changes](https://supabase.com/docs/guides/realtime/postgres-changes)

---

## Summary of Recommendations

| Area | Choice | Bundle Impact |
|---|---|---|
| Charts | **Recharts** | ~117.5 kB gzip |
| Date Picker | **Native `<input type="date">`** | 0 kB |
| Google Sheets Import | **API Key (restricted)** | 0 kB (REST fetch) |
| Server State | **TanStack Query** | ~13 kB gzip |
| Client State | **React Context** (Zustand if needed) | 0–1.1 kB |
| Forms | **React Hook Form + Zod** | ~9 kB + ~3 kB gzip |
| Real-time | **Postgres Changes + Query Invalidation** | 0 kB (Supabase JS already included) |

**Total new bundle cost**: ~142.5 kB gzip (dominated by Recharts)

---

### Handoff To: @architect / @tech-lead
Technologies researched: 6 areas
Recommendations: Recharts, native date input, API Key import, TanStack Query + Zustand, React Hook Form + Zod, Postgres Changes pattern
Risks identified: Recharts bundle size (117.5 kB) is the largest cost — Chart.js is the fallback if this is unacceptable; Nivo maintenance concern (1 year since last publish, single maintainer)
Sources: npm, bundlephobia, Supabase docs, Google Sheets API docs