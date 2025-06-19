import { inferRouterOutputs } from '@trpc/server';

import type { AppRouter } from '@/trpc/routers/_app';

export type AgentGetOne = inferRouterOutputs<AppRouter>['agents']['getOne'];

// Here's what's happening:
// inferRouterOutputs is a utility type from tRPC that extracts the return types of all your router procedures. It looks at what your procedures return and creates TypeScript types for those return values.
// AppRouter is your main tRPC router type (likely defined in _app.ts) that contains all your sub-routers, including the agents router.
// The type AgentsGetOne is being defined as the return type of the getOne procedure from the agents router. Breaking down the syntax:
// inferRouterOutputs<AppRouter> gets all output types from all procedures
// ['agents'] accesses the types from the agents router
// ['getOne'] specifically gets the return type of the getOne procedure
// Looking at your procedures.ts, this would correspond to the return type of this procedure:
// So AgentsGetOne would be the type of existingAgent, which would be a single agent record from your database based on your schema.
// This is a common pattern in tRPC applications where you want to reuse the types that are automatically inferred from your backend procedures in your frontend code, ensuring complete type safety across your full-stack application.

// THIS IS PREFERRED RATHER THAN USING DB SCHEMA AS WE MIGHT NOT WANT TO RETURN ALL THE DB FIELDS.
