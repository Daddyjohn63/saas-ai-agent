/**
 * Call Lobby Component
 *
 * This component handles the pre-call setup and preparation. It:
 * - Displays video preview with user avatar/placeholder
 * - Manages browser permissions for camera/microphone
 * - Provides audio/video toggle controls for testing
 * - Shows permission request message if needed
 * - Handles user authentication data for avatar display
 * - Provides join/cancel action buttons
 *
 * This component ensures users can properly configure their
 * devices and permissions before joining the actual call.
 */

import Link from 'next/link';
import { LogInIcon } from 'lucide-react';
import {
  DefaultVideoPlaceholder,
  StreamVideoParticipant,
  ToggleAudioPreviewButton,
  ToggleVideoPreviewButton,
  useCallStateHooks,
  VideoPreview
} from '@stream-io/video-react-sdk';

import { authClient } from '@/lib/auth-client';
import { Button } from '@/components/ui/button';
import { generateAvatarUri } from '@/lib/avatar';

import '@stream-io/video-react-sdk/dist/css/styles.css';

interface Props {
  onJoin: () => void;
}

// Component to show when video preview is disabled or unavailable
const DisabledVideoPreview = () => {
  // Get current user session data
  const { data } = authClient.useSession();

  return (
    <DefaultVideoPlaceholder
      participant={
        {
          name: data?.user.name ?? '',
          image:
            data?.user.image ??
            generateAvatarUri({
              seed: data?.user.name ?? '',
              variant: 'initials'
            })
        } as StreamVideoParticipant
      }
    />
  );
};

// Component to show when browser permissions are needed
const AllowBrowserPermissions = () => {
  return (
    <p className="text-sm">
      Please grant your browser a permission to access your camera and
      microphone.
    </p>
  );
};

export const CallLobby = ({ onJoin }: Props) => {
  // Get hooks for managing camera and microphone state
  const { useCameraState, useMicrophoneState } = useCallStateHooks();

  // Check if browser has granted camera and microphone permissions
  const { hasBrowserPermission: hasMicPermission } = useMicrophoneState();
  const { hasBrowserPermission: hasCameraPermission } = useCameraState();

  // Determine if we have all necessary media permissions
  const hasBrowserMediaPermission = hasCameraPermission && hasMicPermission;

  return (
    <div className="flex flex-col items-center justify-center h-full bg-radial from-sidebar-accent to-sidebar">
      <div className="py-4 px-8 flex flex-1 items-center justify-center">
        <div className="flex flex-col items-center justify-center gap-y-6 bg-background rounded-lg p-10 shadow-sm">
          {/* Header section with title and description */}
          <div className="flex flex-col gap-y-2 text-center">
            <h6 className="text-lg font-medium">Ready to join?</h6>
            <p className="text-sm">Set up your call before joining</p>
          </div>

          {/* Video preview area - shows user's camera feed or placeholder */}
          <VideoPreview
            DisabledVideoPreview={
              hasBrowserMediaPermission
                ? DisabledVideoPreview // Show user avatar if permissions granted
                : AllowBrowserPermissions // Show permission request if not granted
            }
          />

          {/* Device control buttons - allow users to test audio/video */}
          <div className="flex gap-x-2">
            <ToggleAudioPreviewButton />
            <ToggleVideoPreviewButton />
          </div>

          {/* Action buttons - cancel or join call */}
          <div className="flex gap-x-2 justify-between w-full">
            <Button asChild variant="ghost">
              <Link href="/meetings">Cancel</Link>
            </Button>
            <Button onClick={onJoin}>
              <LogInIcon />
              Join Call
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
};
