/**
 * Call Active Component
 *
 * This component renders the active video call interface. It:
 * - Displays the main video call layout with SpeakerLayout
 * - Shows meeting name and logo in the header
 * - Provides call controls (mute, camera, leave, etc.)
 * - Handles call termination via onLeave callback
 * - Maintains consistent styling with dark theme
 *
 * This component represents the core video call experience
 * where users can see and interact with other participants.
 */

import Link from 'next/link';
import Image from 'next/image';
import { CallControls, SpeakerLayout } from '@stream-io/video-react-sdk';

interface Props {
  onLeave: () => void;
  meetingName: string;
}

export const CallActive = ({ onLeave, meetingName }: Props) => {
  return (
    <div className="flex flex-col justify-between p-4 h-full text-white">
      {/* Header section with logo and meeting name */}
      <div className="bg-[#101213] rounded-full p-4 flex items-center gap-4">
        {/* Logo link that navigates back to home */}
        <Link
          href="/"
          className="flex items-center justify-center p-1 bg-white/10 rounded-full w-fit"
        >
          <Image src="/logo.svg" width={22} height={22} alt="Logo" />
        </Link>
        {/* Display current meeting name */}
        <h4 className="text-base">{meetingName}</h4>
      </div>

      {/* Main video area - displays all participants in a grid layout */}
      <SpeakerLayout />

      {/* Call controls at the bottom - mute, camera, leave, etc. */}
      <div className="bg-[#101213] rounded-full px-4">
        <CallControls onLeave={onLeave} />
      </div>
    </div>
  );
};
