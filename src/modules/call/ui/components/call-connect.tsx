/**
 * Call Connect Component
 *
 * This component handles the Stream Video SDK initialization and connection. It:
 * - Creates and manages StreamVideoClient with user data
 * - Generates authentication tokens using tRPC mutation
 * - Initializes call instance with meeting ID
 * - Manages call lifecycle (join, leave, end)
 * - Handles camera/microphone initial state (disabled)
 * - Provides loading state during client initialization
 * - Wraps CallUI with StreamVideo and StreamCall providers
 *
 * This is the core component that bridges the application with
 * the Stream Video SDK, handling all SDK-specific setup and teardown.
 */

'use client';

import { LoaderIcon } from 'lucide-react';
import { useEffect, useState } from 'react';
import { useMutation } from '@tanstack/react-query';
import {
  Call,
  CallingState,
  StreamCall,
  StreamVideo,
  StreamVideoClient
} from '@stream-io/video-react-sdk';

import { useTRPC } from '@/trpc/client';

import '@stream-io/video-react-sdk/dist/css/styles.css';
import { CallUI } from './call-ui';
//import { CallUI } from "./call-ui";

interface Props {
  meetingId: string;
  meetingName: string;
  userId: string;
  userName: string;
  userImage: string;
}

export const CallConnect = ({
  meetingId,
  meetingName,
  userId,
  userName,
  userImage
}: Props) => {
  // Get tRPC client for API calls
  const trpc = useTRPC();

  // Create mutation for generating Stream authentication tokens
  // This will be called by the Stream client when it needs a fresh token
  const { mutateAsync: generateToken } = useMutation(
    trpc.meetings.generateToken.mutationOptions()
  );

  // State to hold the Stream Video client instance
  const [client, setClient] = useState<StreamVideoClient>();

  // Initialize Stream Video client when component mounts or user data changes
  useEffect(() => {
    // Create new Stream Video client with user information and token provider
    const _client = new StreamVideoClient({
      apiKey: process.env.NEXT_PUBLIC_STREAM_VIDEO_API_KEY!, // Stream API key from environment
      user: {
        id: userId,
        name: userName,
        image: userImage
      },
      tokenProvider: generateToken // Function that generates authentication tokens
    });

    // Store client in state
    setClient(_client);

    // Cleanup function: disconnect user when component unmounts or dependencies change
    return () => {
      _client.disconnectUser();
      setClient(undefined);
    };
  }, [userName, userId, userImage, generateToken]); // Re-run when user data or token function changes

  // State to hold the call instance
  const [call, setCall] = useState<Call>();

  // Initialize call instance when client is ready
  useEffect(() => {
    if (!client) return; // Wait for client to be initialized

    // Create call instance with meeting ID
    const _call = client.call('default', meetingId);

    // Disable camera and microphone initially
    // Users will enable them in the lobby before joining
    _call.camera.disable();
    _call.microphone.disable();

    // Store call in state
    setCall(_call);

    // Cleanup function: properly leave and end call when component unmounts
    return () => {
      // Only cleanup if call hasn't already been left
      if (_call.state.callingState !== CallingState.LEFT) {
        _call.leave();
        _call.endCall();
        setCall(undefined);
      }
    };
  }, [client, meetingId]); // Re-run when client or meeting ID changes

  // Show loading spinner while client and call are being initialized
  if (!client || !call) {
    return (
      <div className="flex h-screen items-center justify-center bg-radial from-sidebar-accent to-sidebar">
        <LoaderIcon className="size-6 animate-spin text-white" />
      </div>
    );
  }

  // Render Stream Video providers and call UI
  return (
    <StreamVideo client={client}>
      <StreamCall call={call}>
        <CallUI meetingName={meetingName} />
      </StreamCall>
    </StreamVideo>
  );
};
