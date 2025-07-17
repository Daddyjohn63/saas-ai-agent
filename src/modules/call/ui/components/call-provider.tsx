/**
 * Call Provider Component
 *
 * This component acts as a session provider for video calls. It:
 * - Manages user authentication state using authClient
 * - Shows loading state while session is being fetched
 * - Extracts user data (id, name, image) from session
 * - Generates fallback avatar if user has no profile image
 * - Renders CallConnect with user information
 *
 * This component ensures that user session data is available
 * before initializing the Stream Video client.
 */

'use client';

import { LoaderIcon } from 'lucide-react';

import { authClient } from '@/lib/auth-client';
import { generateAvatarUri } from '@/lib/avatar';

import { CallConnect } from './call-connect';

interface Props {
  meetingId: string;
  meetingName: string;
}

export const CallProvider = ({ meetingId, meetingName }: Props) => {
  // Get user session data using auth client
  // This will automatically handle authentication state
  const { data, isPending } = authClient.useSession();

  // Show loading spinner while session is being fetched
  // This prevents rendering call interface without user data
  if (!data || isPending) {
    return (
      <div className="flex h-screen items-center justify-center bg-radial from-sidebar-accent to-sidebar">
        <LoaderIcon className="size-6 animate-spin text-white" />
      </div>
    );
  }

  // Render call connect component with user information
  // Generate fallback avatar if user doesn't have a profile image
  return (
    <CallConnect
      meetingId={meetingId}
      meetingName={meetingName}
      userId={data.user.id}
      userName={data.user.name}
      userImage={
        data.user.image ??
        generateAvatarUri({ seed: data.user.name, variant: 'initials' })
      }
    />
  );
};
