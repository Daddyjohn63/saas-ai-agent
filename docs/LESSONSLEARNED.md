# Lessons Learned: Key Patterns & Code for Next Projects

> This document captures essential patterns, best practices, and reusable code from the SaaS AI Agent application. Each section includes production-ready examples with file references.

## Table of Contents

1. [Architecture & Tech Stack](#architecture--tech-stack)
2. [Module Organization](#module-organization)
3. [tRPC Setup & Patterns](#trpc-setup--patterns)
4. [Database with Drizzle ORM](#database-with-drizzle-orm)
5. [React Component Patterns](#react-component-patterns)
6. [State Management](#state-management)
7. [Form Handling](#form-handling)
8. [Authentication & Authorization](#authentication--authorization)
9. [Error Handling](#error-handling)
10. [Responsive Dialog Pattern](#responsive-dialog-pattern)
11. [Promise-Based UI Patterns](#promise-based-ui-patterns)
12. [Testing Patterns](#testing-patterns)
13. [Essential NPM Packages](#essential-npm-packages)

---

## Architecture & Tech Stack

### Core Stack Decision

```typescript
// Reference: docs/DOCUMENTATION.md

Next.js 15.3.2 (App Router)
├── TypeScript (Full type safety)
├── tRPC 11.x (End-to-end type safety)
├── Drizzle ORM (Type-safe database)
├── PostgreSQL (Database)
├── Better Auth (Authentication)
├── Shadcn/UI (Component library)
├── React Query (Server state)
├── Zod (Schema validation)
└── Inngest (Background jobs)
```

**Why this stack:**

- **tRPC**: Zero-cost abstraction for type-safe APIs
- **Drizzle**: Lightweight ORM with excellent TypeScript support
- **Shadcn/UI**: Copy-paste components (no package lock-in)
- **React Query**: Built into tRPC, automatic caching/invalidation

### Project Structure

```bash
src/
├── app/                    # Next.js App Router pages
│   ├── (auth)/            # Auth route group
│   ├── (dashboard)/       # Protected route group
│   └── api/               # API routes (tRPC, webhooks)
├── modules/               # Feature modules
│   ├── agents/
│   │   ├── hooks/         # Module-specific hooks
│   │   ├── schema.ts      # Zod schemas
│   │   ├── types.ts       # TypeScript types
│   │   ├── server/        # Server-side code
│   │   │   └── procedures.ts
│   │   └── ui/            # UI components
│   │       ├── components/
│   │       └── views/
│   ├── meetings/
│   └── premium/
├── components/            # Shared components
│   └── ui/               # Shadcn UI components
├── hooks/                # Shared hooks
├── lib/                  # Utilities & clients
├── db/                   # Database
│   ├── schema.ts
│   └── index.ts
└── trpc/                 # tRPC configuration
    ├── init.ts
    ├── client.tsx
    └── routers/
```

**Key Principle:** Organize by feature/module, not by file type.

---

## Module Organization

### Perfect Module Structure

Each feature gets its own module with consistent structure:

```typescript
// Reference: src/modules/agents/

modules/agents/
├── hooks/
│   └── use-agents-filters.ts     // Module-specific hooks
├── params.ts                      // URL param definitions (nuqs)
├── schema.ts                      // Zod validation schemas
├── types.ts                       // Inferred TypeScript types
├── server/
│   └── procedures.ts              // tRPC procedures
└── ui/
    ├── components/                // UI components
    │   ├── agent-form.tsx
    │   ├── agents-list-header.tsx
    │   └── columns.tsx            // Table columns
    └── views/                     // Page-level views
        ├── agents-view.tsx
        └── agent-id-view.tsx
```

### Schema Pattern

```typescript
// src/modules/agents/schema.ts
import { z } from 'zod';

// Insert schema (create)
export const agentsInsertSchema = z.object({
  name: z.string().min(1, { message: 'Name is required' }),
  instructions: z.string().min(1, { message: 'Instructions are required' })
});

// Update schema (extends insert with ID)
export const agentsUpdateSchema = agentsInsertSchema.extend({
  id: z.string().min(1, { message: 'Id is required' })
});
```

**Pattern:** Extend insert schema for updates instead of duplicating.

### Type Inference Pattern

```typescript
// src/modules/agents/types.ts
import { inferRouterOutputs } from '@trpc/server';
import type { AppRouter } from '@/trpc/routers/_app';

// Infer types from tRPC router outputs
export type AgentsGetMany =
  inferRouterOutputs<AppRouter>['agents']['getMany']['items'];
export type AgentGetOne = inferRouterOutputs<AppRouter>['agents']['getOne'];
```

**Key Benefit:** Types are automatically derived from your API, never get out of sync.

---

## tRPC Setup & Patterns

### tRPC Initialization

```typescript
// src/trpc/init.ts
import { initTRPC, TRPCError } from '@trpc/server';
import { auth } from '@/lib/auth';
import { headers } from 'next/headers';
import { cache } from 'react';

// Create context (runs on every request)
export const createTRPCContext = cache(async () => {
  return { userId: 'user_123' }; // Placeholder, never undefined
});

// Initialize tRPC
const t = initTRPC.create();

// Base exports
export const createTRPCRouter = t.router;
export const createCallerFactory = t.createCallerFactory;
export const baseProcedure = t.procedure;

// Protected procedure middleware
export const protectedProcedure = baseProcedure.use(async ({ ctx, next }) => {
  const session = await auth.api.getSession({
    headers: await headers()
  });

  if (!session) {
    throw new TRPCError({ code: 'UNAUTHORIZED', message: 'Unauthorized' });
  }

  return next({ ctx: { ...ctx, auth: session } });
});

// Premium feature gating
export const premiumProcedure = (entity: 'meetings' | 'agents') =>
  protectedProcedure.use(async ({ ctx, next }) => {
    const customer = await polarClient.customers.getStateExternal({
      externalId: ctx.auth.user.id
    });

    const [userAgents] = await db
      .select({ count: count(agents.id) })
      .from(agents)
      .where(eq(agents.userId, ctx.auth.user.id));

    const isPremium = customer.activeSubscriptions.length > 0;
    const isFreeAgentLimitReached = userAgents.count >= MAX_FREE_AGENTS;

    if (entity === 'agents' && isFreeAgentLimitReached && !isPremium) {
      throw new TRPCError({
        code: 'FORBIDDEN',
        message: 'You have reached the maximum number of free agents'
      });
    }

    return next({ ctx: { ...ctx, customer } });
  });
```

**Pattern:** Layer middleware for auth, then premium checks.

### tRPC Procedures Pattern

```typescript
// src/modules/agents/server/procedures.ts
import {
  createTRPCRouter,
  protectedProcedure,
  premiumProcedure
} from '@/trpc/init';
import { agentsInsertSchema, agentsUpdateSchema } from '../schema';

export const agentsRouter = createTRPCRouter({
  // Query: Fetch single item
  getOne: protectedProcedure
    .input(z.object({ id: z.string() }))
    .query(async ({ input, ctx }) => {
      const [agent] = await db
        .select({
          ...getTableColumns(agents),
          meetingCount: db.$count(meetings, eq(agents.id, meetings.agentId))
        })
        .from(agents)
        .where(
          and(
            eq(agents.id, input.id),
            eq(agents.userId, ctx.auth.user.id) // Row-level security
          )
        );

      if (!agent) {
        throw new TRPCError({ code: 'NOT_FOUND', message: 'Agent not found' });
      }

      return agent;
    }),

  // Query: Fetch paginated list with filters
  getMany: protectedProcedure
    .input(
      z.object({
        page: z.number().default(DEFAULT_PAGE),
        pageSize: z
          .number()
          .min(MIN_PAGE_SIZE)
          .max(MAX_PAGE_SIZE)
          .default(DEFAULT_PAGE_SIZE),
        search: z.string().nullish()
      })
    )
    .query(async ({ ctx, input }) => {
      const { search, page, pageSize } = input;

      const data = await db
        .select({
          ...getTableColumns(agents),
          meetingCount: db.$count(meetings, eq(agents.id, meetings.agentId))
        })
        .from(agents)
        .where(
          and(
            eq(agents.userId, ctx.auth.user.id),
            search ? ilike(agents.name, `%${search}%`) : undefined
          )
        )
        .orderBy(desc(agents.createdAt), desc(agents.id))
        .limit(pageSize)
        .offset((page - 1) * pageSize);

      const [total] = await db
        .select({ count: count() })
        .from(agents)
        .where(
          and(
            eq(agents.userId, ctx.auth.user.id),
            search ? ilike(agents.name, `%${search}%`) : undefined
          )
        );

      return {
        items: data,
        total: total.count,
        totalPages: Math.ceil(total.count / pageSize)
      };
    }),

  // Mutation: Create with premium gating
  create: premiumProcedure('agents')
    .input(agentsInsertSchema)
    .mutation(async ({ input, ctx }) => {
      const [createdAgent] = await db
        .insert(agents)
        .values({
          ...input,
          userId: ctx.auth.user.id
        })
        .returning();

      return createdAgent;
    }),

  // Mutation: Update with ownership check
  update: protectedProcedure
    .input(agentsUpdateSchema)
    .mutation(async ({ ctx, input }) => {
      const [updatedAgent] = await db
        .update(agents)
        .set(input)
        .where(
          and(
            eq(agents.id, input.id),
            eq(agents.userId, ctx.auth.user.id) // Row-level security
          )
        )
        .returning();

      if (!updatedAgent) {
        throw new TRPCError({ code: 'NOT_FOUND', message: 'Agent not found' });
      }

      return updatedAgent;
    }),

  // Mutation: Delete with ownership check
  remove: protectedProcedure
    .input(z.object({ id: z.string() }))
    .mutation(async ({ ctx, input }) => {
      const [removedAgent] = await db
        .delete(agents)
        .where(
          and(eq(agents.id, input.id), eq(agents.userId, ctx.auth.user.id))
        )
        .returning();

      if (!removedAgent) {
        throw new TRPCError({ code: 'NOT_FOUND', message: 'Agent not found' });
      }

      return removedAgent;
    })
});
```

**Key Patterns:**

- Always include row-level security with `eq(table.userId, ctx.auth.user.id)`
- Use `.returning()` to get created/updated data
- Return paginated responses with `{ items, total, totalPages }`
- Always validate input with Zod schemas

### tRPC Client Setup

```typescript
// src/trpc/client.tsx
'use client';

import type { QueryClient } from '@tanstack/react-query';
import { QueryClientProvider } from '@tanstack/react-query';
import { createTRPCClient, httpBatchLink } from '@trpc/client';
import { createTRPCContext } from '@trpc/tanstack-react-query';
import { useState } from 'react';
import { makeQueryClient } from './query-client';
import type { AppRouter } from './routers/_app';

export const { TRPCProvider, useTRPC } = createTRPCContext<AppRouter>();

let browserQueryClient: QueryClient;

function getQueryClient() {
  if (typeof window === 'undefined') {
    return makeQueryClient(); // Server: always new client
  }

  // Browser: reuse client (important for React suspense)
  if (!browserQueryClient) browserQueryClient = makeQueryClient();
  return browserQueryClient;
}

function getUrl() {
  const base = (() => {
    if (typeof window !== 'undefined') return '';
    return process.env.NEXT_PUBLIC_APP_URL;
  })();
  return `${base}/api/trpc`;
}

export function TRPCReactProvider(
  props: Readonly<{ children: React.ReactNode }>
) {
  const queryClient = getQueryClient();

  const [trpcClient] = useState(() =>
    createTRPCClient<AppRouter>({
      links: [
        httpBatchLink({
          url: getUrl()
        })
      ]
    })
  );

  return (
    <QueryClientProvider client={queryClient}>
      <TRPCProvider trpcClient={trpcClient} queryClient={queryClient}>
        {props.children}
      </TRPCProvider>
    </QueryClientProvider>
  );
}
```

### Using tRPC in Components

```typescript
// In a React component
const trpc = useTRPC();

// Query
const { data, isLoading } = trpc.agents.getMany.useSuspenseQuery({
  page: 1,
  pageSize: 10,
  search: 'math'
});

// Mutation
const createAgent = useMutation(
  trpc.agents.create.mutationOptions({
    onSuccess: async () => {
      await queryClient.invalidateQueries(trpc.agents.getMany.queryOptions({}));
    },
    onError: error => {
      toast.error(error.message);
    }
  })
);

// Call mutation
createAgent.mutate({ name: 'Math Tutor', instructions: '...' });
```

---

## Database with Drizzle ORM

### Connection Setup

```typescript
// src/db/index.ts
import 'dotenv/config';
import { drizzle } from 'drizzle-orm/node-postgres';

export const db = drizzle(process.env.DATABASE_URL!);
```

**⚠️ Production Pattern:** Add connection pooling and error handling:

```typescript
// IMPROVED VERSION (from docs/ERRORHANDLING.md)
import { Pool } from 'pg';

const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error('DATABASE_URL environment variable is not set');
}

const pool = new Pool({
  connectionString: DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000
});

pool.on('error', err => {
  console.error('Unexpected database pool error:', err);
});

export const db = drizzle(pool);
```

### Schema Patterns

```typescript
// src/db/schema.ts
import { nanoid } from 'nanoid';
import { pgTable, text, timestamp, boolean, pgEnum } from 'drizzle-orm/pg-core';

// User table
export const user = pgTable('user', {
  id: text('id').primaryKey(),
  name: text('name').notNull(),
  email: text('email').notNull().unique(),
  emailVerified: boolean('email_verified')
    .$defaultFn(() => false)
    .notNull(),
  image: text('image'),
  createdAt: timestamp('created_at')
    .$defaultFn(() => new Date())
    .notNull(),
  updatedAt: timestamp('updated_at')
    .$defaultFn(() => new Date())
    .notNull()
});

// Enum for status
export const meetingStatus = pgEnum('meeting_status', [
  'upcoming',
  'active',
  'completed',
  'processing',
  'cancelled'
]);

// Table with foreign key and cascade delete
export const agents = pgTable('agents', {
  id: text('id')
    .primaryKey()
    .$defaultFn(() => nanoid()), // Auto-generate ID
  name: text('name').notNull(),
  userId: text('user_id')
    .notNull()
    .references(() => user.id, { onDelete: 'cascade' }), // Cascade delete
  instructions: text('instructions').notNull(),
  createdAt: timestamp('created_at').notNull().defaultNow(),
  updatedAt: timestamp('updated_at').notNull().defaultNow()
});

// Table with enum and multiple foreign keys
export const meetings = pgTable('meetings', {
  id: text('id')
    .primaryKey()
    .$defaultFn(() => nanoid()),
  name: text('name').notNull(),
  userId: text('user_id')
    .notNull()
    .references(() => user.id, { onDelete: 'cascade' }),
  agentId: text('agent_id')
    .notNull()
    .references(() => agents.id, { onDelete: 'cascade' }),
  status: meetingStatus('status').notNull().default('upcoming'),
  startedAt: timestamp('started_at'),
  endedAt: timestamp('ended_at'),
  transcriptUrl: text('transcript_url'),
  recordingUrl: text('recording_url'),
  summary: text('summary'),
  createdAt: timestamp('created_at').notNull().defaultNow(),
  updatedAt: timestamp('updated_at').notNull().defaultNow()
});
```

**Key Patterns:**

- Use `nanoid()` for IDs (better than UUID for URLs)
- Use `pgEnum` for status fields
- Always add `{ onDelete: 'cascade' }` to foreign keys
- Use `.defaultNow()` for timestamps
- Use `.$defaultFn()` for dynamic defaults

### Query Patterns

```typescript
// Basic select
const users = await db.select().from(user);

// Select with where
const userByEmail = await db
  .select()
  .from(user)
  .where(eq(user.email, 'user@example.com'));

// Select with join
const meetingsWithAgents = await db
  .select()
  .from(meetings)
  .leftJoin(agents, eq(meetings.agentId, agents.id))
  .where(eq(meetings.userId, 'user-123'));

// Select with aggregation
const [agent] = await db
  .select({
    ...getTableColumns(agents), // Spread all columns
    meetingCount: db.$count(meetings, eq(agents.id, meetings.agentId)) // Count
  })
  .from(agents)
  .where(eq(agents.id, 'agent-123'));

// Insert with returning
const [newAgent] = await db
  .insert(agents)
  .values({
    name: 'Math Tutor',
    userId: 'user-123',
    instructions: 'Help with math'
  })
  .returning(); // Returns the created record

// Update with returning
const [updated] = await db
  .update(agents)
  .set({ name: 'Updated Name' })
  .where(eq(agents.id, 'agent-123'))
  .returning();

// Delete with returning
const [deleted] = await db
  .delete(agents)
  .where(eq(agents.id, 'agent-123'))
  .returning();

// Pagination pattern
const data = await db
  .select()
  .from(agents)
  .orderBy(desc(agents.createdAt))
  .limit(pageSize)
  .offset((page - 1) * pageSize);

// Search pattern
const results = await db
  .select()
  .from(agents)
  .where(ilike(agents.name, `%${search}%`));

// Multiple conditions with AND
const agent = await db
  .select()
  .from(agents)
  .where(
    and(
      eq(agents.id, agentId),
      eq(agents.userId, userId) // Row-level security
    )
  );
```

**Always use `.returning()`** to get the modified data back without a second query.

### Drizzle Config

```typescript
// drizzle.config.ts
import 'dotenv/config';
import { defineConfig } from 'drizzle-kit';

export default defineConfig({
  out: './drizzle',
  schema: './src/db/schema.ts',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL!
  }
});
```

### Essential NPM Scripts

```json
{
  "scripts": {
    "db:push": "drizzle-kit push",
    "db:studio": "drizzle-kit studio"
  }
}
```

---

## React Component Patterns

### Container/Presentational Pattern

```typescript
// Container (Smart Component) - Manages state and data
// src/modules/agents/ui/views/agents-view.tsx
export const AgentsView = () => {
  const trpc = useTRPC();
  const [filters] = useAgentsFilters();

  const { data } = trpc.agents.getMany.useSuspenseQuery({
    page: filters.page,
    pageSize: filters.pageSize,
    search: filters.search
  });

  return <AgentsListPresentation data={data} />;
};

// Presentational (Dumb Component) - Just renders UI
export const AgentsListPresentation = ({ data }) => {
  return (
    <div>
      {data.items.map(agent => (
        <AgentCard key={agent.id} agent={agent} />
      ))}
    </div>
  );
};
```

### Controlled Component Pattern

```typescript
// Parent owns state
const ParentComponent = () => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <ChildComponent
      open={isOpen} // State flows down
      onOpenChange={setIsOpen} // Callback flows up
    />
  );
};

// Child doesn't own state
const ChildComponent = ({ open, onOpenChange }) => {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      {/* ... */}
    </Dialog>
  );
};
```

**Key Benefit:** Single source of truth, easier to test.

### Composition Pattern

```typescript
// Flexible component using children
export const ResponsiveDialog = ({
  title,
  description,
  children,
  open,
  onOpenChange
}: ResponsiveDialogProps) => {
  const isMobile = useIsMobile();

  if (isMobile) {
    return (
      <Drawer open={open} onOpenChange={onOpenChange}>
        <DrawerContent>
          <DrawerHeader>
            <DrawerTitle>{title}</DrawerTitle>
            <DrawerDescription>{description}</DrawerDescription>
          </DrawerHeader>
          <div className="p-4">{children}</div>
        </DrawerContent>
      </Drawer>
    );
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
          <DialogDescription>{description}</DialogDescription>
        </DialogHeader>
        {children}
      </DialogContent>
    </Dialog>
  );
};

// Usage - any content works
<ResponsiveDialog
  title="Title"
  description="Desc"
  open={open}
  onOpenChange={setOpen}
>
  <MyCustomContent />
</ResponsiveDialog>;
```

### Callback Inversion Pattern

```typescript
// Form doesn't know about dialog
export const AgentForm = ({ onSuccess, onCancel, initialValues }) => {
  const createAgent = useMutation(
    trpc.agents.create.mutationOptions({
      onSuccess: async () => {
        await queryClient.invalidateQueries(...);
        onSuccess?.(); // Call parent callback
      }
    })
  );

  return (
    <form onSubmit={handleSubmit}>
      {/* fields */}
      <Button type="button" onClick={onCancel}>Cancel</Button>
      <Button type="submit">Create</Button>
    </form>
  );
};

// Parent decides what callbacks do
<AgentForm
  onSuccess={() => setDialogOpen(false)} // Close dialog
  onCancel={() => setDialogOpen(false)}  // Close dialog
/>
```

**Benefit:** Form is reusable outside dialogs.

---

## State Management

### URL State with nuqs

```typescript
// src/modules/agents/params.ts
import {
  createSearchParamsCache,
  parseAsInteger,
  parseAsString
} from 'nuqs/server';

export const agentsSearchParams = {
  page: parseAsInteger.withDefault(1),
  search: parseAsString.withDefault('')
};

export const agentsSearchParamsCache =
  createSearchParamsCache(agentsSearchParams);
```

```typescript
// src/modules/agents/hooks/use-agents-filters.ts
import { useQueryStates } from 'nuqs';
import { agentsSearchParams } from '../params';

export const useAgentsFilters = () => {
  return useQueryStates(agentsSearchParams);
};
```

```typescript
// Usage in component
const [filters, setFilters] = useAgentsFilters();

// Read
const page = filters.page;
const search = filters.search;

// Update (updates URL)
setFilters({ page: 2 });
setFilters({ search: 'math' });

// Clear
setFilters({ search: '', page: 1 });
```

**Benefits:**

- Shareable URLs
- Back button works
- Filters persist on refresh

### Form State with React Hook Form

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';

const form = useForm<z.infer<typeof agentsInsertSchema>>({
  resolver: zodResolver(agentsInsertSchema),
  defaultValues: {
    name: initialValues?.name ?? '',
    instructions: initialValues?.instructions ?? ''
  }
});

const onSubmit = (values: z.infer<typeof agentsInsertSchema>) => {
  createAgent.mutate(values);
};

return (
  <Form {...form}>
    <form onSubmit={form.handleSubmit(onSubmit)}>
      <FormField
        name="name"
        control={form.control}
        render={({ field }) => (
          <FormItem>
            <FormLabel>Name</FormLabel>
            <FormControl>
              <Input {...field} />
            </FormControl>
            <FormMessage />
          </FormItem>
        )}
      />
    </form>
  </Form>
);
```

---

## Form Handling

### Complete Form Pattern

```typescript
// Reference: src/modules/agents/ui/components/agent-form.tsx

interface AgentFormProps {
  onSuccess?: () => void;
  onCancel?: () => void;
  initialValues?: AgentGetOne;
}

export const AgentForm = ({
  onSuccess,
  onCancel,
  initialValues
}: AgentFormProps) => {
  const trpc = useTRPC();
  const queryClient = useQueryClient();
  const router = useRouter();

  const createAgent = useMutation(
    trpc.agents.create.mutationOptions({
      onSuccess: async () => {
        // Invalidate queries to refresh data
        await queryClient.invalidateQueries(
          trpc.agents.getMany.queryOptions({})
        );
        // Call parent callback
        onSuccess?.();
      },
      onError: error => {
        toast.error(error.message);
        // Handle specific errors
        if (error.data?.code === 'FORBIDDEN') {
          router.push('/upgrade');
        }
      }
    })
  );

  const updateAgent = useMutation(
    trpc.agents.update.mutationOptions({
      onSuccess: async () => {
        await queryClient.invalidateQueries(
          trpc.agents.getMany.queryOptions({})
        );
        if (initialValues?.id) {
          await queryClient.invalidateQueries(
            trpc.agents.getOne.queryOptions({ id: initialValues.id })
          );
        }
        onSuccess?.();
      },
      onError: error => {
        toast.error(error.message);
      }
    })
  );

  const form = useForm<z.infer<typeof agentsInsertSchema>>({
    resolver: zodResolver(agentsInsertSchema),
    defaultValues: {
      name: initialValues?.name ?? '',
      instructions: initialValues?.instructions ?? ''
    }
  });

  const isEdit = !!initialValues?.id;
  const isPending = createAgent.isPending || updateAgent.isPending;

  const onSubmit = (values: z.infer<typeof agentsInsertSchema>) => {
    if (isEdit) {
      updateAgent.mutate({ ...values, id: initialValues.id });
    } else {
      createAgent.mutate(values);
    }
  };

  return (
    <Form {...form}>
      <form className="space-y-4" onSubmit={form.handleSubmit(onSubmit)}>
        {/* Fields */}
        <FormField
          name="name"
          control={form.control}
          render={({ field }) => (
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input {...field} placeholder="e.g. Math tutor" />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        {/* Buttons */}
        <div className="flex justify-between gap-x-2">
          {onCancel && (
            <Button
              variant="ghost"
              disabled={isPending}
              type="button"
              onClick={() => onCancel()}
            >
              Cancel
            </Button>
          )}
          <Button disabled={isPending} type="submit">
            {isPending && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
            {isEdit ? 'Update' : 'Create'}
          </Button>
        </div>
      </form>
    </Form>
  );
};
```

**Key Patterns:**

- Use optional callbacks for flexibility
- Invalidate queries after mutations
- Handle both create and edit in one form
- Show loading states
- Error handling with toast

---

## Authentication & Authorization

### Protected Procedure Pattern

```typescript
// src/trpc/init.ts

// Basic auth check
export const protectedProcedure = baseProcedure.use(async ({ ctx, next }) => {
  const session = await auth.api.getSession({
    headers: await headers()
  });

  if (!session) {
    throw new TRPCError({ code: 'UNAUTHORIZED', message: 'Unauthorized' });
  }

  return next({ ctx: { ...ctx, auth: session } });
});
```

### Row-Level Security Pattern

```typescript
// ALWAYS filter by userId in queries
const agents = await db
  .select()
  .from(agents)
  .where(
    and(
      eq(agents.id, agentId),
      eq(agents.userId, ctx.auth.user.id) // ⚠️ Critical: Row-level security
    )
  );

// In updates and deletes too
await db
  .update(agents)
  .set({ name: 'New Name' })
  .where(
    and(
      eq(agents.id, agentId),
      eq(agents.userId, ctx.auth.user.id) // ⚠️ Never skip this
    )
  );
```

**Never skip the userId check** - prevents users from accessing others' data.

### Premium Feature Gating

```typescript
// src/trpc/init.ts

export const premiumProcedure = (entity: 'meetings' | 'agents') =>
  protectedProcedure.use(async ({ ctx, next }) => {
    // Check subscription status
    const customer = await polarClient.customers.getStateExternal({
      externalId: ctx.auth.user.id
    });

    // Count user's resources
    const [userAgents] = await db
      .select({ count: count(agents.id) })
      .from(agents)
      .where(eq(agents.userId, ctx.auth.user.id));

    const isPremium = customer.activeSubscriptions.length > 0;
    const isFreeAgentLimitReached = userAgents.count >= MAX_FREE_AGENTS;

    // Block if limit reached and not premium
    if (entity === 'agents' && isFreeAgentLimitReached && !isPremium) {
      throw new TRPCError({
        code: 'FORBIDDEN',
        message: 'You have reached the maximum number of free agents'
      });
    }

    return next({ ctx: { ...ctx, customer } });
  });
```

**Usage:**

```typescript
export const agentsRouter = createTRPCRouter({
  create: premiumProcedure('agents') // ⚠️ Gated
    .input(agentsInsertSchema)
    .mutation(async ({ input, ctx }) => {
      // Only executes if user has premium or under limit
      const [agent] = await db.insert(agents).values(input).returning();
      return agent;
    })
});
```

---

## Error Handling

### Error Handling Best Practices

From `docs/ERRORHANDLING.md`:

#### 1. Database Connection with Error Handling

```typescript
// src/db/index.ts (IMPROVED)
import { Pool } from 'pg';

const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error('DATABASE_URL environment variable is not set');
}

const pool = new Pool({
  connectionString: DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000,
  statement_timeout: 30000 // 30 second query timeout
});

pool.on('error', err => {
  console.error('Unexpected database pool error:', err);
  // Send to error monitoring service
});

// Test connection on startup
pool.connect((err, client, release) => {
  if (err) {
    console.error('Failed to connect to database:', err.message);
    process.exit(1);
  }
  console.log('✓ Database connection established');
  release();
});

export const db = drizzle(pool);
```

#### 2. Transaction Pattern

```typescript
// For complex operations that need atomicity
try {
  const result = await db.transaction(async tx => {
    // Create meeting record
    const [createdMeeting] = await tx
      .insert(meetings)
      .values({ ...input, userId: ctx.auth.user.id })
      .returning();

    // Fetch related agent
    const [existingAgent] = await tx
      .select()
      .from(agents)
      .where(eq(agents.id, createdMeeting.agentId));

    if (!existingAgent) {
      throw new TRPCError({
        code: 'NOT_FOUND',
        message: 'Agent not found'
      });
    }

    return { createdMeeting, existingAgent };
  });

  // External API calls outside transaction
  try {
    await streamVideo.call.create(result.createdMeeting.id);
  } catch (streamError) {
    // Rollback: Delete meeting if external API fails
    await db.delete(meetings).where(eq(meetings.id, result.createdMeeting.id));
    throw new TRPCError({
      code: 'INTERNAL_SERVER_ERROR',
      message: 'Failed to initialize video call. Please try again.'
    });
  }

  return result.createdMeeting;
} catch (error) {
  console.error('Meeting creation failed:', error);
  throw error;
}
```

#### 3. User-Friendly Error Messages

```typescript
// lib/error-messages.ts
import { TRPCClientError } from '@trpc/client';

interface UserFriendlyError {
  title: string;
  message: string;
  action?: string;
}

export function getUserFriendlyError(error: unknown): UserFriendlyError {
  if (error instanceof TRPCClientError) {
    switch (error.data?.code) {
      case 'UNAUTHORIZED':
        return {
          title: 'Authentication Required',
          message: 'Please sign in to continue.',
          action: 'Sign in'
        };

      case 'FORBIDDEN':
        if (error.message.includes('maximum number of free')) {
          return {
            title: 'Upgrade Required',
            message: error.message,
            action: 'View Plans'
          };
        }
        return {
          title: 'Access Denied',
          message: "You don't have permission to perform this action."
        };

      case 'NOT_FOUND':
        return {
          title: 'Not Found',
          message:
            "The item you're looking for doesn't exist or has been deleted."
        };

      default:
        return {
          title: 'Something Went Wrong',
          message:
            'An unexpected error occurred. If this persists, please contact support.'
        };
    }
  }

  return {
    title: 'Unknown Error',
    message: 'An unexpected error occurred. Please try again.'
  };
}
```

#### 4. React Query Error Handling

```typescript
// src/trpc/query-client.ts
import { toast } from 'sonner';
import { TRPCClientError } from '@trpc/client';

export function makeQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 30 * 1000,
        retry: (failureCount, error) => {
          // Don't retry on client errors
          if (error instanceof TRPCClientError) {
            if (
              error.data?.httpStatus === 401 ||
              error.data?.httpStatus === 403
            ) {
              return false;
            }
            if (error.data?.httpStatus >= 400 && error.data?.httpStatus < 500) {
              return false;
            }
          }
          // Retry server errors up to 3 times
          return failureCount < 3;
        }
      },
      mutations: {
        retry: false, // Never retry mutations
        onError: error => {
          if (error instanceof TRPCClientError) {
            if (error.data?.code === 'INTERNAL_SERVER_ERROR') {
              toast.error('Something went wrong. Please try again.');
            }
          }
        }
      }
    }
  });
}
```

#### 5. Global Error Boundary

```typescript
// src/components/global-error-boundary.tsx
'use client';

import { Component, ReactNode } from 'react';
import { ErrorState } from './error-state';
import { Button } from './ui/button';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class GlobalErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Global error:', error, errorInfo);
    // Send to error monitoring service
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="flex h-screen items-center justify-center">
          <ErrorState
            title="Something went wrong"
            description="We're sorry, but something unexpected happened. Please try refreshing the page."
          />
          <Button onClick={() => window.location.reload()}>Refresh Page</Button>
        </div>
      );
    }

    return this.props.children;
  }
}
```

---

## Responsive Dialog Pattern

### Complete Responsive Dialog System

**Reference:** `docs/RESPONSIVEDIALOG.md`, `docs/RESPONSIVEDIALOGTUTORIAL.md`

#### 1. Mobile Detection Hook

```typescript
// src/hooks/use-mobile.ts
import * as React from 'react';

const MOBILE_BREAKPOINT = 768; // Matches Tailwind's md

export function useIsMobile() {
  const [isMobile, setIsMobile] = React.useState<boolean | undefined>(
    undefined
  );

  React.useEffect(() => {
    const mql = window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`);

    const onChange = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
    };

    mql.addEventListener('change', onChange);
    setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);

    return () => mql.removeEventListener('change', onChange);
  }, []);

  return !!isMobile;
}
```

#### 2. Responsive Dialog Component

```typescript
// src/components/responsive-dialog.tsx
'use client';

import { useIsMobile } from '@/hooks/use-mobile';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription
} from '@/components/ui/dialog';
import {
  Drawer,
  DrawerContent,
  DrawerHeader,
  DrawerTitle,
  DrawerDescription
} from '@/components/ui/drawer';

interface ResponsiveDialogProps {
  title: string;
  description: string;
  children: React.ReactNode;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export const ResponsiveDialog = ({
  title,
  description,
  children,
  open,
  onOpenChange
}: ResponsiveDialogProps) => {
  const isMobile = useIsMobile();

  if (isMobile) {
    return (
      <Drawer open={open} onOpenChange={onOpenChange}>
        <DrawerContent>
          <DrawerHeader>
            <DrawerTitle>{title}</DrawerTitle>
            <DrawerDescription>{description}</DrawerDescription>
          </DrawerHeader>
          <div className="p-4">{children}</div>
        </DrawerContent>
      </Drawer>
    );
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
          <DialogDescription>{description}</DialogDescription>
        </DialogHeader>
        {children}
      </DialogContent>
    </Dialog>
  );
};
```

#### 3. Dialog Usage Pattern

```typescript
// Parent component owns state
const AgentsListHeader = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  return (
    <>
      <NewAgentDialog open={isDialogOpen} onOpenChange={setIsDialogOpen} />

      <Button onClick={() => setIsDialogOpen(true)}>New Agent</Button>
    </>
  );
};

// Dialog wrapper configures the ResponsiveDialog
const NewAgentDialog = ({ open, onOpenChange }) => {
  return (
    <ResponsiveDialog
      title="New Agent"
      description="Create a new agent"
      open={open}
      onOpenChange={onOpenChange}
    >
      <AgentForm
        onSuccess={() => onOpenChange(false)} // Close on success
        onCancel={() => onOpenChange(false)} // Close on cancel
      />
    </ResponsiveDialog>
  );
};
```

**Key Insights:**

- Parent owns state (`isDialogOpen`)
- Pass `setIsDialogOpen` directly as `onOpenChange` (signatures match!)
- Both Dialog and Drawer use same `open`/`onOpenChange` API
- Automatically switches between Dialog (desktop) and Drawer (mobile)
- Form callbacks control dialog closing

---

## Promise-Based UI Patterns

### useConfirm Hook

**Reference:** `src/hooks/use-confirm.tsx`, `docs/DIALOGUSECONFIRM.md`

```typescript
// src/hooks/use-confirm.tsx
import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { ResponsiveDialog } from '@/components/responsive-dialog';

export const useConfirm = (
  title: string,
  description: string
): [() => JSX.Element, () => Promise<unknown>] => {
  // Store Promise resolver in state
  const [promise, setPromise] = useState<{
    resolve: (value: boolean) => void;
  } | null>(null);

  // Create Promise and store resolver
  const confirm = () => {
    return new Promise(resolve => {
      setPromise({ resolve });
    });
  };

  const handleClose = () => {
    setPromise(null);
  };

  const handleConfirm = () => {
    promise?.resolve(true);
    handleClose();
  };

  const handleCancel = () => {
    promise?.resolve(false);
    handleClose();
  };

  const ConfirmationDialog = () => (
    <ResponsiveDialog
      open={promise !== null}
      onOpenChange={handleClose}
      title={title}
      description={description}
    >
      <div className="pt-4 w-full flex flex-col-reverse gap-y-2 lg:flex-row gap-x-2 items-center justify-end">
        <Button
          onClick={handleCancel}
          variant="outline"
          className="w-full lg:w-auto"
        >
          Cancel
        </Button>
        <Button onClick={handleConfirm} className="w-full lg:w-auto">
          Confirm
        </Button>
      </div>
    </ResponsiveDialog>
  );

  return [ConfirmationDialog, confirm];
};
```

**Usage:**

```typescript
const [RemoveConfirmation, confirmRemove] = useConfirm(
  'Are you sure?',
  `This will remove the agent and ${data.meetingCount} associated meetings`
);

const handleRemoveAgent = async () => {
  const ok = await confirmRemove(); // ⚠️ Awaits user confirmation
  if (!ok) return;

  await removeAgent.mutateAsync({ id: agentId });
};

return (
  <>
    <RemoveConfirmation /> {/* Must be rendered */}
    <Button onClick={handleRemoveAgent}>Delete</Button>
  </>
);
```

**Pattern Benefits:**

- Clean async/await syntax
- No manual state management
- Reusable across app
- Responsive (works on mobile/desktop)

### Other Promise-Based Patterns

```typescript
// File upload with progress
const useFileUpload = () => {
  const [promise, setPromise] = useState<{
    resolve: (url: string) => void;
    progress: (percent: number) => void;
  } | null>(null);

  const upload = (file: File) => {
    return new Promise<string>(resolve => {
      setPromise({
        resolve,
        progress: percent => {
          // Update progress UI
        }
      });
    });
  };
  // ...
};

// Multi-step wizard
const useWizard = () => {
  const [promise, setPromise] = useState<{
    resolve: (data: FormData) => void;
    nextStep: () => void;
    prevStep: () => void;
  } | null>(null);
  // ...
};
```

---

## Testing Patterns

### Jest Setup

```typescript
// jest.config.ts
import type { Config } from 'jest';
import nextJest from 'next/jest';

const createJestConfig = nextJest({
  dir: './'
});

const config: Config = {
  coverageProvider: 'v8',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js']
};

export default createJestConfig(config);
```

```typescript
// jest.setup.js
import '@testing-library/jest-dom';
```

### Testing tRPC Procedures

```typescript
// Example test structure (from docs)
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

describe('AgentForm', () => {
  it('calls onSuccess after successful submission', async () => {
    const onSuccess = jest.fn();

    render(<AgentForm onSuccess={onSuccess} />);

    await userEvent.type(screen.getByLabelText('Name'), 'Test Agent');
    await userEvent.click(screen.getByText('Create'));

    await waitFor(() => {
      expect(onSuccess).toHaveBeenCalled();
    });
  });
});
```

### Integration Testing

```typescript
describe('New Agent Flow', () => {
  it('completes full flow: open → fill → submit → close', async () => {
    render(<AgentsListHeader />);

    // Open dialog
    await userEvent.click(screen.getByText('New Agent'));
    expect(screen.getByRole('dialog')).toBeVisible();

    // Fill form
    await userEvent.type(screen.getByLabelText('Name'), 'Test Agent');

    // Submit
    await userEvent.click(screen.getByText('Create'));

    // Dialog closes
    await waitFor(() => {
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });
  });
});
```

---

## Essential NPM Packages

### Core Dependencies

From `package.json`:

```json
{
  "dependencies": {
    // Framework
    "next": "15.3.2",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",

    // Type Safety
    "typescript": "^5",
    "zod": "^3.25.7",

    // API & Data
    "@trpc/client": "^11.1.2",
    "@trpc/server": "^11.1.2",
    "@trpc/tanstack-react-query": "^11.1.2",
    "@tanstack/react-query": "^5.76.1",

    // Database
    "drizzle-orm": "^0.44.2",
    "pg": "^8.16.0",
    "nanoid": "^5.1.5",

    // Auth
    "better-auth": "^1.2.8",
    "@polar-sh/better-auth": "^1.0.8",

    // Forms
    "react-hook-form": "^7.57.0",
    "@hookform/resolvers": "^5.0.1",

    // UI Components (Radix + Shadcn)
    "@radix-ui/react-dialog": "^1.1.14",
    "vaul": "^1.1.2", // Mobile drawer
    "sonner": "^2.0.5", // Toast notifications
    "lucide-react": "^0.513.0", // Icons

    // URL State
    "nuqs": "^2.4.3",

    // Utilities
    "clsx": "^2.1.1",
    "tailwind-merge": "^3.3.0",
    "class-variance-authority": "^0.7.1",

    // Background Jobs
    "inngest": "^3.37.0",

    // Realtime
    "@stream-io/video-react-sdk": "^1.18.0",
    "stream-chat-react": "^13.0.4"
  },
  "devDependencies": {
    "drizzle-kit": "^0.31.1",
    "@testing-library/react": "^16.3.0",
    "@testing-library/jest-dom": "^6.6.3",
    "jest": "^29.7.0",
    "tailwindcss": "^4"
  }
}
```

### Critical Package Combinations

```typescript
// Type-safe API
@trpc/server + @trpc/client + @trpc/tanstack-react-query

// Database
drizzle-orm + drizzle-kit + pg

// Forms
react-hook-form + @hookform/resolvers + zod

// UI Components
@radix-ui/* + vaul + lucide-react

// Styling
tailwindcss + clsx + tailwind-merge
```

---

## Quick Reference Cheat Sheet

### tRPC Procedure Template

```typescript
export const myRouter = createTRPCRouter({
  getOne: protectedProcedure
    .input(z.object({ id: z.string() }))
    .query(async ({ input, ctx }) => {
      const [item] = await db
        .select()
        .from(table)
        .where(and(eq(table.id, input.id), eq(table.userId, ctx.auth.user.id)));

      if (!item) {
        throw new TRPCError({ code: 'NOT_FOUND', message: 'Not found' });
      }

      return item;
    }),

  create: premiumProcedure('entity')
    .input(insertSchema)
    .mutation(async ({ input, ctx }) => {
      const [created] = await db
        .insert(table)
        .values({ ...input, userId: ctx.auth.user.id })
        .returning();

      return created;
    })
});
```

### Component Template

```typescript
interface MyComponentProps {
  onSuccess?: () => void;
  onCancel?: () => void;
  initialValues?: MyType;
}

export const MyComponent = ({
  onSuccess,
  onCancel,
  initialValues
}: MyComponentProps) => {
  const trpc = useTRPC();
  const queryClient = useQueryClient();

  const mutation = useMutation(
    trpc.my.create.mutationOptions({
      onSuccess: async () => {
        await queryClient.invalidateQueries(trpc.my.getMany.queryOptions({}));
        onSuccess?.();
      },
      onError: error => {
        toast.error(error.message);
      }
    })
  );

  const form = useForm({
    resolver: zodResolver(schema),
    defaultValues: initialValues ?? {}
  });

  const onSubmit = (values: z.infer<typeof schema>) => {
    mutation.mutate(values);
  };

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        {/* fields */}
        <Button disabled={mutation.isPending} type="submit">
          {mutation.isPending && <Loader2 className="animate-spin" />}
          Submit
        </Button>
      </form>
    </Form>
  );
};
```

### Database Query Template

```typescript
// Select with pagination and filters
const data = await db
  .select({
    ...getTableColumns(table),
    relatedCount: db.$count(related, eq(table.id, related.tableId))
  })
  .from(table)
  .where(
    and(
      eq(table.userId, userId),
      search ? ilike(table.name, `%${search}%`) : undefined
    )
  )
  .orderBy(desc(table.createdAt))
  .limit(pageSize)
  .offset((page - 1) * pageSize);

const [total] = await db
  .select({ count: count() })
  .from(table)
  .where(/* same conditions */);

return {
  items: data,
  total: total.count,
  totalPages: Math.ceil(total.count / pageSize)
};
```

---

## Final Checklist for Next Project

### Setup Phase

- [ ] Initialize Next.js with TypeScript
- [ ] Install tRPC + React Query
- [ ] Install Drizzle ORM + PostgreSQL
- [ ] Set up Shadcn/UI
- [ ] Configure authentication (Better Auth)
- [ ] Set up Tailwind CSS
- [ ] Create module structure

### Development Patterns

- [ ] Use module-based organization
- [ ] Always use Zod schemas for validation
- [ ] Infer TypeScript types from tRPC outputs
- [ ] Implement row-level security on all queries
- [ ] Use controlled components for dialogs
- [ ] Implement promise-based confirmations
- [ ] Use URL state for filters (nuqs)
- [ ] Always use `.returning()` in mutations

### Error Handling

- [ ] Add database connection pooling
- [ ] Implement global error boundary
- [ ] Configure React Query defaults
- [ ] Create user-friendly error messages
- [ ] Add error monitoring (Sentry)

### Testing

- [ ] Set up Jest + Testing Library
- [ ] Test form submissions
- [ ] Test state management
- [ ] Integration tests for critical flows

### Deployment

- [ ] Validate environment variables
- [ ] Set up proper database migrations
- [ ] Configure error logging
- [ ] Test responsive design

---

## Key Takeaways

### Architecture

1. **tRPC** eliminates API contract issues with end-to-end type safety
2. **Drizzle** provides type-safe database queries without heavy abstraction
3. **Module structure** keeps features organized and maintainable
4. **Zod schemas** serve as single source of truth for validation

### Patterns

1. **Controlled components** with `open`/`onOpenChange` for dialogs
2. **Promise-based state** for confirmation flows
3. **Row-level security** on every database query
4. **Callback inversion** for loose coupling
5. **Composition pattern** for flexible components

### Security

1. Always validate with Zod schemas
2. Always check `userId` in queries
3. Use middleware for auth and premium gating
4. Never trust client input

### Performance

1. Use React Query caching via tRPC
2. Implement pagination on all lists
3. Use connection pooling for database
4. Lazy load heavy components

---

## Additional Resources

- **tRPC Documentation**: https://trpc.io
- **Drizzle Documentation**: https://orm.drizzle.team
- **Radix UI**: https://www.radix-ui.com
- **Shadcn/UI**: https://ui.shadcn.com
- **React Hook Form**: https://react-hook-form.com
- **Zod**: https://zod.dev

---

**Last Updated:** 2025-11-22

This document serves as a comprehensive reference for building type-safe, production-ready Next.js applications. All patterns are battle-tested in production.
