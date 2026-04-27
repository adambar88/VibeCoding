# Phase 1: Product Requirements

## Product Vision

A shared personal budget tracker for a couple who currently manage expenses in Google Sheets. The app replaces that spreadsheet with a real-time web app where both users see the same data instantly, enter expenses on the go, and get visual summaries of where their money goes — without losing any historical data.

**Target Users:** A husband and wife managing a shared household budget.

**Core Value Proposition:** Real-time shared expense tracking with visual insights, replacing a manual spreadsheet workflow.

---

## User Stories & Acceptance Criteria

### US-1: Sign Up / Sign In

**As a** household member, **I want to** sign in with my own account, **so that** my entries are attributed to me and the app is secure.

**Acceptance Criteria:**

- Given I am on the login page, when I enter valid credentials and submit, then I am redirected to the dashboard.
- Given I am on the login page, when I enter invalid credentials, then I see an error message and remain on the login page.
- Given I am not authenticated, when I try to access any app route, then I am redirected to the login page.

**Priority:** Must Have

### US-2: Sign Out

**As an** authenticated user, **I want to** sign out, **so that** my session is ended and the app is secure on shared devices.

**Acceptance Criteria:**

- Given I am signed in, when I click the sign-out button, then my session is terminated and I am redirected to the login page.

**Priority:** Must Have

### US-3: Add an Expense

**As a** household member, **I want to** record an expense with amount, category, date, and description, **so that** all spending is tracked in one place.

**Acceptance Criteria:**

- Given I am on the expense entry form, when I fill in amount, select a category, pick a date, optionally add a description, and submit, then the expense is saved and appears in the expense list.
- Given I am on the expense entry form, when I submit without an amount or category, then I see validation errors and the expense is not saved.
- Given I submit a new expense, when my partner is viewing the app, then they see the new expense appear in real time without refreshing.

**Priority:** Must Have

### US-4: Edit an Expense

**As a** household member, **I want to** edit a previously entered expense, **so that** I can correct mistakes.

**Acceptance Criteria:**

- Given I am viewing the expense list, when I click edit on an expense, change a field, and save, then the updated values are persisted and reflected in all views.

**Priority:** Must Have

### US-5: Delete an Expense

**As a** household member, **I want to** delete an expense, **so that** incorrect entries can be removed.

**Acceptance Criteria:**

- Given I am viewing the expense list, when I click delete on an expense and confirm, then the expense is permanently removed from the list and database.
- Given I click delete, when the confirmation dialog appears, then I can cancel to keep the expense.

**Priority:** Must Have

### US-6: View Expense List

**As a** household member, **I want to** see a list of all expenses, **so that** I can review our spending history.

**Acceptance Criteria:**

- Given I navigate to the expenses page, when the page loads, then I see expenses sorted by date (newest first) with amount, category, date, and description visible.

**Priority:** Must Have

### US-7: Filter & Search Expenses

**As a** household member, **I want to** filter expenses by category, date range, or search by description, **so that** I can find specific transactions quickly.

**Acceptance Criteria:**

- Given I am on the expense list, when I select a category filter, then only expenses in that category are shown.
- Given I am on the expense list, when I select a date range, then only expenses within that range are shown.
- Given I am on the expense list, when I type a search term, then only expenses whose description matches are shown.
- Given I have active filters, when I clear them, then all expenses are shown again.

**Priority:** Should Have

### US-8: View Dashboard with Spending Summaries

**As a** household member, **I want to** see a dashboard with charts showing spending by category and over time, **so that** I can understand our spending patterns at a glance.

**Acceptance Criteria:**

- Given I navigate to the dashboard, when the page loads, then I see total spending for the current month.
- Given I am on the dashboard, when I view the category breakdown chart, then each category shows its total and percentage of overall spend.
- Given I am on the dashboard, when I view the spending-over-time chart, then I see a monthly trend of total expenses.

**Priority:** Must Have

### US-9: Monthly Budget View

