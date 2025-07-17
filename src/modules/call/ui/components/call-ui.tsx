/**
 * Call UI Component
 *
 * This component serves as the main UI controller for video calls. It:
 * - Manages call state transitions (lobby → call → ended)
 * - Handles join/leave call actions
 * - Renders appropriate UI based on current state:
 *   - CallLobby: Pre-call setup and permissions
 *   - CallActive: Active video call interface
 *   - CallEnded: Post-call summary screen
 * - Wraps everything in StreamTheme for consistent styling
 *
 * This component orchestrates the user experience flow through
 * different stages of a video call session.
 */

import { useState } from 'react';
import { StreamTheme, useCall } from '@stream-io/video-react-sdk';

import { CallLobby } from './call-lobby';
import { CallActive } from './call-active';
import { CallEnded } from './call-ended';

interface Props {
  meetingName: string;
}

export const CallUI = ({ meetingName }: Props) => {
  // Get call instance from Stream Video context
  const call = useCall();

  // State to track which call stage we're in
  // "lobby" = pre-call setup, "call" = active call, "ended" = post-call
  const [show, setShow] = useState<'lobby' | 'call' | 'ended'>('lobby');

  // Handler for when user clicks "Join Call" in lobby
  const handleJoin = async () => {
    if (!call) return; // Safety check

    // Join the call using Stream Video SDK
    await call.join();

    // Transition to active call state
    setShow('call');
  };

  // Handler for when user leaves the call
  const handleLeave = () => {
    if (!call) return; // Safety check

    // End the call using Stream Video SDK
    call.endCall();

    // Transition to ended state
    setShow('ended');
  };

  // Render the appropriate UI based on current call state
  return (
    <StreamTheme className="h-full">
      {/* Show lobby for pre-call setup and device configuration */}
      {show === 'lobby' && <CallLobby onJoin={handleJoin} />}

      {/* Show active call interface with video and controls */}
      {show === 'call' && (
        <CallActive onLeave={handleLeave} meetingName={meetingName} />
      )}

      {/* Show ended state with summary and navigation */}
      {show === 'ended' && <CallEnded />}
    </StreamTheme>
  );
};
