# SaaS AI Agent Video Conference Platform

## Overview

This application is a sophisticated SaaS platform that enables users to create AI agents for specialized video conferencing sessions. Users can create agents (like language tutors), schedule meetings with them, and conduct video conferences. The platform automatically records, transcribes, and summarizes these sessions.

## Architecture

### Tech Stack

- **Frontend**: Next.js with TypeScript
- **Backend**: tRPC for type-safe API communication
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: Built-in auth system
- **Video Conferencing**: Stream Video API
- **Chat**: Stream Chat API
- **Background Processing**: Inngest
- **Testing**: Jest
- **UI Components**: Shadcn/UI

### Core Modules

1. **Agents Module** (`src/modules/agents/`)

   - Handles agent creation and management
   - Implements CRUD operations with type safety
   - Uses premium-gated features

2. **Meetings Module** (`src/modules/meetings/`)

   - Manages video conference scheduling
   - Handles real-time video/audio streaming
   - Processes recordings and transcriptions

3. **Auth Module** (`src/modules/auth/`)

   - Handles user authentication
   - Manages user sessions
   - Implements sign-in/sign-up flows

4. **Premium Module** (`src/modules/premium/`)
   - Manages subscription features
   - Handles premium feature gating
   - Processes upgrades

## Type Safety and API Layer

### tRPC Implementation

The application uses tRPC for end-to-end type safety. Here's an example of how types are inferred from the backend to frontend:

```typescript
// src/modules/agents/types.ts
export type AgentsGetMany =
  inferRouterOutputs<AppRouter>['agents']['getMany']['items'];
export type AgentGetOne = inferRouterOutputs<AppRouter>['agents']['getOne'];
```

### Protected Procedures

The application implements different levels of procedure protection:

```typescript
// src/modules/agents/server/procedures.ts
export const agentsRouter = createTRPCRouter({
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
    })
});
```

## Video Conference Implementation

### Meeting Creation

```typescript
// src/modules/meetings/server/procedures.ts
create: premiumProcedure('meetings').mutation(async ({ input, ctx }) => {
  // Create meeting record
  const [createdMeeting] = await db
    .insert(meetings)
    .values({
      ...input,
      userId: ctx.auth.user.id
    })
    .returning();

  // Initialize Stream video call
  const call = streamVideo.video.call('default', createdMeeting.id);
  await call.create({
    data: {
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
});
```

## Background Processing with Inngest

The application uses Inngest for processing meeting recordings and generating summaries:

```typescript
// src/inngest/functions.ts
export const meetingsProcessing = inngest.createFunction(
  { id: 'meetings/processing' },
  { event: 'meetings/processing' },
  async ({ event, step }) => {
    // Fetch and parse transcript
    const transcript = await step.run('parse-transcript', async () => {
      return JSONL.parse<StreamTranscriptItem>(response);
    });

    // Generate summary using AI
    const { output } = await summarizer.run(
      'Summarize the following transcript: ' +
        JSON.stringify(transcriptWithSpeakers)
    );

    // Save summary
    await step.run('save-summary', async () => {
      await db
        .update(meetings)
        .set({
          summary: output[0].content,
          status: 'completed'
        })
        .where(eq(meetings.id, event.data.meetingId));
    });
  }
);
```

## Security

1. **Authentication**

   - Protected routes and procedures
   - Session-based authentication
   - Role-based access control

2. **Data Access**

   - Row-level security with user ID filtering
   - Premium feature gating
   - Secure token generation for video/chat

3. **API Security**
   - Input validation with Zod schemas
   - Protected tRPC procedures
   - Secure environment variable handling

## Testing

The application uses Jest for testing, with a focus on component and integration tests:

- Unit tests for components
- Integration tests for forms and views
- API route testing
- Authentication flow testing

Example test files:

- `src/modules/agents/ui/views/new-agent-form.test.tsx`
- `src/modules/auth/ui/views/sign-in-view.test.tsx`

## Premium Features

The application implements a premium-gating system using custom tRPC procedures:

```typescript
// Premium-gated agent creation
create: premiumProcedure('agents')
  .input(agentsInsertSchema)
  .mutation(async ({ input, ctx }) => {
    // Implementation
  });
```

## Database Schema

The application uses Drizzle ORM with PostgreSQL, implementing the following main tables:

- `users`: User accounts and authentication
- `agents`: AI agent configurations
- `meetings`: Video conference sessions
- `subscriptions`: Premium feature access

## Error Handling

The application implements comprehensive error handling:

```typescript
if (!existingMeeting) {
  throw new TRPCError({
    code: 'NOT_FOUND',
    message: 'Meeting not found'
  });
}
```

## Real-time Features

1. **Video Conferencing**

   - Real-time video/audio streaming
   - Live transcription
   - Closed captions
   - HD recording (1080p)

2. **Chat**
   - Real-time messaging during meetings
   - User presence indicators
   - Message history

## Conclusion

This SaaS platform demonstrates a modern, type-safe architecture with premium features, real-time capabilities, and automated processing. It leverages cutting-edge technologies while maintaining security and scalability.
