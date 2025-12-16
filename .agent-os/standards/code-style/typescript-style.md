# TypeScript Style Guide

## Context

TypeScript style rules for Next.js + OpenNext Cloudflare projects.

## General Rules

### Indentation
- Use 2 spaces for indentation (never tabs)
- Maintain consistent indentation throughout files

### Naming Conventions
- **Variables and Functions**: camelCase (e.g., `userData`, `fetchUser`)
- **Types and Interfaces**: PascalCase (e.g., `UserProfile`, `ApiResponse`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `MAX_RETRIES`, `API_URL`)
- **Private properties**: prefix with underscore `_privateField` (optional)
- **Boolean variables**: prefix with `is`, `has`, `should` (e.g., `isLoading`, `hasError`)

### Type vs Interface
- **Use `type`** for unions, intersections, primitives, tuples
- **Use `interface`** for object shapes, especially when extending
- **Be consistent** within a file or module

```typescript
// Prefer type for unions and complex types
type Status = 'pending' | 'success' | 'error';
type User = { name: string } & { age: number };

// Prefer interface for object shapes
interface UserProfile {
  id: string;
  name: string;
  email: string;
}

// Interface for extension
interface AdminProfile extends UserProfile {
  permissions: string[];
}
```

## TypeScript Specific

### Strict Mode
- Always enable strict mode in tsconfig.json
- Never use `any` - use `unknown` or proper types
- Avoid type assertions (`as`) unless absolutely necessary

### Type Annotations
- Annotate function parameters always
- Annotate return types for public functions
- Let TypeScript infer types for variables when obvious

```typescript
// Good - explicit parameters and return type
function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// Good - inferred variable type
const total = calculateTotal(items);

// Avoid - unnecessary annotation
const total: number = calculateTotal(items);
```

### Null and Undefined
- Use `null` for intentional absence
- Use `undefined` for uninitialized or optional values
- Use optional chaining `?.` and nullish coalescing `??`

```typescript
// Good
const username = user?.name ?? 'Anonymous';

// Avoid
const username = user && user.name ? user.name : 'Anonymous';
```

### Generics
- Use descriptive generic names for complex types
- Use `T`, `U`, `V` for simple, single-parameter generics

```typescript
// Simple generic
function first<T>(arr: T[]): T | undefined {
  return arr[0];
}

// Descriptive generic
function mapById<TItem extends { id: string }>(items: TItem[]): Map<string, TItem> {
  return new Map(items.map(item => [item.id, item]));
}
```

## React/Next.js Specific

### Component Types
- Use `React.FC` sparingly (prefer explicit typing)
- Type props interfaces explicitly
- Use `PropsWithChildren` for components accepting children

```typescript
// Preferred approach
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
}

export function Button({ label, onClick, variant = 'primary' }: ButtonProps) {
  return <button onClick={onClick}>{label}</button>;
}

// With children
interface CardProps {
  title: string;
  children: React.ReactNode;
}

export function Card({ title, children }: CardProps) {
  return (
    <div>
      <h2>{title}</h2>
      {children}
    </div>
  );
}
```

### Server Components
- Type async Server Components properly
- Use proper return types for Server Actions

```typescript
// Server Component
interface UserPageProps {
  params: { id: string };
  searchParams: { tab?: string };
}

export default async function UserPage({ params, searchParams }: UserPageProps) {
  const user = await fetchUser(params.id);
  return <div>{user.name}</div>;
}

// Server Action
async function createUser(data: FormData) {
  'use server';

  const schema = z.object({
    name: z.string(),
    email: z.string().email(),
  });

  const parsed = schema.parse({
    name: data.get('name'),
    email: data.get('email'),
  });

  // ... create user
}
```

### Hooks
- Type custom hooks properly
- Infer return types when possible

