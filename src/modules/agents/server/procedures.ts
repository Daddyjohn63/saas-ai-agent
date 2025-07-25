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
import { agentsInsertSchema, agentsUpdateSchema } from '../schema';
import { and, eq, getTableColumns, ilike, sql, desc, count } from 'drizzle-orm';
import {
  DEFAULT_PAGE,
  DEFAULT_PAGE_SIZE,
  MAX_PAGE_SIZE,
  MIN_PAGE_SIZE
} from '@/constants';
import { TRPCError } from '@trpc/server';
//import { TRPCError } from '@trpc/server';

export const agentsRouter = createTRPCRouter({
  update: protectedProcedure
    .input(agentsUpdateSchema)
    .mutation(async ({ ctx, input }) => {
      const [updatedAgent] = await db
        .update(agents)
        .set(input)
        .where(
          and(eq(agents.id, input.id), eq(agents.userId, ctx.auth.user.id))
        )
        .returning();

      if (!updatedAgent) {
        throw new TRPCError({
          code: 'NOT_FOUND',
          message: 'Agent not found'
        });
      }
      return updatedAgent;
    }),
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
        throw new TRPCError({
          code: 'NOT_FOUND',
          message: 'Agent not found'
        });
      }
      return removedAgent;
    }),
  getOne: protectedProcedure
    .input(z.object({ id: z.string() }))
    .query(async ({ input, ctx }) => {
      const [existingAgent] = await db
        .select({
          //TODO: Change to actual count
          meetingCount: sql<number>`5`,
          ...getTableColumns(agents)
        })
        .from(agents)
        .where(
          and(eq(agents.id, input.id), eq(agents.userId, ctx.auth.user.id))
        );

      if (!existingAgent) {
        throw new TRPCError({ code: 'NOT_FOUND', message: 'Agent not found' });
      }
      return existingAgent;
    }),

  getMany: protectedProcedure
    .input(
      //search filters as input
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
          //TODO: Change to actual count
          meetingCount: sql<number>`5`,
          ...getTableColumns(agents)
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

      const totalPages = Math.ceil(total.count / pageSize);
      return {
        items: data,
        total: total.count,
        totalPages
      };
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
