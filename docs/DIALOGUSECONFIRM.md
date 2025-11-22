# Building a Reusable Confirmation Dialog in React

This tutorial explains how to build and use a powerful, reusable confirmation dialog pattern using React hooks. We'll cover the implementation details, usage patterns, and benefits of this approach.

## Table of Contents

- [Overview](#overview)
- [The Problem](#the-problem)
- [The Solution](#the-solution)
- [Implementation Details](#implementation-details)
- [Usage Examples](#usage-examples)
- [Benefits](#benefits)
- [Advanced Topics](#advanced-topics)

## Overview

We've implemented a confirmation dialog pattern that:

- Uses Promises for clean async/await syntax
- Is fully responsive (desktop/mobile)
- Handles all dialog state management internally
- Provides a simple, intuitive API
- Is highly reusable across the application

## The Problem

Traditional confirmation dialogs often require:

1. Managing multiple pieces of state (isOpen, isConfirmed)
2. Complex useEffect patterns or callback chains
3. Repetitive boilerplate code
4. Separate mobile/desktop implementations
5. Tight coupling between dialog UI and business logic

This leads to code that's:

- Hard to read and maintain
- Prone to bugs
- Not DRY (Don't Repeat Yourself)
- Difficult to test

## The Solution

Our solution uses three main components:

1. `useConfirm` hook - Manages state and provides Promise-based API
2. `ResponsiveDialog` - Handles UI rendering for both desktop and mobile
3. Promise-based state management - Ties everything together

### Key Features

- Promise-based API for clean async/await syntax
- Single source of truth for dialog state
- Responsive design out of the box
- Separation of concerns between UI and logic
- Reusable across the application

## Implementation Details

### 1. The useConfirm Hook

```typescript
export const useConfirm = (
  title: string,
  description: string
): [() => JSX.Element, () => Promise<unknown>] => {
  const [promise, setPromise] = useState<{
    resolve: (value: boolean) => void;
  } | null>(null);

  // ... implementation
};
```

The hook manages state using a Promise resolver:

- `null` promise means dialog is closed
- Non-null promise means dialog is open and waiting for user input
- Promise resolves with boolean (true = confirmed, false = cancelled)

### 2. The ResponsiveDialog Component

```typescript
interface ResponsiveDialogProps {
  title: string;
  description: string;
  children: React.ReactNode;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}
```

Features:

- Automatically switches between Dialog (desktop) and Drawer (mobile)
- Consistent API for both layouts
- Flexible content through children prop
- Controlled component pattern with open/onOpenChange

### 3. State Management Flow

1. Initial State:

   ```typescript
   const [promise, setPromise] = useState<{
     resolve: (value: boolean) => void;
   } | null>(null);
   ```

2. Opening Dialog:

   ```typescript
   const confirm = () => {
     return new Promise(resolve => {
       setPromise({ resolve });
     });
   };
   ```

3. User Interaction:

   ```typescript
   const handleConfirm = () => {
     promise?.resolve(true);
     handleClose();
   };

   const handleCancel = () => {
     promise?.resolve(false);
     handleClose();
   };
   ```

4. Cleanup:
   ```typescript
   const handleClose = () => {
     setPromise(null);
   };
   ```

## Usage Examples

### Basic Confirmation

```typescript
const [ShowConfirm, confirm] = useConfirm(
  'Delete Item?',
  'This action cannot be undone'
);

const handleDelete = async () => {
  const confirmed = await confirm();
  if (confirmed) {
    // Proceed with deletion
  }
};
```

### Real-world Example (Agent Deletion)

```typescript
const [RemoveConfirmation, confirmRemove] = useConfirm(
  'Are you sure?',
  `The following action will remove ${data.meetingCount} associated meetings`
);

const handleRemoveAgent = async () => {
  const ok = await confirmRemove();
  if (!ok) return;
  await removeAgent.mutateAsync({ id: agentId });
};
```

## Benefits

### 1. Developer Experience

- Clean, synchronous-looking code with async/await
- No need to manage dialog state manually
- Reusable across the application
- Type-safe with TypeScript

### 2. User Experience

- Consistent confirmation UI
- Responsive design works on all devices
- Keyboard accessible
- Follows platform conventions (drawer on mobile)

### 3. Code Quality

- Single responsibility principle
- Separation of concerns
- DRY (Don't Repeat Yourself)
- Easy to test
- Easy to maintain

### 4. Performance

- Minimal state updates
- No unnecessary re-renders
- Lazy dialog rendering

## Advanced Topics

### 1. State Management

The Promise-based state management is key to this pattern:

- Promise acts as both state storage and flow control
- Dialog visibility tied directly to Promise state
- Clean up happens automatically

### 2. Type Safety

```typescript
interface ConfirmState {
  resolve: (value: boolean) => void;
}

const [promise, setPromise] = useState<ConfirmState | null>(null);
```

### 3. Responsive Design

The `ResponsiveDialog` component:

- Uses `useIsMobile` hook for device detection
- Renders appropriate UI component (Dialog/Drawer)
- Maintains consistent API across devices

### 4. Accessibility

- Keyboard navigation
- Screen reader support
- Focus management
- ARIA attributes

## Best Practices

1. Always render the confirmation component at the top level:

   ```typescript
   return (
     <>
       <RemoveConfirmation />
       {/* Rest of your component */}
     </>
   );
   ```

2. Use descriptive titles and messages:

   ```typescript
   const [ShowConfirm, confirm] = useConfirm(
     'Delete Account',
     'This will permanently delete your account and all associated data'
   );
   ```

3. Handle both confirmation and cancellation:

   ```typescript
   const confirmed = await confirm();
   if (!confirmed) {
     // Handle cancellation if needed
     return;
   }
   ```

4. Clean up properly:
   ```typescript
   const handleClose = () => {
     setPromise(null); // Ensures dialog is closed
   };
   ```

## Conclusion

This confirmation dialog pattern provides a robust, reusable solution for handling user confirmations in React applications. By combining Promises with React state management, we get a clean API that's easy to use and maintain, while providing a great user experience across all devices.

The pattern demonstrates how careful design and modern React patterns can simplify complex UI interactions into clean, maintainable code.

## Other Promise-Based State Management Patterns

The Promise-based state management pattern used in this confirmation dialog can be adapted for other complex UI interactions. Here are some powerful examples:

### 1. File Upload with Progress

```typescript
const useFileUpload = (file: File) => {
  const [promise, setPromise] = useState<{
    resolve: (url: string) => void;
    progress: (percent: number) => void;
  } | null>(null);

  const upload = () => {
    return new Promise<string>(resolve => {
      setPromise({
        resolve,
        progress: percent => {
          // Update progress UI
        }
      });
    });
  };
};
```

Perfect for: File uploads with progress bars, cancellation, and cleanup.

### 2. Multi-Step Form Wizard

```typescript
const useFormWizard = () => {
  const [promise, setPromise] = useState<{
    resolve: (formData: FormData) => void;
    nextStep: () => void;
    prevStep: () => void;
  } | null>(null);

  const startForm = () => {
    return new Promise<FormData>(resolve => {
      setPromise({
        resolve,
        nextStep: () => {
          /* Update step state */
        },
        prevStep: () => {
          /* Update step state */
        }
      });
    });
  };
};
```

Ideal for: Complex forms with validation, navigation, and state preservation.

### 3. Media Recording

```typescript
const useMediaRecorder = () => {
  const [promise, setPromise] = useState<{
    resolve: (blob: Blob) => void;
    pause: () => void;
    resume: () => void;
  } | null>(null);

  const startRecording = () => {
    return new Promise<Blob>(resolve => {
      setPromise({
        resolve,
        pause: () => {
          /* Pause recording */
        },
        resume: () => {
          /* Resume recording */
        }
      });
    });
  };
};
```

Great for: Audio/video recording with controls and state management.

### When to Use Promise-Based State

This pattern is particularly powerful when:

1. **Complex Flow Control is Needed**

   - Multiple steps or states
   - Async operations with progress
   - Cancellable operations
   - Pausable/resumable operations

2. **Clean Sequential Code is Desired**

   - Avoid callback hell
   - Make async code read synchronously
   - Chain multiple async operations

3. **State Management is Temporary**

   - State only needed during a specific process
   - Clean up is automatic when process completes
   - No need for persistent state

4. **User Interaction is Required**
   - Waiting for user decisions
   - Multi-step processes
   - Interactive flows

### Benefits of Promise-Based State

1. **Code Organization**

   - Clear entry and exit points
   - Self-contained state
   - Predictable flow

2. **Error Handling**

   - Use standard try/catch
   - Proper cleanup on errors
   - Error boundary compatibility

3. **Testing**

   - Easy to mock
   - Clear success/failure paths
   - Isolated state

4. **Developer Experience**
   - Familiar Promise patterns
   - Async/await syntax
   - TypeScript friendly

This pattern works particularly well in React because it:

- Fits with React's unidirectional data flow
- Works well with hooks
- Integrates cleanly with effects
- Supports controlled components
- Handles cleanup automatically
