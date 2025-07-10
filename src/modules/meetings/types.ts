import { inferRouterOutputs } from '@trpc/server';

import type { AppRouter } from '@/trpc/routers/_app';

export type MeetingGetMany =
  inferRouterOutputs<AppRouter>['meetings']['getMany']['items'];
export type MeetingGetOne = inferRouterOutputs<AppRouter>['meetings']['getOne'];
export enum MeetingStatus {
  Upcoming = 'upcoming',
  Active = 'active',
  Completed = 'completed',
  Processing = 'processing',
  Cancelled = 'cancelled'
}
export type StreamTranscriptItem = {
  speaker_id: string;
  type: string;
  text: string;
  start_ts: number;
  stop_ts: number;
};

// This is a utility type from tRPC. It takes your main router type (AppRouter) and produces a TypeScript type that represents the output (return value) of every procedure (endpoint) in your API.
// ['meetings']
// This accesses the sub-router or namespace called meetings within your main router.
// ['getMany']
// This accesses the specific procedure (endpoint) named getMany inside the meetings router.
// ['items']
// This accesses the items property of the return value of the getMany procedure.
// (Typically, a "getMany" endpoint returns an object like { items: [...], total: number, ... }.)
// What is the result?
// MeetingGetMany becomes the TypeScript type of the items array returned by your meetings.getMany endpoint.
// This means:
// If your backend changes what it returns from getMany, the type here will automatically update, keeping your frontend and backend in sync.
// Why is this useful?
// Type Safety: You don’t have to manually define or update types for your API responses. TypeScript will always know the exact shape of the data returned by your backend.
// DRY Principle: No duplication of types between backend and frontend.
// Refactoring: If you change the return type of getMany in your backend, TypeScript will catch any mismatches in your frontend code.
// In summary:
// This line creates a type alias (MeetingGetMany) for the array of meeting items returned by your meetings.getMany API endpoint, and it will always stay up-to-date with your backend’s actual return type.

// THIS IS PREFERRED RATHER THAN USING DB SCHEMA AS WE MIGHT NOT WANT TO RETURN ALL THE DB FIELDS.
