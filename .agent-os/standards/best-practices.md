# Development Best Practices

## Context

Global development guidelines for Agent OS projects.

<conditional-block context-check="core-principles">
IF this Core Principles section already read in current context:
  SKIP: Re-reading this section
  NOTE: "Using Core Principles already in context"
ELSE:
  READ: The following principles

## Core Principles

### Keep It Simple
- Implement code in the fewest lines possible
- Avoid over-engineering solutions
- Choose straightforward approaches over clever ones
- Prefer built-in Next.js and Cloudflare features

### Optimize for Readability
- Prioritize code clarity over micro-optimizations
- Write self-documenting code with clear variable names
- Add comments for "why" not "what"
- Use TypeScript for self-documenting types

### DRY (Don't Repeat Yourself)
- Extract repeated business logic to utility functions
- Extract repeated UI markup to reusable components
- Create shared hooks for common patterns
- Use Server Actions for repeated mutations

### File Structure
- Keep files focused on a single responsibility
- Group related functionality together
- Use consistent naming conventions
- Colocate related files (components, hooks, utils)
</conditional-block>

## OpenNext.js Cloudflare Specific

### Runtime Configuration
- **Use Node.js runtime** - Do NOT use edge runtime exports
- **Remove edge exports** - Delete any `export const runtime = "edge"`
- **Compatibility date** - Set to 2024-12-30 or later in wrangler.jsonc
- **Compatibility flags** - Always include nodejs_compat and global_fetch_strictly_public
- **Wrangler version** - Use 3.99.0 or later

### Development Setup
- **Initialize dev config** - Call initOpenNextCloudflareForDev() in next.config
- **Use next dev** - Standard Next.js dev server with binding support
- **Local bindings** - Configure .dev.vars for local development
- **Environment variables** - Use NEXTJS_ENV=development in .dev.vars

### Build & Deploy
- **Build command** - Use npx opennextjs-cloudflare build
- **Deploy command** - Use npx opennextjs-cloudflare deploy or wrangler deploy
- **Git ignore** - Add .open-next to .gitignore
- **Workers Builds** - Prefer Workers Builds for CI/CD over GitHub Actions
- **Reproducible deploys** - Use CD system for consistent deployments

### Cloudflare Bindings Access
- **Type bindings** - Declare binding types in env.d.ts or wrangler.jsonc
- **Access in routes** - Use process.env for environment variables
- **Access in Server Actions** - Import bindings from getRequestContext()
- **KV operations** - await env.KV.get/put/delete for key-value storage
- **D1 queries** - await env.DB.prepare().bind().all() for database
- **R2 operations** - await env.BUCKET.get/put/delete for object storage

### Caching Strategy
- **Incremental cache** - Use R2 incremental cache in open-next.config.ts
- **Static caching** - Configure cache headers in public/_headers
- **Dynamic caching** - Use Cloudflare Cache API for custom caching
- **Revalidation** - Use Next.js revalidate options with R2 cache

## Next.js Best Practices

### Server vs Client Components
- **Default to Server Components** - Most components should be Server Components
- **Use Client Components only when needed** for:
  - Event handlers (onClick, onChange, etc.)
  - Browser APIs (localStorage, window, etc.)
  - React hooks (useState, useEffect, etc.)
  - Interactive widgets and animations
- **Mark Client Components** with 'use client' directive at the top
- **Minimize Client Component boundaries** - push 'use client' as deep as possible
- **Compose Server and Client** - pass Server Components as children to Client Components

### Data Fetching
- **Fetch data on the server** in Server Components using async/await
- **Parallel data fetching** when routes need multiple independent requests
- **Cache strategically** using Next.js caching:
  - `{ cache: 'force-cache' }` - Cache indefinitely (default)
  - `{ cache: 'no-store' }` - Fresh data every request
  - `{ next: { revalidate: 3600 } }` - Revalidate after time
- **Use Server Actions** for mutations instead of API routes when possible
- **Validate all inputs** with Zod schemas before processing

### Routing & Layouts
- **Use App Router** - Leverage layouts, loading, and error states
- **Shared layouts** for common UI across routes
- **Loading states** with loading.tsx for better UX
- **Error boundaries** with error.tsx for graceful error handling
- **Route groups** (folders in parentheses) to organize without affecting URLs

### Performance Optimization
- **Dynamic imports** for large client-side components
- **Streaming with Suspense** to show UI progressively
- **Image optimization** always use next/image, never raw <img>
- **Font optimization** use next/font for zero layout shift
- **Bundle analysis** regularly check bundle size

### Security
- **Validate all inputs** on server-side (never trust client)
- **Use environment variables** for secrets, never hardcode
- **Implement CSP headers** via next.config.js
- **Sanitize user content** before rendering
- **Auth checks in middleware** for protected routes

### Type Safety
- **TypeScript strict mode** always enabled
- **No any types** - use unknown or proper types
- **Zod schemas** for runtime validation + type inference
- **Type API responses** using TypeScript interfaces
- **Type database queries** using Drizzle ORM

<conditional-block context-check="dependencies" task-condition="choosing-external-library">
IF current task involves choosing an external library:
  IF Dependencies section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using Dependencies guidelines already in context"
  ELSE:
    READ: The following guidelines
ELSE:
  SKIP: Dependencies section not relevant to current task

## Dependencies

### Choose Libraries Wisely
When adding third-party dependencies:
- **Node.js compatibility** - Must work with Cloudflare Workers Node.js runtime
- **Check bundle size** - Use bundlephobia.com
- **Verify maintenance** - Recent commits within last 6 months
- **Check popularity** - Active issue resolution, stars/downloads
- **Review documentation** - Clear docs and examples
- **TypeScript support** - Built-in types preferred

### Recommended Libraries
- **UI Components**: shadcn/ui (Radix UI)
- **Forms**: react-hook-form + Zod
- **State**: Zustand, Jotai (minimal use)
- **Animation**: Framer Motion, TailwindCSS
- **Date handling**: date-fns (tree-shakeable)
- **HTTP client**: fetch (native) or ky
- **Icons**: lucide-react
- **Styling**: TailwindCSS with clsx/cn utility
</conditional-block>

## Code Organization

### Folder Structure
```
app/                    # Next.js App Router
├── (auth)/            # Route group for auth pages
├── (dashboard)/       # Route group for dashboard
├── api/               # API routes
└── layout.tsx         # Root layout

components/            # Shared components
├── ui/               # shadcn/ui components
└── [feature]/        # Feature-specific components

lib/                   # Utilities and configuration
├── db/               # Database schema and client
├── actions/          # Server Actions
├── utils/            # Utility functions
└── validations/      # Zod schemas

hooks/                 # Custom React hooks
types/                 # TypeScript types
public/               # Static assets
├── _headers          # Cloudflare cache headers
wrangler.jsonc        # Cloudflare Workers config
open-next.config.ts   # OpenNext adapter config
.dev.vars             # Local env variables
```

### File Naming
- **Components**: PascalCase (UserProfile.tsx)
- **Utilities**: camelCase (formatDate.ts)
- **Server Actions**: camelCase with action suffix (createUserAction.ts)
- **Route files**: lowercase (page.tsx, layout.tsx, loading.tsx)
- **Types**: PascalCase with Type suffix (UserType.ts) or interfaces
