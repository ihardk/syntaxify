# Quick Reference - Next.js + OpenNext Cloudflare

## Essential Commands

```bash
# Development
npm run dev                          # Start Next.js dev server
wrangler dev                         # Preview with Cloudflare Workers

# Building & Deployment
npm run build                        # Build with OpenNext
npm run deploy                       # Deploy to Cloudflare
wrangler deploy                      # Alternative deploy

# Database (D1)
wrangler d1 create <db-name>        # Create database
wrangler d1 migrations apply <db>   # Run migrations
wrangler d1 execute <db> --command  # Execute SQL

# KV Namespace
wrangler kv:namespace create <name> # Create KV namespace
wrangler kv:key get <key>           # Get value
wrangler kv:key put <key> <value>   # Set value

# R2 Bucket
wrangler r2 bucket create <name>    # Create bucket
wrangler r2 object get <bucket/key> # Get object

# Secrets
wrangler secret put <SECRET_NAME>   # Add secret
wrangler secret list                # List secrets

# Logs & Debugging
wrangler tail                        # Tail production logs
wrangler tail --format pretty       # Pretty logs
```

## Required Configuration Files

### `wrangler.jsonc`
```jsonc
{
  "name": "my-app",
  "main": ".open-next/worker.js",
  "compatibility_date": "2024-12-30",
  "compatibility_flags": ["nodejs_compat"],
  "assets": { "directory": ".open-next/assets" }
}
```

### `next.config.ts`
```typescript
import { initOpenNextCloudflareForDev } from '@opennextjs/cloudflare';
initOpenNextCloudflareForDev();
export default { /* config */ };
```

### `.dev.vars`
```env
NEXTJS_ENV=development
```

### `.gitignore` additions
```
.open-next
.wrangler
.dev.vars
```

## Key Patterns

### Server Component (default)
```typescript
// app/page.tsx
export default async function Page() {
  const data = await fetchData();
  return <div>{data}</div>;
}
```

### Client Component
```typescript
'use client';

export function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

### Server Action
```typescript
'use server';

export async function createUser(formData: FormData) {
  const data = userSchema.parse(Object.fromEntries(formData));
  // ... create user
  revalidatePath('/users');
}
```

### API Route
```typescript
// app/api/users/route.ts
export async function GET() {
  const users = await db.query.users.findMany();
  return Response.json(users);
}
```

### Access Cloudflare Bindings
```typescript
import { getRequestContext } from '@opennextjs/cloudflare';

export async function getUser(id: string) {
  const { env } = await getRequestContext();
  return await env.DB.prepare('SELECT * FROM users WHERE id = ?').bind(id).first();
}
```

### Zod Validation
```typescript
const schema = z.object({
  email: z.string().email(),
  age: z.number().min(18),
});

const result = schema.safeParse(data);
if (!result.success) {
  return { error: result.error };
}
```

### Drizzle Query
```typescript
import { db } from '@/lib/db';
import { users } from '@/lib/db/schema';

// Select
const allUsers = await db.select().from(users);

// Insert
await db.insert(users).values({ name: 'John', email: 'john@example.com' });

// Update
await db.update(users).set({ name: 'Jane' }).where(eq(users.id, 1));

// Delete
await db.delete(users).where(eq(users.id, 1));
```

## Common Gotchas

### ❌ Don't Use Edge Runtime
```typescript
// DON'T
export const runtime = 'edge';
```

### ✅ Use Node.js Runtime (default)
```typescript
// Just don't export runtime - Node.js is default
```

### ❌ Don't Use Client-Only Features in Server Components
```typescript
// DON'T in Server Component
const [state, setState] = useState();
useEffect(() => {});
onClick={handler}
```

### ✅ Mark Client Components Explicitly
```typescript
'use client';  // Add at top of file

export function Interactive() {
  const [state, setState] = useState();
  // Now it works!
}
```

### ❌ Don't Access process.env in Client Components
```typescript
'use client';

// DON'T - undefined in client
const apiUrl = process.env.API_URL;
```

### ✅ Pass Data from Server to Client
```typescript
// Server Component
export default async function Page() {
  const apiUrl = process.env.API_URL;
  return <ClientComponent apiUrl={apiUrl} />;
}
```

## Project Structure

```
├── app/
│   ├── (auth)/              # Route group
│   │   ├── login/
│   │   │   └── page.tsx
│   │   └── layout.tsx
│   ├── api/                 # API routes
│   │   └── users/
│   │       └── route.ts
│   ├── layout.tsx           # Root layout
│   └── page.tsx             # Home page
├── components/
│   ├── ui/                  # shadcn components
│   └── shared/              # Shared components
├── lib/
│   ├── db/
│   │   ├── schema.ts        # Drizzle schema
│   │   └── index.ts         # DB client
│   ├── actions/             # Server actions
│   ├── utils/               # Utilities
│   └── validations/         # Zod schemas
├── types/
│   └── index.ts
├── public/
│   └── _headers             # Cache headers
├── wrangler.jsonc
├── open-next.config.ts
├── .dev.vars
└── next.config.ts
```

## TypeScript Quick Tips

```typescript
// Type component props
interface Props {
  title: string;
  children: React.ReactNode;
}

// Infer types from Zod
const schema = z.object({ name: z.string() });
type Data = z.infer<typeof schema>;

// Type Cloudflare bindings (env.d.ts)
interface CloudflareEnv {
  DB: D1Database;
  KV: KVNamespace;
  BUCKET: R2Bucket;
}

// Type guards
function isError(e: unknown): e is Error {
  return e instanceof Error;
}

// Utility types
type UserPreview = Pick<User, 'id' | 'name'>;
type PartialUser = Partial<User>;
```

## Performance Checklist

- [ ] Use next/image for all images
- [ ] Enable R2 incremental cache
- [ ] Configure cache headers in public/_headers
- [ ] Use proper revalidate strategies
- [ ] Minimize client-side JavaScript
- [ ] Use Server Components by default
- [ ] Implement Suspense boundaries
- [ ] Enable streaming responses
- [ ] Optimize bundle size (analyze regularly)

## Security Checklist

- [ ] Validate all inputs with Zod
- [ ] Use wrangler secret for sensitive data
- [ ] Never commit .dev.vars
- [ ] Implement rate limiting
- [ ] Set CSP headers
- [ ] Sanitize user content
- [ ] Use middleware for auth checks
- [ ] Enable CORS properly for APIs
- [ ] Use HTTPS only (automatic with Cloudflare)

## Deployment Checklist

- [ ] npm run type-check (no errors)
- [ ] npm run lint (no errors)
- [ ] npm test (all pass)
- [ ] npm run build (success)
- [ ] Verify environment variables set
- [ ] Check bindings configuration
- [ ] Test locally with wrangler dev
- [ ] Review security headers
- [ ] Set up monitoring/alerts

## Helpful Links

- [Next.js Docs](https://nextjs.org/docs)
- [OpenNext Cloudflare](https://opennext.js.org/cloudflare)
- [Cloudflare D1](https://developers.cloudflare.com/d1/)
- [Drizzle ORM](https://orm.drizzle.team/)
- [shadcn/ui](https://ui.shadcn.com/)
- [TailwindCSS](https://tailwindcss.com/)
- [Zod](https://zod.dev/)

---

💡 **Tip**: Keep this file open while developing for quick reference!
