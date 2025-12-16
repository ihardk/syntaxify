# Tech Stack

## Context

Global tech stack defaults for Agent OS projects, overridable in project-specific `.agent-os/product/tech-stack.md`.

## Core Stack

- App Framework: Next.js 14/15 (App Router)
- Deployment Adapter: @opennextjs/cloudflare
- Runtime: Cloudflare Workers (Node.js runtime)
- Language: TypeScript 5.0+ (strict mode)
- Package Manager: npm or pnpm
- Node Version: 20 LTS+

## Frontend

- UI Framework: React 18/19 (Server Components first)
- CSS Framework: TailwindCSS 4.0+
- CSS Approach: Utility-first with component composition
- UI Components: shadcn/ui (Radix UI based, copy-paste)
- Font Loading: next/font with Google Fonts (automatic optimization)
- Icons: Lucide React components
- Image Optimization: next/image with Cloudflare Image Resizing
- Animations: Framer Motion or TailwindCSS

## Backend & Data

- API: Next.js Route Handlers (app/api) via Node.js runtime
- Database: Cloudflare D1 (SQLite) for SQL, or Turso for distributed
- ORM: Drizzle ORM (edge/Node.js compatible, type-safe)
- Schema Migration: Drizzle Kit with wrangler d1 migrations
- Caching: Cloudflare KV for key-value, R2 for incremental cache
- Session Storage: Cloudflare KV or D1
- Real-time: Cloudflare Durable Objects (when needed)

## Cloudflare Bindings

- KV Namespace: Session, cache, rate limiting
- D1 Database: Primary data storage
- R2 Bucket: File uploads, incremental cache
- Environment Variables: Per-environment config
- Secrets: Sensitive data via wrangler secret

## Storage & CDN

- Asset Storage: Cloudflare R2 (S3-compatible)
- Static Assets: .open-next/assets served by Cloudflare Workers
- CDN: Cloudflare (built-in, automatic global distribution)
- Image Optimization: Cloudflare Image Resizing
- Asset Caching: Configured via public/_headers

## Authentication

- Auth Framework: NextAuth.js v5 (Auth.js) or Lucia
- Session Strategy: JWT with Cloudflare KV or database sessions
- OAuth Providers: Configure in NextAuth.js
- Password Hashing: bcrypt or @node-rs/argon2

## State Management

- Server State: React Server Components (default)
- Client State: React hooks (useState, useReducer)
- Global State: Zustand or Jotai (minimal use)
- Form State: React Hook Form with Zod validation
- Data Validation: Zod schemas

## Development & Testing

- Type Checking: TypeScript strict mode
- Linting: ESLint with Next.js config
- Formatting: Prettier
- Testing Framework: Vitest for units, Playwright for E2E
- Test Location: Colocate tests with components
- API Testing: MSW (Mock Service Worker)
- Local Dev: next dev with OpenNext Cloudflare dev integration

## Deployment & CI/CD

- Primary Hosting: Cloudflare Workers via @opennextjs/cloudflare
- Build Command: npx opennextjs-cloudflare build
- Deploy Command: npx opennextjs-cloudflare deploy (or wrangler deploy)
- Preview Deployments: Automatic on PR via Workers Builds
- CI/CD Platform: Cloudflare Workers Builds (preferred) or GitHub Actions
- CI/CD Trigger: Push to main/preview branches
- Tests: Run on PR and before deployment
- Production Environment: main branch
- Staging Environment: preview/staging branch
- Wrangler Version: 3.99.0+
- Compatibility Date: 2024-12-30 or later
- Compatibility Flags: nodejs_compat, global_fetch_strictly_public

## Configuration Files

- wrangler.jsonc: Worker config, bindings, compatibility
- open-next.config.ts: OpenNext adapter config (optional)
- .dev.vars: Local development environment variables
- .gitignore: Include .open-next build output

## Monitoring & Analytics

- Error Tracking: Sentry or Cloudflare Workers Analytics
- Analytics: Custom analytics via Workers Analytics Engine
- Logging: console with structured logs, Cloudflare Logpush
- Performance: Web Vitals monitoring, Workers metrics

## Edge Computing

- Middleware: Next.js Middleware on Cloudflare Workers
- Compute: Cloudflare Workers (Node.js runtime)
- Geolocation: Request cf object for geo data
- Rate Limiting: Cloudflare KV or Durable Objects
- Caching: Cloudflare Cache API, R2 incremental cache
