# Deployment Guide

## Context

Deployment guidelines for Next.js + OpenNext.js Cloudflare projects.

## Initial Setup

### 1. Install Dependencies
```bash
npm install @opennextjs/cloudflare@latest
npm install --save-dev wrangler@latest
```

### 2. Configure Wrangler
Create `wrangler.jsonc` in project root:

```jsonc
{
  "name": "my-nextjs-app",
  "main": ".open-next/worker.js",
  "compatibility_date": "2024-12-30",
  "compatibility_flags": [
    "nodejs_compat",
    "global_fetch_strictly_public"
  ],
  "assets": {
    "directory": ".open-next/assets",
    "binding": "ASSETS"
  },
  // Add bindings as needed
  "kv_namespaces": [
    {
      "binding": "KV",
      "id": "your-kv-namespace-id",
      "preview_id": "your-preview-kv-id"
    }
  ],
  "d1_databases": [
    {
      "binding": "DB",
      "database_name": "your-database",
      "database_id": "your-database-id"
    }
  ],
  "r2_buckets": [
    {
      "binding": "BUCKET",
      "bucket_name": "your-bucket"
    }
  ]
}
```

### 3. Configure Next.js for Development
Update `next.config.ts`:

```typescript
import type { NextConfig } from 'next';
import { initOpenNextCloudflareForDev } from '@opennextjs/cloudflare';

const nextConfig: NextConfig = {
  // Your Next.js config
};

// Initialize OpenNext for development
if (process.env.NODE_ENV === 'development') {
  initOpenNextCloudflareForDev();
}

export default nextConfig;
```

### 4. Create OpenNext Config (Optional)
Create `open-next.config.ts` for advanced configuration:

```typescript
import { defineCloudflareConfig } from '@opennextjs/cloudflare';
import r2IncrementalCache from '@opennextjs/cloudflare/overrides/incremental-cache/r2-incremental-cache';

export default defineCloudflareConfig({
  // Use R2 for incremental cache
  incrementalCache: r2IncrementalCache,
});
```

### 5. Local Environment Variables
Create `.dev.vars` for local development:

```env
NEXTJS_ENV=development
DATABASE_URL=your-local-db-url
API_KEY=your-dev-api-key
```

### 6. Update package.json Scripts
```json
{
  "scripts": {
    "dev": "next dev",
    "build": "opennextjs-cloudflare build",
    "deploy": "opennextjs-cloudflare deploy",
    "preview": "wrangler dev",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  }
}
```

### 7. Update .gitignore
```
.open-next
.wrangler
.dev.vars
```

## Cloudflare Setup

### Create Bindings

#### KV Namespace
```bash
# Production
wrangler kv:namespace create "KV"

# Preview (for development)
wrangler kv:namespace create "KV" --preview
```

#### D1 Database
```bash
# Create database
wrangler d1 create your-database

# Run migrations
wrangler d1 migrations apply your-database
```

#### R2 Bucket
```bash
# Create bucket
wrangler r2 bucket create your-bucket
```

### Environment Variables
```bash
# Set production secrets
wrangler secret put API_KEY
wrangler secret put DATABASE_URL

# Set environment variables (non-sensitive)
# Add to wrangler.jsonc under vars:
{
  "vars": {
    "PUBLIC_API_URL": "https://api.example.com",
    "ENVIRONMENT": "production"
  }
}
```

## Deployment

### Manual Deployment
```bash
# Build the application
npm run build

# Deploy to Cloudflare
npm run deploy
# or
wrangler deploy
```

### Automatic Deployment (Recommended)

#### Option 1: Cloudflare Workers Builds (Recommended)
1. Connect your GitHub/GitLab repository to Cloudflare
2. Configure build settings in Cloudflare Dashboard:
   - Build command: `npm run build`
   - Deploy command: `wrangler deploy`
3. Cloudflare will automatically build and deploy on push to main

#### Option 2: GitHub Actions
Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Cloudflare

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Deploy to Cloudflare Workers
        uses: cloudflare/wrangler-action@v3
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          command: deploy
```

## Preview Deployments

### For Pull Requests
Cloudflare automatically creates preview deployments for PRs when using Workers Builds.

### Manual Preview
```bash
# Deploy to preview environment
wrangler deploy --env preview
```

## Monitoring

### View Logs
```bash
# Tail production logs
wrangler tail

# Tail with filtering
wrangler tail --format pretty
```

### Analytics
- View analytics in Cloudflare Dashboard
- Access Workers Analytics for performance metrics
- Set up custom analytics with Workers Analytics Engine

## Troubleshooting

### Common Issues

#### Build Fails
- Ensure wrangler version is 3.99.0+
- Check compatibility_date is 2024-12-30 or later
- Verify nodejs_compat flag is set

#### Runtime Errors
- Check logs with `wrangler tail`
- Verify all bindings are properly configured
- Ensure environment variables are set

#### Bindings Not Working
- Verify binding names match in wrangler.jsonc and code
- Check binding IDs are correct
- Ensure bindings are created in Cloudflare Dashboard

### Edge Runtime Issues
- Remove any `export const runtime = "edge"` declarations
- Use Node.js runtime instead of edge runtime
- Check for incompatible Node.js APIs

## Best Practices

### Pre-deployment Checklist
- [ ] Run type checking: `npm run type-check`
- [ ] Run linting: `npm run lint`
- [ ] Run tests: `npm test`
- [ ] Test build locally: `npm run build`
- [ ] Test preview deployment: `wrangler dev`
- [ ] Verify environment variables are set
- [ ] Check bindings configuration
- [ ] Review security headers in next.config.ts

### Performance Optimization
- Enable R2 incremental cache for optimal performance
- Configure appropriate cache headers in `public/_headers`
- Use Cloudflare Image Resizing for images
- Implement proper revalidation strategies
- Monitor bundle size and optimize imports

### Security
- Never commit `.dev.vars` or secrets
- Use `wrangler secret` for sensitive data
- Implement rate limiting for API routes
- Set up CSP headers in next.config.ts
- Enable CORS properly for API endpoints
- Validate all user inputs on the server

### Monitoring & Alerts
- Set up Cloudflare alerts for:
  - High error rates
  - Slow response times
  - Increased traffic
- Monitor Worker metrics regularly
- Set up Sentry or similar for error tracking
- Track Web Vitals for performance
