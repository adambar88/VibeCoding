# Phase 9: Implementation

## Features Implemented

### Sprint 1 — MVP Core

- **Auth**: Login/SignUp page, AuthProvider context, useAuth hook, ProtectedRoute
- **Categories**: CRUD service, CategoryForm, CategoryList, CategoriesPage
- **Expenses**: CRUD service with category joins, ExpenseForm, ExpenseList, ExpenseRow, ExpensesPage

### Sprint 2 — MVP Complete

- **Dashboard**: SummaryCards, SpendingByCategory (Recharts PieChart), SpendingOverTime (Recharts BarChart), month navigation, DashboardPage
- **Google Sheets Import**: sheetsApi (REST fetch), sheetParser (row validation + mapping), useSheetImport (upsert with duplicate detection), ImportForm, ImportResults, ImportPage
- **Real-time Sync**: useRealtimeInvalidation (generic Supabase realtime → TanStack Query), useRealtimeExpenses

### Shared Components

- Layout (sidebar nav + header with sign out)
- ProtectedRoute, LoadingSpinner, ConfirmDialog

## Files Created

```
src/shared/components/Layout.tsx
src/shared/components/ProtectedRoute.tsx
src/shared/components/LoadingSpinner.tsx
src/shared/components/ConfirmDialog.tsx
src/shared/hooks/useRealtimeInvalidation.ts
src/shared/lib/queryClient.ts
src/shared/types/models.ts
src/features/auth/context/AuthProvider.tsx
src/features/auth/hooks/useAuth.ts
src/features/auth/components/LoginForm.tsx
src/features/auth/pages/LoginPage.tsx
src/features/categories/hooks/useCategories.ts
src/features/categories/hooks/useCategoryMutations.ts
src/features/categories/components/CategoryForm.tsx
src/features/categories/components/CategoryList.tsx
src/features/categories/pages/CategoriesPage.tsx
src/features/expenses/hooks/useExpenses.ts
src/features/expenses/hooks/useExpenseMutations.ts
src/features/expenses/hooks/useRealtimeExpenses.ts
src/features/expenses/components/ExpenseForm.tsx
src/features/expenses/components/ExpenseRow.tsx
src/features/expenses/components/ExpenseList.tsx
src/features/expenses/pages/ExpensesPage.tsx
src/features/dashboard/hooks/useDashboardData.ts
src/features/dashboard/components/SummaryCards.tsx
src/features/dashboard/components/SpendingByCategory.tsx
src/features/dashboard/components/SpendingOverTime.tsx
src/features/dashboard/pages/DashboardPage.tsx
src/features/import/lib/sheetsApi.ts
src/features/import/lib/sheetParser.ts
src/features/import/hooks/useSheetImport.ts
src/features/import/components/ImportForm.tsx
src/features/import/components/ImportResults.tsx
src/features/import/pages/ImportPage.tsx
src/App.tsx (rewritten)
```

## Build Status

✅ `pnpm build` passes (chunk size warning for Recharts — expected)

## Database

- SQL migrations in `supabase/migrations/001_initial_schema.sql`
- RLS policies for both tables
- Seed categories included
- Realtime enabled on both tables