```typescript
// Simple hook
function useLocalStorage<T>(key: string, initialValue: T) {
  const [value, setValue] = useState<T>(() => {
    const stored = localStorage.getItem(key);
    return stored ? JSON.parse(stored) : initialValue;
  });

  return [value, setValue] as const;
}

// Complex hook with explicit return
interface UseApiResult<T> {
  data: T | null;
  loading: boolean;
  error: Error | null;
  refetch: () => Promise<void>;
}

function useApi<T>(url: string): UseApiResult<T> {
  // ... implementation
}
```

## Zod Integration

### Schema Definition
- Define Zod schemas for all external data
- Export both schema and inferred type

```typescript
import { z } from 'zod';

// Schema definition
export const userSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1),
  email: z.string().email(),
  role: z.enum(['user', 'admin']),
  createdAt: z.coerce.date(),
});

// Type inference
export type User = z.infer<typeof userSchema>;

// Usage
function validateUser(data: unknown): User {
  return userSchema.parse(data);
}
```

### Form Validation
- Use Zod with react-hook-form for forms

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';

const formSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

type FormData = z.infer<typeof formSchema>;

function LoginForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(formSchema),
  });

  // ... form implementation
}
```

## Cloudflare Bindings

### Type Environment
- Type Cloudflare bindings in env.d.ts

```typescript
// env.d.ts
declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: 'development' | 'production' | 'test';
      DATABASE_URL: string;
      API_KEY: string;
    }
  }
}

// Cloudflare bindings
interface CloudflareEnv {
  DB: D1Database;
  KV: KVNamespace;
  BUCKET: R2Bucket;
}

export {};
```

### Using Bindings
- Access typed bindings in route handlers and Server Actions

```typescript
import { getRequestContext } from '@opennextjs/cloudflare';

async function getUserFromDb(id: string) {
  const { env } = await getRequestContext();

  const result = await env.DB
    .prepare('SELECT * FROM users WHERE id = ?')
    .bind(id)
    .first<User>();

  return result;
}
```

## Import/Export

### Import Order
1. External libraries
2. Absolute imports (from aliases)
3. Relative imports
4. Type imports (separate)

```typescript
// External
import { useState } from 'react';
import { z } from 'zod';

// Absolute
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';

// Relative
import { UserCard } from './UserCard';

// Types
import type { User } from '@/types';
```

### Named vs Default Exports
- **Prefer named exports** for better refactoring
- **Use default exports** for page components (Next.js requirement)

```typescript
// Prefer named exports
export function Button() { }
export function Input() { }

// Use default for pages
export default function HomePage() { }
```

## Error Handling

### Type Errors
- Create custom error types
- Use discriminated unions for error states

```typescript
// Custom error
class ApiError extends Error {
  constructor(
    message: string,
    public statusCode: number,
    public code: string
  ) {
    super(message);
    this.name = 'ApiError';
  }
}

// Discriminated union
type Result<T> =
  | { success: true; data: T }
  | { success: false; error: string };

function parseData(input: unknown): Result<User> {
  try {
    const data = userSchema.parse(input);
    return { success: true, data };
  } catch (error) {
    return { success: false, error: 'Invalid data' };
  }
}
```

## Best Practices

### Utility Types
- Use built-in utility types

```typescript
// Pick specific properties
type UserPreview = Pick<User, 'id' | 'name'>;

// Omit properties
type UserWithoutPassword = Omit<User, 'password'>;

// Make all properties optional
type PartialUser = Partial<User>;

// Make all properties required
type RequiredUser = Required<User>;
```

### Type Guards
- Use type guards for narrowing

```typescript
function isUser(obj: unknown): obj is User {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    'id' in obj &&
    'name' in obj
  );
}

// Usage
if (isUser(data)) {
  console.log(data.name); // TypeScript knows this is User
}
```

### Const Assertions
- Use `as const` for literal types

```typescript
// Without const assertion
const colors = ['red', 'blue', 'green']; // string[]

// With const assertion
const colors = ['red', 'blue', 'green'] as const; // readonly ['red', 'blue', 'green']
type Color = typeof colors[number]; // 'red' | 'blue' | 'green'
```
