# Error Handling Review Report

## Executive Summary

This document provides a comprehensive analysis of error handling across the application, covering database, server, client, and user feedback layers. Issues are categorized by severity: **CRITICAL**, **MAJOR**, and **MINOR**.

---

## Table of Contents

1. [Database Layer](#database-layer)
2. [Server Layer](#server-layer)
3. [Client Layer](#client-layer)
4. [User Feedback Layer](#user-feedback-layer)
5. [Key Files & Components](#key-files--components)
6. [Recommendations Summary](#recommendations-summary)

---

## Database Layer

### Key Files

- `src/db/index.ts` - Database connection
- `src/db/schema.ts` - Schema definitions
- `drizzle.config.ts` - Drizzle configuration

### Issues Identified

#### 🔴 CRITICAL: No Database Connection Error Handling

**File:** `src/db/index.ts`

**Current Implementation:**

```typescript
import 'dotenv/config';
import { drizzle } from 'drizzle-orm/node-postgres';

export const db = drizzle(process.env.DATABASE_URL!);
```

**Problems:**

1. No validation of `DATABASE_URL` environment variable
2. No connection error handling
3. No connection pooling configuration
4. Silent failure if database is unreachable
5. No retry logic for transient failures
6. Using `!` assertion on environment variable (unsafe)

**Impact:**

- Application crashes on startup if DB is unavailable
- No graceful degradation
- Poor user experience during DB outages
- Difficult to diagnose connection issues

**Fix:**

```typescript
import 'dotenv/config';
import { drizzle } from 'drizzle-orm/node-postgres';
import { Pool } from 'pg';

// Validate environment variable
const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error(
    'DATABASE_URL environment variable is not set. Please configure your database connection.'
  );
}

// Create connection pool with error handling
const pool = new Pool({
  connectionString: DATABASE_URL,
  max: 20, // Maximum pool size
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000 // 10 second timeout
});

// Handle pool errors
pool.on('error', err => {
  console.error('Unexpected database pool error:', err);
  // Consider sending to error monitoring service (Sentry, etc.)
});

// Test connection on startup
pool.connect((err, client, release) => {
  if (err) {
    console.error('Failed to connect to database:', err.message);
    console.error(
      'Connection string format: postgresql://user:password@host:port/database'
    );
    process.exit(1); // Exit if DB is critical
  }
  console.log('✓ Database connection established');
  release();
});

export const db = drizzle(pool);
```

#### 🟡 MAJOR: No Transaction Error Handling

**Files:**

- `src/modules/agents/server/procedures.ts`
- `src/modules/meetings/server/procedures.ts`

**Problem:**
Complex operations (like creating meetings) don't use database transactions. If part of the operation fails, data can be left in an inconsistent state.

**Example from `meetings/server/procedures.ts` (lines 208-265):**

```typescript
const [createdMeeting] = await db.insert(meetings).values({...}).returning();
// Then creates Stream Call - if this fails, meeting record is orphaned
const call = streamVideo.video.call('default', createdMeeting.id);
await call.create({...});
// Then upserts users - if this fails, call exists but users aren't added
await streamVideo.upsertUsers([...]);
```

**Fix:**

```typescript
create: premiumProcedure('meetings')
  .input(meetingsInsertSchema)
  .mutation(async ({ input, ctx }) => {
    try {
      // Use transaction for atomic operations
      const result = await db.transaction(async tx => {
        // Create meeting record
        const [createdMeeting] = await tx
          .insert(meetings)
          .values({
            ...input,
            userId: ctx.auth.user.id
          })
          .returning();

        // Fetch agent
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

      // External API calls outside transaction (with error handling)
      try {
        const call = streamVideo.video.call(
          'default',
          result.createdMeeting.id
        );
        await call.create({
          data: {
            created_by_id: ctx.auth.user.id,
            custom: {
              meetingId: result.createdMeeting.id,
              meetingName: result.createdMeeting.name
            },
            settings_override: {
              transcription: {
                language: 'en',
                mode: 'auto-on',
                closed_caption_mode: 'auto-on'
              },
              recording: {
                mode: 'auto-on',
                quality: '1080p'
              }
            }
          }
        });

        await streamVideo.upsertUsers([
          {
            id: result.existingAgent.id,
            name: result.existingAgent.name,
            role: 'user',
            image: generateAvatarUri({
              seed: result.existingAgent.name,
              variant: 'botttsNeutral'
            })
          }
        ]);
      } catch (streamError) {
        // Rollback: Delete the meeting if Stream setup fails
        await db
          .delete(meetings)
          .where(eq(meetings.id, result.createdMeeting.id));

        throw new TRPCError({
          code: 'INTERNAL_SERVER_ERROR',
          message: 'Failed to initialize video call. Please try again.',
          cause: streamError
        });
      }

      return result.createdMeeting;
    } catch (error) {
      // Log error for debugging
      console.error('Meeting creation failed:', error);
      throw error; // Re-throw to be handled by tRPC
    }
  });
```

#### 🟡 MAJOR: No Query Timeout Configuration

**Problem:** Long-running queries can hang the application with no timeout.

**Fix:** Add to pool configuration:

```typescript
const pool = new Pool({
  connectionString: DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000,
  statement_timeout: 30000 // 30 second query timeout
});
```

---

## Server Layer

### Key Files

- `src/trpc/init.ts` - tRPC initialization and middleware
- `src/app/api/trpc/[trpc]/route.ts` - tRPC route handler
- `src/app/api/webhook/route.ts` - Webhook handler
- `src/modules/*/server/procedures.ts` - tRPC procedures
- `src/inngest/functions.ts` - Background job functions

### Issues Identified

#### 🔴 CRITICAL: No Error Logging/Monitoring

**Files:** All server-side files

**Problem:**

- No centralized error logging
- No error monitoring service integration (Sentry, etc.)
- Errors only go to console.log
- No error aggregation or alerting
- Difficult to debug production issues

**Fix:**

Create error monitoring utility:

```typescript
// src/lib/error-monitoring.ts
import * as Sentry from '@sentry/nextjs';

interface ErrorContext {
  userId?: string;
  trpcPath?: string;
  input?: unknown;
  [key: string]: unknown;
}

export function initErrorMonitoring() {
  if (process.env.NEXT_PUBLIC_SENTRY_DSN) {
    Sentry.init({
      dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
      environment: process.env.NODE_ENV,
      tracesSampleRate: 0.1,
      beforeSend(event, hint) {
        // Filter out known non-critical errors
        if (hint.originalException?.message?.includes('UNAUTHORIZED')) {
          return null;
        }
        return event;
      }
    });
  }
}

export function logError(
  error: Error,
  context?: ErrorContext,
  severity: 'error' | 'warning' | 'fatal' = 'error'
) {
  // Always log to console
  console.error(`[${severity.toUpperCase()}]`, error.message, {
    context,
    stack: error.stack
  });

  // Send to monitoring service
  if (process.env.NEXT_PUBLIC_SENTRY_DSN) {
    Sentry.captureException(error, {
      level: severity,
      contexts: {
        custom: context
      }
    });
  }
}
```

Update `src/trpc/init.ts`:

```typescript
import { logError } from '@/lib/error-monitoring';

const t = initTRPC.create({
  errorFormatter({ shape, error }) {
    // Log all tRPC errors
    if (error.code !== 'UNAUTHORIZED') {
      logError(
        error,
        {
          trpcPath: shape.data?.path,
          code: error.code
        },
        error.code === 'INTERNAL_SERVER_ERROR' ? 'error' : 'warning'
      );
    }

    return {
      ...shape,
      data: {
        ...shape.data,
        zodError: error.cause instanceof ZodError ? error.cause.flatten() : null
      }
    };
  }
});
```

#### 🔴 CRITICAL: External API Calls Have No Error Handling

**Files:**

- `src/modules/meetings/server/procedures.ts` (Stream API)
- `src/modules/premium/server/procedures.ts` (Polar API)
- `src/app/api/webhook/route.ts` (OpenAI API)

**Example Problem - Stream API (lines 220-240):**

```typescript
const call = streamVideo.video.call('default', createdMeeting.id);
await call.create({...}); // No try-catch, no retry, no timeout
```

**Impact:**

- Silent failures
- Incomplete operations
- Poor user feedback
- No retry for transient failures

**Fix:**

Create API wrapper with retry logic:

```typescript
// src/lib/api-utils.ts
export async function withRetry<T>(
  fn: () => Promise<T>,
  options: {
    maxRetries?: number;
    retryDelay?: number;
    context?: string;
  } = {}
): Promise<T> {
  const { maxRetries = 3, retryDelay = 1000, context = 'API call' } = options;

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error) {
      const isLastAttempt = attempt === maxRetries;

      if (isLastAttempt) {
        console.error(`${context} failed after ${maxRetries} attempts:`, error);
        throw error;
      }

      console.warn(`${context} attempt ${attempt} failed, retrying...`, error);
      await new Promise(resolve => setTimeout(resolve, retryDelay * attempt));
    }
  }

  throw new Error(`${context} failed after ${maxRetries} retries`);
}

export async function safeExternalCall<T>(
  fn: () => Promise<T>,
  options: {
    fallback?: T;
    context: string;
    timeout?: number;
  }
): Promise<T | undefined> {
  const { fallback, context, timeout = 10000 } = options;

  try {
    const result = await Promise.race([
      fn(),
      new Promise<never>((_, reject) =>
        setTimeout(() => reject(new Error('Timeout')), timeout)
      )
    ]);
    return result;
  } catch (error) {
    logError(error as Error, { context }, 'warning');
    return fallback;
  }
}
```

Apply to procedures:

```typescript
// In meetings create procedure
try {
  await withRetry(
    () => call.create({...}),
    { context: 'Stream call creation', maxRetries: 2 }
  );

  await withRetry(
    () => streamVideo.upsertUsers([...]),
    { context: 'Stream user upsert', maxRetries: 2 }
  );
} catch (error) {
  // Clean up and provide user feedback
  await db.delete(meetings).where(eq(meetings.id, createdMeeting.id));

  throw new TRPCError({
    code: 'INTERNAL_SERVER_ERROR',
    message: 'Failed to set up video call. Please try again later.',
  });
}
```

#### 🟡 MAJOR: Webhook Route Has Weak Error Handling

**File:** `src/app/api/webhook/route.ts`

**Problems:**

1. No error logging for failed webhook processing
2. Returns 200 OK even when processing fails
3. No retry mechanism for failed webhooks
4. OpenAI API calls have no error handling (line 218)

**Current Code (lines 218-225):**

```typescript
const GPTResponse = await openaiClient.chat.completions.create({
  messages: [...],
  model: 'gpt-4o'
}); // No error handling!
```

**Fix:**

```typescript
export async function POST(req: NextRequest) {
  const signature = req.headers.get('x-signature');
  const apiKey = req.headers.get('x-api-key');

  if (!signature || !apiKey) {
    return NextResponse.json(
      { error: 'Missing signature or API key' },
      { status: 400 }
    );
  }

  const body = await req.text();

  if (!verifySignatureWithSDK(body, signature)) {
    logError(
      new Error('Invalid webhook signature'),
      { signature, bodyLength: body.length },
      'warning'
    );
    return NextResponse.json({ error: 'Invalid signature' }, { status: 401 });
  }

  let payload: unknown;
  try {
    payload = JSON.parse(body) as Record<string, unknown>;
  } catch (error) {
    logError(error as Error, { body: body.slice(0, 100) });
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 });
  }

  const eventType = (payload as Record<string, unknown>)?.type;

  try {
    // Process webhook based on event type
    if (eventType === 'message.new') {
      const event = payload as MessageNewEvent;
      // ... validation ...

      try {
        const GPTResponse = await Promise.race([
          openaiClient.chat.completions.create({
            messages: [...],
            model: 'gpt-4o',
            temperature: 0.7,
          }),
          new Promise((_, reject) =>
            setTimeout(() => reject(new Error('OpenAI timeout')), 30000)
          ),
        ]);

        const GPTResponseText = GPTResponse.choices[0]?.message?.content;

        if (!GPTResponseText) {
          throw new Error('Empty response from OpenAI');
        }

        // Send message...
      } catch (openaiError) {
        logError(openaiError as Error, {
          eventType,
          meetingId: channelId,
          userId,
        });

        // Send error message to user instead of silent failure
        await channel.sendMessage({
          text: "I'm having trouble responding right now. Please try again in a moment.",
          user: {
            id: existingAgent.id,
            name: existingAgent.name,
            image: avatarUrl,
          },
        });

        // Return 200 so webhook isn't retried
        return NextResponse.json({ status: 'error_handled' });
      }
    }
    // ... other event handlers ...

    return NextResponse.json({ status: 'ok' });
  } catch (error) {
    logError(error as Error, { eventType, payload });

    // Return 500 so Stream retries the webhook
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

#### 🟡 MAJOR: Inngest Function Has No Error Handling

**File:** `src/inngest/functions.ts`

**Problems:**

1. No error handling for fetch failures (line 40)
2. No error handling for transcript parsing (line 44)
3. No error handling for OpenAI summarization (line 92)
4. No validation of transcript data

**Fix:**

```typescript
export const meetingsProcessing = inngest.createFunction(
  {
    id: 'meetings/processing',
    retries: 3 // Add retry configuration
  },
  { event: 'meetings/processing' },
  async ({ event, step }) => {
    const meetingId = event.data.meetingId;

    // Fetch with error handling
    const response = await step.run('fetch-transcript', async () => {
      try {
        const res = await fetch(event.data.transcriptUrl);
        if (!res.ok) {
          throw new Error(`Failed to fetch transcript: ${res.status}`);
        }
        return await res.text();
      } catch (error) {
        logError(error as Error, { meetingId, url: event.data.transcriptUrl });

        // Mark meeting as failed
        await db
          .update(meetings)
          .set({ status: 'cancelled' })
          .where(eq(meetings.id, meetingId));

        throw error; // Inngest will retry
      }
    });

    // Parse with validation
    const transcript = await step.run('parse-transcript', async () => {
      try {
        const parsed = JSONL.parse<StreamTranscriptItem>(response);

        if (!Array.isArray(parsed) || parsed.length === 0) {
          throw new Error('Transcript is empty or invalid');
        }

        return parsed;
      } catch (error) {
        logError(error as Error, { meetingId });
        throw new Error('Failed to parse transcript');
      }
    });

    // ... rest of function with error handling ...

    // Summarize with error handling
    try {
      const { output } = await summarizer.run(
        'Summarize the following transcript: ' +
          JSON.stringify(transcriptWithSpeakers)
      );

      await step.run('save-summary', async () => {
        await db
          .update(meetings)
          .set({
            summary: (output[0] as TextMessage).content as string,
            status: 'completed'
          })
          .where(eq(meetings.id, meetingId));
      });
    } catch (error) {
      logError(error as Error, { meetingId, context: 'AI summarization' });

      // Mark as completed without summary rather than failing
      await db
        .update(meetings)
        .set({
          summary: 'Transcript available but summary generation failed.',
          status: 'completed'
        })
        .where(eq(meetings.id, meetingId));
    }
  }
);
```

#### 🔵 MINOR: Environment Variables Not Validated

**Files:**

- `src/lib/auth.ts`
- `src/lib/polar.ts`
- `src/lib/stream-video.ts`
- `src/lib/stream-chat.ts`

**Problem:** Using `!` assertion on env vars that might be undefined.

**Fix:**

Create environment validation utility:

```typescript
// src/lib/env.ts
import { z } from 'zod';

const envSchema = z.object({
  DATABASE_URL: z.string().url(),
  GITHUB_CLIENT_ID: z.string().min(1),
  GITHUB_CLIENT_SECRET: z.string().min(1),
  GOOGLE_CLIENT_ID: z.string().min(1),
  GOOGLE_CLIENT_SECRET: z.string().min(1),
  POLAR_ACCESS_TOKEN: z.string().min(1),
  OPENAI_API_KEY: z.string().startsWith('sk-'),
  NEXT_PUBLIC_STREAM_VIDEO_API_KEY: z.string().min(1),
  STREAM_VIDEO_SECRET_KEY: z.string().min(1),
  NEXT_PUBLIC_STREAM_CHAT_API_KEY: z.string().min(1),
  STREAM_CHAT_SECRET_KEY: z.string().min(1)
});

export function validateEnv() {
  try {
    return envSchema.parse(process.env);
  } catch (error) {
    console.error('❌ Invalid environment variables:');
    console.error(error);
    process.exit(1);
  }
}

// Call at app startup
export const env = validateEnv();
```

Use in configuration files:

```typescript
// src/lib/stream-video.ts
import { env } from './env';

export const streamVideo = new StreamClient(
  env.NEXT_PUBLIC_STREAM_VIDEO_API_KEY,
  env.STREAM_VIDEO_SECRET_KEY
);
```

---

## Client Layer

### Key Files

- `src/trpc/client.tsx` - tRPC client setup
- `src/trpc/query-client.ts` - React Query configuration
- `src/modules/*/ui/components/*-form.tsx` - Form components
- `src/modules/*/ui/views/*.tsx` - View components
- `src/app/layout.tsx` - Root layout

### Issues Identified

#### 🔴 CRITICAL: No Global Error Boundary

**File:** `src/app/layout.tsx`

**Problem:**
Root layout has no error boundary. If any client component throws an uncaught error, the entire app crashes with white screen.

**Current Implementation:**

```typescript
export default function RootLayout({
  children
}: {
  children: React.ReactNode;
}) {
  return (
    <NuqsAdapter>
      <TRPCReactProvider>
        <html lang="en">
          <body className={`${inter.className} antialiased`}>
            <Toaster />
            {children}
          </body>
        </html>
      </TRPCReactProvider>
    </NuqsAdapter>
  );
}
```

**Fix:**

```typescript
// src/components/global-error-boundary.tsx
'use client';

import { ErrorState } from './error-state';
import { Button } from './ui/button';
import { Component, ReactNode } from 'react';
import { logError } from '@/lib/error-monitoring';

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
    logError(
      error,
      {
        componentStack: errorInfo.componentStack,
        context: 'Global Error Boundary'
      },
      'fatal'
    );
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="flex h-screen items-center justify-center">
          <ErrorState
            title="Something went wrong"
            description="We're sorry, but something unexpected happened. Please try refreshing the page."
          />
          <div className="mt-4">
            <Button onClick={() => window.location.reload()}>
              Refresh Page
            </Button>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}
```

Update layout:

```typescript
import { GlobalErrorBoundary } from '@/components/global-error-boundary';

export default function RootLayout({
  children
}: {
  children: React.ReactNode;
}) {
  return (
    <NuqsAdapter>
      <TRPCReactProvider>
        <html lang="en">
          <body className={`${inter.className} antialiased`}>
            <GlobalErrorBoundary>
              <Toaster />
              {children}
            </GlobalErrorBoundary>
          </body>
        </html>
      </TRPCReactProvider>
    </NuqsAdapter>
  );
}
```

#### 🟡 MAJOR: React Query Has No Default Error Handling

**File:** `src/trpc/query-client.ts`

**Problem:**
No default error handler for failed queries. Users see loading state indefinitely or nothing happens.

**Current Implementation:**

```typescript
export function makeQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 30 * 1000
      }
      // No error handling configured
    }
  });
}
```

**Fix:**

```typescript
import { toast } from 'sonner';
import { TRPCClientError } from '@trpc/client';
import { logError } from '@/lib/error-monitoring';

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
        },
        onError: error => {
          // Log error
          logError(error as Error, { context: 'React Query' });

          // Don't show toast for every query error (too noisy)
          // Let components handle their own error display
        }
      },
      mutations: {
        retry: false, // Never retry mutations
        onError: error => {
          // Log mutation errors
          logError(error as Error, { context: 'Mutation Error' });

          // Show generic toast for unexpected errors
          if (error instanceof TRPCClientError) {
            if (error.data?.code === 'INTERNAL_SERVER_ERROR') {
              toast.error('Something went wrong. Please try again.');
            }
          } else {
            toast.error('An unexpected error occurred');
          }
        }
      }
    }
  });
}
```

#### 🟡 MAJOR: Query/Mutation Errors Not Consistently Handled

**Files:**

- `src/modules/agents/ui/views/agents-view.tsx`
- `src/modules/meetings/ui/views/meetings-view.tsx`

**Problem:**
Views use `useSuspenseQuery` but generic error fallbacks don't show specific error information.

**Current Implementation:**

```typescript
export const AgentsViewError = () => {
  return (
    <ErrorState
      title="Error Loading Agents"
      description="Something went wrong" // Not helpful!
    />
  );
};
```

**Fix:**

Create error component that accepts error object:

```typescript
// src/components/query-error-state.tsx
'use client';

import { ErrorState } from './error-state';
import { Button } from './ui/button';
import { TRPCClientError } from '@trpc/client';

interface Props {
  error: Error;
  reset?: () => void;
  entityName?: string;
}

export function QueryErrorState({ error, reset, entityName = 'data' }: Props) {
  let title = `Error Loading ${entityName}`;
  let description = 'Something went wrong. Please try again.';

  if (error instanceof TRPCClientError) {
    if (error.data?.code === 'UNAUTHORIZED') {
      title = 'Authentication Required';
      description = 'Please sign in to access this content.';
    } else if (error.data?.code === 'FORBIDDEN') {
      title = 'Access Denied';
      description = 'You do not have permission to access this content.';
    } else if (error.data?.code === 'NOT_FOUND') {
      title = `${entityName} Not Found`;
      description = `The ${entityName.toLowerCase()} you're looking for doesn't exist.`;
    } else if (error.message) {
      description = error.message;
    }
  }

  return (
    <div className="flex flex-col items-center gap-4">
      <ErrorState title={title} description={description} />
      {reset && (
        <Button onClick={reset} variant="outline">
          Try Again
        </Button>
      )}
    </div>
  );
}
```

Update error boundaries:

```typescript
// In page components
<ErrorBoundary
  fallbackRender={({ error, resetErrorBoundary }) => (
    <QueryErrorState
      error={error}
      reset={resetErrorBoundary}
      entityName="Agents"
    />
  )}
>
  <AgentsView />
</ErrorBoundary>
```

#### 🔵 MINOR: Loading States Missing for Mutations

**Files:** All form components

**Problem:**
Forms disable submit button during mutations but don't show loading indicators inside the button.

**Current Implementation:**

```typescript
<Button disabled={isPending} type="submit">
  {isEdit ? 'Update' : 'Create'}
</Button>
```

**Fix:**

```typescript
import { Loader2 } from 'lucide-react';

<Button disabled={isPending} type="submit">
  {isPending && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
  {isEdit ? 'Update' : 'Create'}
</Button>;
```

#### 🔵 MINOR: No Network Error Detection

**Problem:** When offline, queries fail but user doesn't know why.

**Fix:**

```typescript
// src/hooks/use-online-status.ts
'use client';

import { useEffect, useState } from 'react';
import { toast } from 'sonner';

export function useOnlineStatus() {
  const [isOnline, setIsOnline] = useState(
    typeof navigator !== 'undefined' ? navigator.onLine : true
  );

  useEffect(() => {
    function handleOnline() {
      setIsOnline(true);
      toast.success('Connection restored');
    }

    function handleOffline() {
      setIsOnline(false);
      toast.error('No internet connection', {
        duration: Infinity,
        id: 'offline-toast'
      });
    }

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  return isOnline;
}
```

Add to layout:

```typescript
// src/components/network-status-monitor.tsx
'use client';

import { useOnlineStatus } from '@/hooks/use-online-status';
import { useEffect } from 'react';

export function NetworkStatusMonitor() {
  useOnlineStatus(); // Just needs to be mounted
  return null;
}
```

---

## User Feedback Layer

### Key Files

- `src/components/error-state.tsx` - Error display component
- `src/components/loading-state.tsx` - Loading display
- `src/components/empty-state.tsx` - Empty state display
- Forms and dialogs

### Issues Identified

#### 🟡 MAJOR: Error Messages Are Too Generic

**Files:** Most error handling code

**Problem:**
Error messages don't provide actionable information:

- "Something went wrong" (not helpful)
- No guidance on how to fix the issue
- No error codes for support

**Examples:**

```typescript
// In agents-view.tsx
description = 'Something went wrong'; // ❌

// In error handlers
toast.error(error.message); // ❌ Raw error message might be technical
```

**Fix:**

Create user-friendly error message utility:

```typescript
// src/lib/error-messages.ts
import { TRPCClientError } from '@trpc/client';

interface UserFriendlyError {
  title: string;
  message: string;
  action?: string;
  errorCode?: string;
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
            "The item you're looking for doesn't exist or has been deleted.",
          action: 'Go Back'
        };

      case 'BAD_REQUEST':
        return {
          title: 'Invalid Input',
          message: error.message || 'Please check your input and try again.'
        };

      case 'INTERNAL_SERVER_ERROR':
        return {
          title: 'Server Error',
          message:
            "We're experiencing technical difficulties. Please try again in a few moments.",
          errorCode: error.data?.code
        };

      case 'TIMEOUT':
        return {
          title: 'Request Timeout',
          message:
            'The request took too long. Please check your connection and try again.'
        };

      default:
        return {
          title: 'Something Went Wrong',
          message:
            'An unexpected error occurred. If this persists, please contact support.',
          errorCode: error.data?.code
        };
    }
  }

  if (error instanceof Error) {
    // Network errors
    if (error.message.includes('fetch')) {
      return {
        title: 'Connection Error',
        message:
          'Unable to connect to the server. Please check your internet connection.'
      };
    }

    return {
      title: 'Error',
      message: error.message || 'An unexpected error occurred.'
    };
  }

  return {
    title: 'Unknown Error',
    message: 'An unexpected error occurred. Please try again.'
  };
}
```

Use in error handlers:

```typescript
import { getUserFriendlyError } from '@/lib/error-messages';

onError: error => {
  const friendly = getUserFriendlyError(error);
  toast.error(friendly.message, {
    description: friendly.errorCode
      ? `Error Code: ${friendly.errorCode}`
      : undefined
  });

  if (friendly.action === 'View Plans') {
    router.push('/upgrade');
  }
};
```

#### 🔵 MINOR: No Success Feedback Consistency

**Problem:**
Some mutations show success toasts, others don't. Inconsistent UX.

**Fix:**

Add consistent success feedback:

```typescript
// In all mutation handlers
onSuccess: async () => {
  // Invalidate queries...

  toast.success(
    isEdit ? 'Agent updated successfully' : 'Agent created successfully',
    {
      description: isEdit ? 'Your changes have been saved.' : undefined
    }
  );

  onSuccess?.();
};
```

#### 🔵 MINOR: Form Validation Errors Not User-Friendly

**Problem:**
Zod error messages are sometimes technical.

**Example:**

```typescript
const agentsInsertSchema = z.object({
  name: z.string().min(1), // Error: "String must contain at least 1 character(s)"
  instructions: z.string().min(1)
});
```

**Fix:**

```typescript
const agentsInsertSchema = z.object({
  name: z.string().min(1, 'Agent name is required'),
  instructions: z
    .string()
    .min(10, 'Instructions must be at least 10 characters')
    .max(2000, 'Instructions must be less than 2000 characters')
});
```

---

## Key Files & Components

### Critical Error Handling Files

| File                           | Purpose         | Current State           |
| ------------------------------ | --------------- | ----------------------- |
| `src/db/index.ts`              | DB connection   | ❌ No error handling    |
| `src/trpc/init.ts`             | tRPC setup      | ⚠️ Basic error handling |
| `src/trpc/query-client.ts`     | Query config    | ❌ No error config      |
| `src/app/layout.tsx`           | Root layout     | ❌ No error boundary    |
| `src/app/api/webhook/route.ts` | Webhooks        | ⚠️ Partial handling     |
| `src/inngest/functions.ts`     | Background jobs | ❌ No error handling    |

### Key Components

| Component      | Location                                              | Purpose         |
| -------------- | ----------------------------------------------------- | --------------- |
| `ErrorState`   | `src/components/error-state.tsx`                      | Display errors  |
| `LoadingState` | `src/components/loading-state.tsx`                    | Display loading |
| `AgentForm`    | `src/modules/agents/ui/components/agent-form.tsx`     | Agent CRUD      |
| `MeetingForm`  | `src/modules/meetings/ui/components/meeting-form.tsx` | Meeting CRUD    |

### Key Hooks

| Hook                 | Location                                             | Purpose              |
| -------------------- | ---------------------------------------------------- | -------------------- |
| `useTRPC`            | `src/trpc/client.tsx`                                | tRPC client access   |
| `useAgentsFilters`   | `src/modules/agents/hooks/use-agents-filters.ts`     | Filter state         |
| `useMeetingsFilters` | `src/modules/meetings/hooks/use-meetings-filters.ts` | Filter state         |
| `useConfirm`         | `src/hooks/use-confirm.tsx`                          | Confirmation dialogs |

### Key Functions

| Function               | Location           | Purpose          |
| ---------------------- | ------------------ | ---------------- |
| `protectedProcedure`   | `src/trpc/init.ts` | Auth middleware  |
| `premiumProcedure`     | `src/trpc/init.ts` | Premium check    |
| `getUserFriendlyError` | To be created      | Error formatting |
| `withRetry`            | To be created      | Retry logic      |
| `logError`             | To be created      | Error logging    |

---

## Recommendations Summary

### Immediate Actions (Critical Priority)

1. **Add database connection error handling** (`src/db/index.ts`)

   - Validate DATABASE_URL
   - Add connection pooling
   - Handle connection failures gracefully

2. **Add global error boundary** (`src/app/layout.tsx`)

   - Catch all unhandled React errors
   - Prevent white screen crashes

3. **Add error monitoring** (All layers)

   - Integrate Sentry or similar
   - Log all errors with context
   - Set up alerting

4. **Add external API error handling**
   - Wrap Stream API calls with retry logic
   - Handle OpenAI API failures
   - Handle Polar API failures

### Short-term Actions (Major Priority)

5. **Add database transactions** for complex operations
6. **Fix webhook error handling** with proper status codes
7. **Add Inngest function error handling**
8. **Configure React Query defaults** for error handling
9. **Improve error messages** to be user-friendly
10. **Add query error components** with specific error information

### Long-term Improvements (Minor Priority)

11. **Add network status monitoring**
12. **Add loading indicators** to mutation buttons
13. **Standardize success feedback** across all mutations
14. **Improve form validation messages**
15. **Add error recovery actions** (retry buttons, etc.)
16. **Add environment variable validation**

---

## Testing Recommendations

### Error Scenarios to Test

1. **Database Errors**

   - [ ] Connection refused
   - [ ] Query timeout
   - [ ] Constraint violations
   - [ ] Transaction rollback

2. **API Errors**

   - [ ] Network failures
   - [ ] Timeout
   - [ ] Rate limiting
   - [ ] Invalid responses

3. **Authentication Errors**

   - [ ] Expired session
   - [ ] Invalid credentials
   - [ ] Missing permissions

4. **Validation Errors**

   - [ ] Invalid form input
   - [ ] Missing required fields
   - [ ] Type mismatches

5. **External Service Failures**
   - [ ] Stream API down
   - [ ] OpenAI API errors
   - [ ] Polar API issues

---

## Monitoring & Alerting

### Metrics to Track

1. **Error Rate**

   - Errors per minute
   - Error types distribution
   - Failed request percentage

2. **Response Times**

   - API endpoint latency
   - Database query times
   - External API calls

3. **User Impact**
   - Failed user actions
   - Error pages viewed
   - User dropoff on errors

### Alert Thresholds

- **Critical**: Error rate > 10% of requests
- **Warning**: Response time > 3 seconds
- **Info**: New error types detected

---

## Conclusion

The application currently has **4 critical**, **7 major**, and **5 minor** error handling issues. The most urgent fixes are:

1. Database connection error handling
2. Global error boundary
3. Error monitoring setup
4. External API error handling

Implementing these fixes will significantly improve application reliability, user experience, and debuggability.

---

**Last Updated:** November 7, 2025
**Reviewed By:** AI Code Analysis
**Next Review:** After implementing critical fixes