**As a** household member, **I want to** view expenses grouped by month, **so that** I can compare spending month over month.

**Acceptance Criteria:**

- Given I am on the dashboard or a budget view, when I select a specific month, then I see the total spend and category breakdown for that month only.

**Priority:** Should Have

### US-10: Manage Categories

**As a** household member, **I want to** view, add, edit, and delete expense categories, **so that** our tracking matches how we think about spending.

**Acceptance Criteria:**

- Given I navigate to the categories page, when the page loads, then I see all existing categories.
- Given I am on the categories page, when I add a new category with a unique name, then it appears in the list and is available in the expense form.
- Given I edit a category name, when I save, then all existing expenses retain the updated category.
- Given I try to delete a category that has expenses, when I confirm deletion, then I am prompted to reassign those expenses to another category or the deletion is blocked.

**Priority:** Must Have

### US-11: Import Data from Google Sheets

**As a** household member, **I want to** run a one-time import of our existing Google Sheets expense data, **so that** all historical data is available in the new app.

**Acceptance Criteria:**

- Given I am on the import page and authenticated, when I connect to our Google Sheet and trigger the import, then all rows are parsed, validated, and inserted into the database.
- Given some rows have invalid data (missing amount, unknown category), when the import completes, then I see a summary showing how many rows succeeded, how many failed, and the specific errors.
- Given the import has already been run, when I trigger it again, then duplicate entries are not created (idempotent import).

**Priority:** Must Have

### US-12: Real-Time Sync Between Users

**As a** household member, **I want** changes made by my partner to appear on my screen without refreshing, **so that** we always see the same data.

**Acceptance Criteria:**

- Given both users are viewing the app simultaneously, when one user adds, edits, or deletes an expense, then the other user's view updates within 2 seconds without a page refresh.

**Priority:** Must Have

### US-13: Weekly Budget View

**As a** household member, **I want to** see expenses grouped by week, **so that** I can track short-term spending habits.

**Acceptance Criteria:**

- Given I am on a budget view, when I select weekly grouping, then expenses are grouped by calendar week with totals per week.

**Priority:** Could Have

### US-14: Responsive Mobile Layout

**As a** household member, **I want to** use the app comfortably on my phone, **so that** I can log expenses on the go.

**Acceptance Criteria:**

- Given I open the app on a mobile device (viewport < 768px), when I navigate to any page, then the layout is usable without horizontal scrolling and touch targets are at least 44px.

**Priority:** Should Have

---

## MoSCoW Prioritization Summary

| Priority | Stories |
|---|---|
| **Must Have** | US-1, US-2, US-3, US-4, US-5, US-6, US-8, US-10, US-11, US-12 |
| **Should Have** | US-7, US-9, US-14 |
| **Could Have** | US-13 |
| **Won't Have** | Budget limits/alerts, receipt photo upload, export CSV/PDF, multi-currency, recurring expenses |

## MVP Scope

**In scope:** Auth, Expense CRUD, Category management, Dashboard with charts, Google Sheets import, Real-time sync.

**Stretch:** Filter/search (US-7), Monthly view (US-9), Responsive mobile (US-14).

**Out of scope:** Weekly view, budget limits, receipt uploads, export, multi-currency, recurring expenses.

## Non-Functional Requirements

| Requirement | Target |
|---|---|
| Performance | Dashboard loads < 2s on 3G. Expense list paginates at 1000+ rows. |
| Security | All routes require auth. RLS on all Supabase tables. No secrets in client bundle. |
| Accessibility | WCAG 2.1 AA — keyboard nav, color contrast, semantic HTML, ARIA labels. |
| Browser Support | Latest 2 versions of Chrome, Firefox, Safari, Edge. |
| Data Integrity | Import is idempotent. Expenses require amount > 0 and valid category FK. |
| Real-Time | Supabase Realtime subscriptions. Updates visible within 2 seconds. |
| Hosting | Static frontend deployable to any CDN. Supabase handles backend. |
