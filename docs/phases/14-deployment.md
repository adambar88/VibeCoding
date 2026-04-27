# Phase 14: Deployment

## Deployment Strategy

This is a static SPA (Vite build output) + Supabase managed backend. No custom server needed.

## Build

```bash
pnpm build
```

Output: `dist/` directory — deploy to any static host.

## Recommended Hosting Options

| Option | Cost | Complexity |
|---|---|---|
| **Vercel** | Free tier | Lowest — auto-deploys from Git |
| **Netlify** | Free tier | Low — auto-deploys from Git |
| **Cloudflare Pages** | Free tier | Low — fast global CDN |
| **GitHub Pages** | Free | Medium — needs SPA routing config |

## Environment Variables (Production)

Set these in your hosting provider's dashboard:
- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`
- `VITE_GOOGLE_SHEETS_API_KEY`

## Supabase Production Checklist

1. Enable email confirmation in Auth settings
2. Disable public sign-ups (invite users via admin API)
3. Restrict Google Sheets API key to production domain
4. Enable Supabase's built-in backups
5. Monitor RLS policies after any schema changes

## CI Pipeline (GitHub Actions)

```yaml
name: CI
on: [push, pull_request]
jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v4
        with:
          version: 10
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: pnpm
      - run: pnpm install --frozen-lockfile
      - run: pnpm lint
      - run: pnpm test
      - run: pnpm build
```

## Docker (Optional)

Not needed for this project since it's a static SPA deployed to a CDN with Supabase as the managed backend. Docker would only add complexity without benefit.

If needed later:
```dockerfile
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
```
