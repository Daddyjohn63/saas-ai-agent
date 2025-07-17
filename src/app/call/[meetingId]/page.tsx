/**
 * Call Page Component
 *
 * This is the main page component for video calls. It handles:
 * - Authentication verification (redirects to sign-in if not authenticated)
 * - Meeting data prefetching using tRPC
 * - Server-side rendering with hydration boundary
 * - Rendering the CallView component with the meeting ID
 *
 * This component acts as the entry point for all video call functionality,
 * ensuring users are authenticated and meeting data is available before
 * initializing the Stream Video SDK.
 */

import { headers } from 'next/headers';
import { redirect } from 'next/navigation';
import { dehydrate, HydrationBoundary } from '@tanstack/react-query';

import { auth } from '@/lib/auth';
import { getQueryClient, trpc } from '@/trpc/server';

import { CallView } from '@/modules/call/ui/views/call-view';

interface Props {
  params: Promise<{
    meetingId: string;
  }>;
}

const Page = async ({ params }: Props) => {
  // Extract meeting ID from dynamic route parameters
  const { meetingId } = await params;

  // Get user session from request headers (server-side authentication)
  const session = await auth.api.getSession({
    headers: await headers()
  });

  // Redirect to sign-in if user is not authenticated
  if (!session) {
    redirect('/sign-in');
  }

  // Get React Query client for data prefetching
  const queryClient = getQueryClient();

  // Prefetch meeting data on the server to avoid loading states on client
  // This ensures the meeting data is available immediately when the page loads
  void queryClient.prefetchQuery(
    trpc.meetings.getOne.queryOptions({ id: meetingId })
  );

  // Render the page with hydrated data
  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <CallView meetingId={meetingId} />
    </HydrationBoundary>
  );
};

export default Page;
