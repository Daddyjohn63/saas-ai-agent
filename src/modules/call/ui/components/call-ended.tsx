/**
 * Call Ended Component
 *
 * This component displays the post-call interface. It:
 * - Shows confirmation that the call has ended
 * - Informs users that meeting summary will be available soon
 * - Provides navigation back to meetings list
 * - Maintains consistent styling with the call interface
 *
 * This component provides closure to the call experience
 * and guides users back to the main application flow.
 */

import Link from 'next/link';

import { Button } from '@/components/ui/button';

export const CallEnded = () => {
  return (
    <div className="flex flex-col items-center justify-center h-full bg-radial from-sidebar-accent to-sidebar">
      <div className="py-4 px-8 flex flex-1 items-center justify-center">
        <div className="flex flex-col items-center justify-center gap-y-6 bg-background rounded-lg p-10 shadow-sm">
          {/* Message section confirming call has ended */}
          <div className="flex flex-col gap-y-2 text-center">
            <h6 className="text-lg font-medium">You have ended the call</h6>
            <p className="text-sm">Summary will appear in a few minutes.</p>
          </div>

          {/* Navigation button to return to meetings list */}
          <Button asChild>
            <Link href="/meetings">Back to meetings</Link>
          </Button>
        </div>
      </div>
    </div>
  );
};
