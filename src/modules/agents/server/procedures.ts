// Purpose of procedures.ts in tRPC
// Defines Procedures (Endpoints):
// It exports functions (procedures) that represent the API endpoints for the "agents" module. These can be queries (for fetching data) or mutations (for modifying data).
// Validation & Input Types:
// Each procedure often includes input validation (using libraries like Zod) to ensure correct data is received.
// Business Logic:
// The procedures contain or call the business logic for handling requests related to agents (e.g., createAgent, getAgent, updateAgent, deleteAgent).
// Integration with Routers:
// The procedures defined here are typically imported into a router.ts file _app.ts, where they are combined into a tRPC router for the module.
import { z } from 'zod';
import { db } from '@/db';
import { agents } from '@/db/schema';
import { createTRPCRouter, protectedProcedure } from '@/trpc/init';
import { agentsInsertSchema } from '../schema';
import { eq } from 'drizzle-orm';
//import { TRPCError } from '@trpc/server';

export const agentsRouter = createTRPCRouter({
  getOne: protectedProcedure
    .input(z.object({ id: z.string() }))
    .query(async ({ input }) => {
      const [existingAgent] = await db
        .select()
        .from(agents)
        .where(eq(agents.id, input.id));
      return existingAgent;
    }),

  getMany: protectedProcedure.query(async () => {
    const data = await db.select().from(agents);
    //await new Promise(resolve => setTimeout(resolve, 5000));
    //throw new TRPCError({ code: 'BAD_REQUEST' });

    return data;
  }),
  create: protectedProcedure
    .input(agentsInsertSchema)
    .mutation(async ({ input, ctx }) => {
      //we destrucutre using array, as drizzle always return an array. here we are safe to return the first record from the array, as there will only be one.
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
