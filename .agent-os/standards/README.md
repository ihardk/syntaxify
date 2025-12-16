# Agent OS Standards - Next.js + OpenNext.js Cloudflare

## Overview

This Agent OS configuration is optimized for building Next.js applications deployed to Cloudflare Workers using OpenNext.js adapter.

## Tech Stack

### Core
- **Framework**: Next.js 14/15 (App Router)
- **Runtime**: Cloudflare Workers (Node.js runtime)
- **Deployment**: @opennextjs/cloudflare
- **Language**: TypeScript (strict mode)

### Frontend
- **UI**: React Server Components first
- **Styling**: TailwindCSS 4.0+
- **Components**: shadcn/ui (Radix UI)
- **Icons**: Lucide React

### Backend & Data
- **Database**: Cloudflare D1 (SQLite)
- **ORM**: Drizzle ORM
- **Caching**: Cloudflare KV + R2
- **Storage**: Cloudflare R2

### Development
- **Package Manager**: npm or pnpm
- **Testing**: Vitest + Playwright
- **Validation**: Zod schemas
- **Forms**: React Hook Form

## Quick Start

### Initial Setup

1. **Install Agent OS** (already done if you're reading this)
   ```bash
   curl -sSL https://raw.githubusercontent.com/buildermethods/agent-os/main/setup/base.sh | bash -s -- --claude-code
   ```

2. **Install in Project**
   ```bash
   cd your-nextjs-project
   ~/.agent-os/setup/project.sh
   ```

3. **Customize Standards**
   - Edit `~/.agent-os/standards/tech-stack.md` for your specific stack
   - Modify `~/.agent-os/standards/best-practices.md` for team conventions
   - Update `~/.agent-os/standards/code-style/` for code style preferences

### Project Setup

1. **Install OpenNext Cloudflare**
   ```bash
   npm install @opennextjs/cloudflare@latest
   npm install --save-dev wrangler@latest
   ```

2. **Configure wrangler.jsonc**
   ```jsonc
   {
     "name": "my-app",
     "main": ".open-next/worker.js",
     "compatibility_date": "2024-12-30",
     "compatibility_flags": ["nodejs_compat"],
     "assets": { "directory": ".open-next/assets" }
   }
   ```

3. **Update next.config.ts**
   ```typescript
   import { initOpenNextCloudflareForDev } from '@opennextjs/cloudflare';
   initOpenNextCloudflareForDev();
   ```

4. **Add to package.json**
   ```json
   {
     "scripts": {
       "dev": "next dev",
       "build": "opennextjs-cloudflare build",
       "deploy": "opennextjs-cloudflare deploy"
     }
   }
   ```

See `deployment.md` for complete setup instructions.

## File Structure

```
~/.agent-os/
├── standards/
│   ├── tech-stack.md           # Core technology choices
│   ├── best-practices.md       # Development guidelines
│   ├── deployment.md           # Deployment procedures
│   ├── code-style.md           # General code style
│   └── code-style/
│       ├── typescript-style.md # TypeScript/React style guide
│       ├── html-style.md       # HTML formatting
│       └── css-style.md        # CSS/Tailwind style
├── instructions/               # Workflow instructions
│   ├── core/                  # Core workflows
│   └── meta/                  # Meta instructions
├── commands/                   # Slash command templates
└── config.yml                  # Agent OS configuration
```

## Key Features

### OpenNext.js Cloudflare Integration
- Full Next.js 14/15 feature support
- Node.js runtime (not edge)
- Cloudflare bindings (KV, D1, R2)
- Automatic edge distribution
- Preview deployments

### Development Practices
- Server Components first
- TypeScript strict mode
- Zod validation
- Server Actions for mutations
- Colocated tests

### Cloudflare Features
- D1 for SQL database
- KV for key-value storage
- R2 for file storage
- Image optimization
- Global CDN

## Standards Reference

### Tech Stack (`tech-stack.md`)
Defines the default technology choices:
- Framework versions
- Database and ORM
- UI and styling libraries
- Deployment configuration
- Cloudflare bindings setup

### Best Practices (`best-practices.md`)
Guidelines for:
- OpenNext.js specific practices
- Server vs Client Components
- Data fetching patterns
- Performance optimization
- Security practices
- Code organization

### Code Style (`code-style/`)
Style guides for:
- **TypeScript**: Types, interfaces, naming, patterns
- **React**: Components, hooks, Server Components
- **HTML**: Structure and formatting
- **CSS**: TailwindCSS conventions

### Deployment (`deployment.md`)
Complete deployment guide:
- Initial setup steps
- Cloudflare configuration
- Environment variables
- CI/CD setup
- Monitoring and troubleshooting

## Customization

### Per-Project Customization

Each project can override global standards:

```
your-project/
├── .agent-os/
│   ├── product/
│   │   ├── tech-stack.md      # Override global tech stack
│   │   └── requirements.md     # Project requirements
│   └── specs/                  # Feature specifications
```

### Global Customization

Edit files in `~/.agent-os/standards/` to change defaults for all projects.

## Workflows

Agent OS provides structured workflows:

- `/plan-product` - Plan product features
- `/create-spec` - Create feature specifications
- `/create-tasks` - Break down tasks
- `/execute-tasks` - Execute task list
- `/analyze-product` - Analyze existing product

## Best Practices Summary

### ✅ DO
- Default to Server Components
- Use TypeScript strict mode
- Validate with Zod schemas
- Use Drizzle ORM for type-safe queries
- Implement proper error boundaries
- Use next/image for all images
- Configure R2 incremental cache
- Set compatibility_date to 2024-12-30+
- Use Node.js runtime (not edge)

### ❌ DON'T
- Use `export const runtime = "edge"`
- Use `any` type in TypeScript
- Trust client-side validation
- Use raw `<img>` tags
- Hardcode secrets in code
- Commit `.dev.vars` file
- Skip wrangler version check

## Additional Resources

### Documentation
- [Next.js Docs](https://nextjs.org/docs)
- [OpenNext Cloudflare](https://opennext.js.org/cloudflare)
- [Cloudflare Workers](https://developers.cloudflare.com/workers/)
- [Drizzle ORM](https://orm.drizzle.team/)
- [shadcn/ui](https://ui.shadcn.com/)
- [Agent OS](https://buildermethods.com/agent-os)

### Community
- [Agent OS Discord](https://discord.gg/buildermethods)
- [OpenNext GitHub](https://github.com/opennextjs/opennextjs-cloudflare)

## Troubleshooting

### Common Issues

**Build fails with compatibility error**
- Ensure wrangler is 3.99.0+
- Check compatibility_date is 2024-12-30+
- Verify nodejs_compat flag is set

**Bindings not accessible**
- Check wrangler.jsonc configuration
- Verify binding IDs match Cloudflare Dashboard
- Ensure proper TypeScript types in env.d.ts

**Development server issues**
- Verify initOpenNextCloudflareForDev() is called
- Check .dev.vars exists with NEXTJS_ENV=development
- Ensure @opennextjs/cloudflare is latest version

For more troubleshooting, see `deployment.md` or visit [OpenNext Troubleshooting](https://opennext.js.org/cloudflare/troubleshooting).

## Updates

To update Agent OS standards:

```bash
cd ~/.agent-os
git pull origin main
```

Or reinstall:

```bash
curl -sSL https://raw.githubusercontent.com/buildermethods/agent-os/main/setup/base.sh | bash -s -- --claude-code
```

## Contributing

To customize these standards:

1. Edit files in `~/.agent-os/standards/`
2. Share improvements with your team
3. Consider contributing back to Agent OS

## License

These standards are part of Agent OS and follow the same license.

---

**Built with [Agent OS](https://buildermethods.com/agent-os)** 🚀
