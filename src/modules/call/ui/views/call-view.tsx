/**
 * Call View Component
 *
 * This component serves as the main view layer for video calls. It:
 * - Fetches meeting data using tRPC with suspense
 * - Validates meeting status (prevents joining completed meetings)
 * - Renders error state for completed meetings
 * - Renders CallProvider for active meetings
 *
 * This component acts as a gatekeeper, ensuring only valid meetings
 * can proceed to the actual video call interface.
 */

'use client';

import { useSuspenseQuery } from '@tanstack/react-query';

import { useTRPC } from '@/trpc/client';
import { ErrorState } from '@/components/error-state';

import { CallProvider } from '../components/call-provider';

interface Props {
  meetingId: string;
}

export const CallView = ({ meetingId }: Props) => {
  // Get tRPC client for data fetching
  const trpc = useTRPC();

  // Fetch meeting data with suspense (will suspend until data is available)
  // This ensures we have meeting information before rendering anything
  const { data } = useSuspenseQuery(
    trpc.meetings.getOne.queryOptions({ id: meetingId })
  );

  // Check if meeting has already been completed
  // If so, show error state instead of allowing join
  if (data.status === 'completed') {
    return (
      <div className="flex h-screen items-center justify-center">
        <ErrorState
          title="Meeting has ended"
          description="You can no longer join this meeting"
        />
      </div>
    );
  }

  // If meeting is active, render the call provider with meeting details
  return <CallProvider meetingId={meetingId} meetingName={data.name} />;
};
