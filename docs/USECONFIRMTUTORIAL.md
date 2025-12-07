# Complete Tutorial: Implementing a Confirmation Dialog System

This tutorial will guide you through building a production-ready confirmation dialog system from scratch. By the end, you'll have a reusable, responsive confirmation dialog that works across your entire application.

## Table of Contents

- [Prerequisites](#prerequisites)
- [What We're Building](#what-were-building)
- [Step 1: Setting Up the Project Structure](#step-1-setting-up-the-project-structure)
- [Step 2: Creating the useIsMobile Hook](#step-2-creating-the-useismobile-hook)
- [Step 3: Building the ResponsiveDialog Component](#step-3-building-the-responsivedialog-component)
- [Step 4: Implementing the useConfirm Hook](#step-4-implementing-the-useconfirm-hook)
- [Step 5: Using the Confirmation Dialog](#step-5-using-the-confirmation-dialog)
- [Step 6: Advanced Use Cases](#step-6-advanced-use-cases)
- [Testing Your Implementation](#testing-your-implementation)
- [Common Pitfalls and Solutions](#common-pitfalls-and-solutions)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before starting, ensure you have:

- React 18+ installed
- TypeScript configured
- shadcn/ui components installed:
  - Dialog
  - Drawer
  - Button
- Basic understanding of React hooks and Promises

### Installing Required Dependencies

```bash
# Install shadcn/ui components
npx shadcn-ui@latest add dialog
npx shadcn-ui@latest add drawer
npx shadcn-ui@latest add button
```

## What We're Building

We'll create three interconnected pieces:

1. **useIsMobile Hook** - Detects if the user is on a mobile device
2. **ResponsiveDialog Component** - Renders Dialog on desktop, Drawer on mobile
3. **useConfirm Hook** - Manages confirmation state and provides a clean API

**Final API:**

```typescript
const [ConfirmDialog, confirm] = useConfirm(
  'Delete Item?',
  'This cannot be undone'
);

const handleDelete = async () => {
  const confirmed = await confirm();
  if (confirmed) {
    // Delete the item
  }
};
```

## Step 1: Setting Up the Project Structure

Create the following directory structure:

```
src/
├── hooks/
│   ├── use-confirm.tsx
│   └── use-mobile.tsx
└── components/
    └── ui/
        └── responsive-dialog.tsx
```

## Step 2: Creating the useIsMobile Hook

This hook detects if the user is on a mobile device and handles window resizing.

**File: `src/hooks/use-mobile.tsx`**

```typescript
import { useEffect, useState } from 'react';

/**
 * Hook to detect if the user is on a mobile device
 * Returns true if viewport width is less than 768px
 */
export function useIsMobile(): boolean {
  const [isMobile, setIsMobile] = useState<boolean>(false);

  useEffect(() => {
    // Create a MediaQueryList object
    const mediaQuery = window.matchMedia('(max-width: 768px)');

    // Set initial value
    setIsMobile(mediaQuery.matches);

    // Define callback function for when the media query changes
    const handleChange = (event: MediaQueryListEvent) => {
      setIsMobile(event.matches);
    };

    // Add event listener
    mediaQuery.addEventListener('change', handleChange);

    // Cleanup function
    return () => {
      mediaQuery.removeEventListener('change', handleChange);
    };
  }, []);

  return isMobile;
}
```

**How it works:**

1. **MediaQuery**: Uses the native `matchMedia` API to check viewport width
2. **State**: Maintains boolean state for mobile/desktop
3. **Event Listener**: Updates when window is resized
4. **Cleanup**: Removes event listener on unmount
5. **Threshold**: 768px is the breakpoint (standard mobile/tablet boundary)

**Why this approach?**

- ✅ Efficient (uses native browser API)
- ✅ No layout thrashing
- ✅ Handles SSR gracefully
- ✅ Updates on window resize

## Step 3: Building the ResponsiveDialog Component

This component automatically switches between Dialog (desktop) and Drawer (mobile).

**File: `src/components/ui/responsive-dialog.tsx`**

````typescript
import React from 'react';
import { useIsMobile } from '@/hooks/use-mobile';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle
} from '@/components/ui/dialog';
import {
  Drawer,
  DrawerContent,
  DrawerDescription,
  DrawerHeader,
  DrawerTitle
} from '@/components/ui/drawer';

/**
 * Props for the ResponsiveDialog component
 */
interface ResponsiveDialogProps {
  /** Dialog title */
  title: string;
  /** Dialog description */
  description: string;
  /** Dialog content (typically buttons) */
  children: React.ReactNode;
  /** Whether the dialog is open */
  open: boolean;
  /** Callback when dialog open state changes */
  onOpenChange: (open: boolean) => void;
}

/**
 * A responsive dialog that renders as Dialog on desktop and Drawer on mobile
 *
 * @example
 * ```tsx
 * <ResponsiveDialog
 *   title="Delete Item"
 *   description="Are you sure?"
 *   open={isOpen}
 *   onOpenChange={setIsOpen}
 * >
 *   <Button>Confirm</Button>
 * </ResponsiveDialog>
 * ```
 */
export const ResponsiveDialog: React.FC<ResponsiveDialogProps> = ({
  title,
  description,
  children,
  open,
  onOpenChange
}) => {
  const isMobile = useIsMobile();

  // Render Drawer for mobile devices
  if (isMobile) {
    return (
      <Drawer open={open} onOpenChange={onOpenChange}>
        <DrawerContent>
          <DrawerHeader className="text-left">
            <DrawerTitle>{title}</DrawerTitle>
            <DrawerDescription>{description}</DrawerDescription>
          </DrawerHeader>
          <div className="px-4 pb-4">{children}</div>
        </DrawerContent>
      </Drawer>
    );
  }

  // Render Dialog for desktop devices
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
          <DialogDescription>{description}</DialogDescription>
        </DialogHeader>
        <div>{children}</div>
      </DialogContent>
    </Dialog>
  );
};
````

**Component Breakdown:**

1. **Props Interface**: Defines contract for the component
2. **Device Detection**: Uses `useIsMobile` to determine which UI to render
3. **Conditional Rendering**: Switches between Dialog and Drawer
4. **Consistent API**: Both components use the same props
5. **Styling**: Adds appropriate padding for mobile

**Key Design Decisions:**

- **Controlled Component**: Parent manages `open` state via `onOpenChange`
- **Uniform API**: Same props work for both Dialog and Drawer
- **Flexibility**: `children` prop allows custom content
- **Accessibility**: Uses semantic HTML and ARIA attributes from shadcn/ui

## Step 4: Implementing the useConfirm Hook

This is the core of our confirmation system. It manages state using Promises.

**File: `src/hooks/use-confirm.tsx`**

````typescript
import { useState } from 'react';
import { ResponsiveDialog } from '@/components/ui/responsive-dialog';
import { Button } from '@/components/ui/button';

/**
 * State shape for the Promise resolver
 */
interface ConfirmState {
  resolve: (value: boolean) => void;
}

/**
 * Hook for creating a reusable confirmation dialog
 *
 * @param title - The dialog title
 * @param description - The dialog description/message
 * @returns A tuple of [ConfirmationComponent, confirmFunction]
 *
 * @example
 * ```tsx
 * const [ConfirmDialog, confirm] = useConfirm(
 *   'Delete Item?',
 *   'This action cannot be undone'
 * );
 *
 * const handleDelete = async () => {
 *   const confirmed = await confirm();
 *   if (confirmed) {
 *     // Proceed with deletion
 *   }
 * };
 *
 * return (
 *   <>
 *     <ConfirmDialog />
 *     <Button onClick={handleDelete}>Delete</Button>
 *   </>
 * );
 * ```
 */
export const useConfirm = (
  title: string,
  description: string
): [() => JSX.Element, () => Promise<boolean>] => {
  // State holds the Promise resolver or null when closed
  const [promise, setPromise] = useState<ConfirmState | null>(null);

  /**
   * Opens the dialog and returns a Promise
   * Promise resolves with true/false based on user choice
   */
  const confirm = (): Promise<boolean> => {
    return new Promise<boolean>(resolve => {
      // Store the resolve function in state
      // This opens the dialog (promise !== null)
      setPromise({ resolve });
    });
  };

  /**
   * Closes the dialog and resets state
   */
  const handleClose = () => {
    setPromise(null);
  };

  /**
   * User clicked "Confirm" button
   */
  const handleConfirm = () => {
    // Resolve the Promise with true
    promise?.resolve(true);
    // Close the dialog
    handleClose();
  };

  /**
   * User clicked "Cancel" button or closed the dialog
   */
  const handleCancel = () => {
    // Resolve the Promise with false
    promise?.resolve(false);
    // Close the dialog
    handleClose();
  };

  /**
   * The confirmation dialog component
   * Render this at the top level of your component
   */
  const ConfirmationDialog = () => (
    <ResponsiveDialog
      title={title}
      description={description}
      open={promise !== null} // Open when promise exists
      onOpenChange={open => {
        // If dialog is closed via backdrop/escape, treat as cancel
        if (!open) {
          handleCancel();
        }
      }}
    >
      {/* Action buttons */}
      <div className="flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2 space-y-2 space-y-reverse sm:space-y-0">
        <Button variant="outline" onClick={handleCancel}>
          Cancel
        </Button>
        <Button variant="destructive" onClick={handleConfirm}>
          Confirm
        </Button>
      </div>
    </ResponsiveDialog>
  );

  // Return the component and the confirm function
  return [ConfirmationDialog, confirm];
};
````

**Understanding the Promise-Based State Management:**

### State Flow Diagram

```
Initial State: promise = null
                    ↓
User calls confirm()
                    ↓
promise = { resolve: fn }
                    ↓
Dialog opens (promise !== null)
                    ↓
        ┌───────────┴───────────┐
        ↓                       ↓
User clicks Confirm      User clicks Cancel
        ↓                       ↓
promise.resolve(true)    promise.resolve(false)
        ↓                       ↓
        └───────────┬───────────┘
                    ↓
            promise = null
                    ↓
            Dialog closes
```

### Why This Pattern Works

1. **Promise as State**: The Promise resolver IS the dialog state

   - `null` = Dialog closed
   - `non-null` = Dialog open and waiting

2. **Single Source of Truth**: One piece of state controls everything

3. **Automatic Cleanup**: Setting promise to null closes the dialog

4. **Type Safety**: TypeScript ensures proper usage

5. **Clean API**: Callers use familiar async/await syntax

## Step 5: Using the Confirmation Dialog

Now let's use our confirmation dialog in a real component.

### Example 1: Simple Delete Action

```typescript
import { useConfirm } from '@/hooks/use-confirm';
import { Button } from '@/components/ui/button';

export function DeleteButton() {
  // Create the confirmation dialog
  const [ConfirmDelete, confirmDelete] = useConfirm(
    'Delete Item?',
    'This action cannot be undone. Are you sure you want to proceed?'
  );

  const handleDelete = async () => {
    // Show confirmation dialog and wait for response
    const confirmed = await confirmDelete();

    if (confirmed) {
      console.log('User confirmed - deleting item...');
      // Your delete logic here
    } else {
      console.log('User cancelled');
    }
  };

  return (
    <>
      {/* IMPORTANT: Render the dialog component */}
      <ConfirmDelete />

      {/* Your trigger button */}
      <Button variant="destructive" onClick={handleDelete}>
        Delete
      </Button>
    </>
  );
}
```

### Example 2: API Integration with Error Handling

```typescript
import { useConfirm } from '@/hooks/use-confirm';
import { Button } from '@/components/ui/button';
import { useState } from 'react';

export function DeleteAgentButton({
  agentId,
  agentName
}: {
  agentId: string;
  agentName: string;
}) {
  const [isDeleting, setIsDeleting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [ConfirmDelete, confirmDelete] = useConfirm(
    'Delete Agent?',
    `Are you sure you want to delete "${agentName}"? This will also remove all associated meetings.`
  );

  const handleDelete = async () => {
    // Show confirmation first
    const confirmed = await confirmDelete();
    if (!confirmed) return;

    // Proceed with deletion
    setIsDeleting(true);
    setError(null);

    try {
      const response = await fetch(`/api/agents/${agentId}`, {
        method: 'DELETE'
      });

      if (!response.ok) {
        throw new Error('Failed to delete agent');
      }

      console.log('Agent deleted successfully');
      // Redirect or update UI
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setIsDeleting(false);
    }
  };

  return (
    <>
      <ConfirmDelete />

      <div className="space-y-2">
        <Button
          variant="destructive"
          onClick={handleDelete}
          disabled={isDeleting}
        >
          {isDeleting ? 'Deleting...' : 'Delete Agent'}
        </Button>

        {error && <p className="text-sm text-red-500">{error}</p>}
      </div>
    </>
  );
}
```

### Example 3: Multiple Confirmations in One Component

```typescript
import { useConfirm } from '@/hooks/use-confirm';
import { Button } from '@/components/ui/button';

export function UserManagement({ userId }: { userId: string }) {
  // Create multiple confirmation dialogs
  const [ConfirmDelete, confirmDelete] = useConfirm(
    'Delete User?',
    'This will permanently delete the user account.'
  );

  const [ConfirmSuspend, confirmSuspend] = useConfirm(
    'Suspend User?',
    'The user will be unable to access their account until reactivated.'
  );

  const [ConfirmReset, confirmReset] = useConfirm(
    'Reset Password?',
    'A password reset email will be sent to the user.'
  );

  const handleDelete = async () => {
    if (await confirmDelete()) {
      // Delete user
    }
  };

  const handleSuspend = async () => {
    if (await confirmSuspend()) {
      // Suspend user
    }
  };

  const handleResetPassword = async () => {
    if (await confirmReset()) {
      // Send reset email
    }
  };

  return (
    <>
      {/* Render all confirmation dialogs */}
      <ConfirmDelete />
      <ConfirmSuspend />
      <ConfirmReset />

      {/* Action buttons */}
      <div className="space-x-2">
        <Button onClick={handleResetPassword}>Reset Password</Button>
        <Button variant="outline" onClick={handleSuspend}>
          Suspend
        </Button>
        <Button variant="destructive" onClick={handleDelete}>
          Delete
        </Button>
      </div>
    </>
  );
}
```

### Example 4: React Query Integration

```typescript
import { useConfirm } from '@/hooks/use-confirm';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';

export function DeleteItemButton({ itemId }: { itemId: string }) {
  const queryClient = useQueryClient();

  const [ConfirmDelete, confirmDelete] = useConfirm(
    'Delete Item?',
    'This action cannot be undone.'
  );

  // Setup mutation
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      const response = await fetch(`/api/items/${id}`, {
        method: 'DELETE'
      });
      if (!response.ok) throw new Error('Failed to delete');
      return response.json();
    },
    onSuccess: () => {
      // Invalidate queries to refresh data
      queryClient.invalidateQueries({ queryKey: ['items'] });
    }
  });

  const handleDelete = async () => {
    // Show confirmation
    const confirmed = await confirmDelete();
    if (!confirmed) return;

    // Perform mutation
    await deleteMutation.mutateAsync(itemId);
  };

  return (
    <>
      <ConfirmDelete />
      <Button
        variant="destructive"
        onClick={handleDelete}
        disabled={deleteMutation.isPending}
      >
        {deleteMutation.isPending ? 'Deleting...' : 'Delete'}
      </Button>
    </>
  );
}
```

## Step 6: Advanced Use Cases

### Custom Button Styles

Modify the `useConfirm` hook to accept custom button text and variants:

```typescript
interface UseConfirmOptions {
  title: string;
  description: string;
  confirmText?: string;
  cancelText?: string;
  confirmVariant?: 'default' | 'destructive' | 'outline';
}

export const useConfirm = ({
  title,
  description,
  confirmText = 'Confirm',
  cancelText = 'Cancel',
  confirmVariant = 'destructive'
}: UseConfirmOptions): [() => JSX.Element, () => Promise<boolean>] => {
  // ... existing code ...

  const ConfirmationDialog = () => (
    <ResponsiveDialog
      title={title}
      description={description}
      open={promise !== null}
      onOpenChange={open => {
        if (!open) handleCancel();
      }}
    >
      <div className="flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2 space-y-2 space-y-reverse sm:space-y-0">
        <Button variant="outline" onClick={handleCancel}>
          {cancelText}
        </Button>
        <Button variant={confirmVariant} onClick={handleConfirm}>
          {confirmText}
        </Button>
      </div>
    </ResponsiveDialog>
  );

  return [ConfirmationDialog, confirm];
};
```

**Usage:**

```typescript
const [ConfirmArchive, confirmArchive] = useConfirm({
  title: 'Archive Project?',
  description: 'This project will be moved to archives.',
  confirmText: 'Archive',
  cancelText: 'Keep Active',
  confirmVariant: 'default'
});
```

### With Loading State During Confirmation

```typescript
export function DeleteWithLoadingButton({ itemId }: { itemId: string }) {
  const [isProcessing, setIsProcessing] = useState(false);

  const [ConfirmDelete, confirmDelete] = useConfirm(
    'Delete Item?',
    'This action cannot be undone.'
  );

  const handleDelete = async () => {
    const confirmed = await confirmDelete();
    if (!confirmed) return;

    setIsProcessing(true);
    try {
      await deleteItem(itemId);
      // Show success toast
    } catch (error) {
      // Show error toast
    } finally {
      setIsProcessing(false);
    }
  };

  return (
    <>
      <ConfirmDelete />
      <Button onClick={handleDelete} disabled={isProcessing}>
        {isProcessing ? (
          <>
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            Deleting...
          </>
        ) : (
          'Delete'
        )}
      </Button>
    </>
  );
}
```

### Conditional Confirmation

Sometimes you only need confirmation for certain conditions:

```typescript
export function SmartDeleteButton({
  itemId,
  hasData
}: {
  itemId: string;
  hasData: boolean;
}) {
  const [ConfirmDelete, confirmDelete] = useConfirm(
    'Delete Item with Data?',
    'This item has associated data. Are you sure you want to delete it?'
  );

  const handleDelete = async () => {
    // Only show confirmation if item has data
    if (hasData) {
      const confirmed = await confirmDelete();
      if (!confirmed) return;
    }

    // Proceed with deletion
    await deleteItem(itemId);
  };

  return (
    <>
      {hasData && <ConfirmDelete />}
      <Button variant="destructive" onClick={handleDelete}>
        Delete
      </Button>
    </>
  );
}
```

## Testing Your Implementation

### Manual Testing Checklist

- [ ] **Desktop Dialog**

  - [ ] Opens when action is triggered
  - [ ] Shows correct title and description
  - [ ] Confirm button works
  - [ ] Cancel button works
  - [ ] Clicking backdrop closes dialog (cancel)
  - [ ] Pressing Escape closes dialog (cancel)

- [ ] **Mobile Drawer**

  - [ ] Resize window to mobile width
  - [ ] Drawer slides up from bottom
  - [ ] Swipe down closes drawer (cancel)
  - [ ] All buttons work correctly

- [ ] **Integration**
  - [ ] Confirmation prevents action when cancelled
  - [ ] Action proceeds when confirmed
  - [ ] Multiple confirmations don't interfere
  - [ ] Works with async operations

### Unit Testing Example

```typescript
import { renderHook, act, waitFor } from '@testing-library/react';
import { useConfirm } from '@/hooks/use-confirm';

describe('useConfirm', () => {
  it('should return confirmation component and confirm function', () => {
    const { result } = renderHook(() =>
      useConfirm('Test Title', 'Test Description')
    );

    expect(result.current).toHaveLength(2);
    expect(typeof result.current[0]).toBe('function'); // Component
    expect(typeof result.current[1]).toBe('function'); // Confirm function
  });

  it('should resolve with true when confirmed', async () => {
    const { result } = renderHook(() =>
      useConfirm('Test Title', 'Test Description')
    );

    const [, confirm] = result.current;

    let confirmResult: boolean | undefined;

    act(() => {
      confirm().then(result => {
        confirmResult = result;
      });
    });

    // Simulate confirm button click
    // You would need to render the component and click the button
    // This is simplified for demonstration

    await waitFor(() => {
      expect(confirmResult).toBe(true);
    });
  });
});
```

### Integration Testing with React Testing Library

```typescript
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { DeleteButton } from './DeleteButton';

describe('DeleteButton', () => {
  it('shows confirmation dialog when clicked', () => {
    render(<DeleteButton />);

    const deleteButton = screen.getByRole('button', { name: /delete/i });
    fireEvent.click(deleteButton);

    expect(screen.getByText('Delete Item?')).toBeInTheDocument();
  });

  it('does not delete when cancelled', async () => {
    const onDelete = jest.fn();
    render(<DeleteButton onDelete={onDelete} />);

    // Click delete
    fireEvent.click(screen.getByRole('button', { name: /delete/i }));

    // Click cancel
    fireEvent.click(screen.getByRole('button', { name: /cancel/i }));

    await waitFor(() => {
      expect(onDelete).not.toHaveBeenCalled();
    });
  });

  it('deletes when confirmed', async () => {
    const onDelete = jest.fn();
    render(<DeleteButton onDelete={onDelete} />);

    // Click delete
    fireEvent.click(screen.getByRole('button', { name: /delete/i }));

    // Click confirm
    fireEvent.click(screen.getByRole('button', { name: /confirm/i }));

    await waitFor(() => {
      expect(onDelete).toHaveBeenCalled();
    });
  });
});
```

## Common Pitfalls and Solutions

### ❌ Pitfall 1: Forgetting to Render the Dialog Component

```typescript
// WRONG - Dialog component not rendered
export function BadExample() {
  const [ConfirmDelete, confirmDelete] = useConfirm('Delete?', 'Are you sure?');

  return (
    <Button
      onClick={async () => {
        if (await confirmDelete()) {
          // Delete
        }
      }}
    >
      Delete
    </Button>
  );
}
```

```typescript
// CORRECT - Dialog component is rendered
export function GoodExample() {
  const [ConfirmDelete, confirmDelete] = useConfirm('Delete?', 'Are you sure?');

  return (
    <>
      <ConfirmDelete /> {/* ✅ Must render this! */}
      <Button
        onClick={async () => {
          if (await confirmDelete()) {
            // Delete
          }
        }}
      >
        Delete
      </Button>
    </>
  );
}
```

### ❌ Pitfall 2: Not Handling the False Case

```typescript
// RISKY - Doesn't explicitly handle cancellation
const handleDelete = async () => {
  const confirmed = await confirmDelete();
  // If confirmed is false, still continues...
  deleteItem(); // ❌ This will always run!
};
```

```typescript
// SAFE - Explicitly handles cancellation
const handleDelete = async () => {
  const confirmed = await confirmDelete();
  if (!confirmed) return; // ✅ Early return
  deleteItem();
};
```

### ❌ Pitfall 3: Using confirm() in Render Logic

```typescript
// WRONG - Don't call confirm during render
export function BadExample() {
  const [ConfirmDelete, confirmDelete] = useConfirm('Delete?', 'Are you sure?');

  // ❌ This triggers during every render!
  confirmDelete();

  return <div>...</div>;
}
```

```typescript
// CORRECT - Call confirm in event handlers
export function GoodExample() {
  const [ConfirmDelete, confirmDelete] = useConfirm('Delete?', 'Are you sure?');

  const handleClick = async () => {
    await confirmDelete(); // ✅ Called in event handler
  };

  return (
    <>
      <ConfirmDelete />
      <Button onClick={handleClick}>Delete</Button>
    </>
  );
}
```

### ❌ Pitfall 4: Creating Hook Inside Event Handler

```typescript
// WRONG - Hooks can't be created conditionally
export function BadExample() {
  const handleDelete = async () => {
    // ❌ Hook created inside handler - breaks React rules!
    const [ConfirmDelete, confirmDelete] = useConfirm(
      'Delete?',
      'Are you sure?'
    );
    await confirmDelete();
  };

  return <Button onClick={handleDelete}>Delete</Button>;
}
```

```typescript
// CORRECT - Hook at component level
export function GoodExample() {
  // ✅ Hook at top level
  const [ConfirmDelete, confirmDelete] = useConfirm('Delete?', 'Are you sure?');

  const handleDelete = async () => {
    await confirmDelete();
  };

  return (
    <>
      <ConfirmDelete />
      <Button onClick={handleDelete}>Delete</Button>
    </>
  );
}
```

### ❌ Pitfall 5: Not Awaiting the Confirm Function

```typescript
// WRONG - Not awaiting
const handleDelete = () => {
  confirmDelete(); // ❌ Returns Promise, not boolean!
  deleteItem(); // Runs immediately without waiting
};
```

```typescript
// CORRECT - Using await
const handleDelete = async () => {
  const confirmed = await confirmDelete(); // ✅ Waits for user input
  if (confirmed) {
    deleteItem();
  }
};

// ALSO CORRECT - Using .then()
const handleDelete = () => {
  confirmDelete().then(confirmed => {
    if (confirmed) {
      deleteItem();
    }
  });
};
```

## Troubleshooting

### Issue: Dialog doesn't open

**Possible Causes:**

1. Forgot to render the dialog component
2. Called `confirm()` during render instead of in event handler
3. TypeScript errors preventing code execution

**Solution:**

```typescript
// Ensure you have both of these:
return (
  <>
    <ConfirmDialog /> {/* 1. Render component */}
    <Button
      onClick={async () => {
        await confirm();
        {
          /* 2. Call in handler */
        }
      }}
    >
      Action
    </Button>
  </>
);
```

### Issue: Dialog shows but buttons don't work

**Possible Causes:**

1. Event propagation issues
2. Button disabled state
3. JavaScript errors in handlers

**Solution:**

Check browser console for errors and ensure handlers are defined:

```typescript
const ConfirmationDialog = () => (
  <ResponsiveDialog
    title={title}
    description={description}
    open={promise !== null}
    onOpenChange={open => {
      if (!open) handleCancel(); // Make sure this is defined
    }}
  >
    <div className="flex gap-2">
      <Button onClick={handleCancel}>Cancel</Button> {/* Defined? */}
      <Button onClick={handleConfirm}>Confirm</Button> {/* Defined? */}
    </div>
  </ResponsiveDialog>
);
```

### Issue: Multiple dialogs interfere with each other

**Possible Causes:**

1. Reusing the same hook instance for multiple purposes
2. Not properly closing dialogs

**Solution:**

Create separate hook instances for each purpose:

```typescript
// ✅ CORRECT - Separate instances
const [ConfirmDelete, confirmDelete] = useConfirm('Delete?', '...');
const [ConfirmArchive, confirmArchive] = useConfirm('Archive?', '...');

return (
  <>
    <ConfirmDelete />
    <ConfirmArchive />
    {/* ... */}
  </>
);
```

### Issue: Mobile drawer doesn't appear

**Possible Causes:**

1. `useIsMobile` hook not working
2. Viewport meta tag missing
3. Media query threshold not met

**Solution:**

1. Add viewport meta tag to HTML:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```

2. Test the media query:

```typescript
console.log(window.matchMedia('(max-width: 768px)').matches);
```

3. Temporarily force mobile mode for testing:

```typescript
// In ResponsiveDialog component, temporarily:
const isMobile = true; // Force mobile mode for testing
```

### Issue: Dialog closes unexpectedly

**Possible Causes:**

1. Backdrop click triggering cancel
2. State updates causing re-renders
3. Parent component unmounting

**Solution:**

Make sure `onOpenChange` only responds to user actions:

```typescript
<ResponsiveDialog
  open={promise !== null}
  onOpenChange={(open) => {
    if (!open) {
      handleCancel();  // Only call when closing
    }
  }}
>
```

### Issue: TypeScript errors

**Common Error:** `Property 'resolve' does not exist on type 'null'`

**Solution:**

Use optional chaining:

```typescript
// ❌ WRONG
promise.resolve(true);

// ✅ CORRECT
promise?.resolve(true);
```

## Next Steps

Now that you have a working confirmation dialog system, consider:

1. **Styling**: Customize colors, spacing, and animations
2. **Accessibility**: Add keyboard shortcuts and screen reader improvements
3. **Analytics**: Track confirmation rates
4. **Variants**: Create specialized versions (e.g., info, warning, danger)
5. **Animations**: Add enter/exit transitions
6. **Context**: Create a global confirmation service

## Additional Resources

- [React Hooks Documentation](https://react.dev/reference/react)
- [Promise Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)
- [shadcn/ui Components](https://ui.shadcn.com/)
- [Accessibility Guidelines](https://www.w3.org/WAI/ARIA/apg/)

## Summary

You've now built a production-ready confirmation dialog system that:

✅ Works on desktop and mobile
✅ Has a clean, Promise-based API
✅ Is fully reusable
✅ Handles edge cases
✅ Is type-safe with TypeScript
✅ Follows React best practices

The key insights:

1. **Promise-based state** simplifies async UI interactions
2. **Responsive components** provide great UX across devices
3. **Custom hooks** enable powerful code reuse
4. **Separation of concerns** makes code maintainable

Happy coding! 🚀
