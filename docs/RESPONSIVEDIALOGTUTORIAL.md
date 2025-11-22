# Building a Responsive Dialog System: A Step-by-Step Tutorial

## Introduction

In this tutorial, you'll learn how to build a production-ready responsive dialog system that automatically adapts between a desktop modal dialog and a mobile drawer. We'll use real code from a SaaS application that I built to demonstrate best practices and React composition patterns.

**What you'll build:**

- A reusable `ResponsiveDialog` component that switches between Dialog (desktop) and Drawer (mobile)
- A complete "New Agent" dialog flow with form submission
- Proper state management using React's controlled component pattern

**What you'll learn:**

- Multiple React composition patterns
- How to work with shadcn/ui Dialog and Drawer components
- Controlled component state management
- Responsive design at the component level

## Prerequisites

- Basic React knowledge (hooks, props, state)
- Understanding of TypeScript
- Familiarity with shadcn/ui (or willingness to learn)
- Next.js project setup

## Composition Patterns Used

This implementation demonstrates several key React composition patterns:

### 1. **Controlled Component Pattern**

Components don't manage their own state—the parent controls them via props.

### 2. **Prop Drilling Pattern**

State and callbacks flow down through component layers.

### 3. **Composition Pattern**

Building complex UIs by composing smaller, reusable components using the `children` prop.

### 4. **Adapter Pattern**

`ResponsiveDialog` adapts two different components (Dialog/Drawer) to work with a single API.

### 5. **Callback Inversion (IoC)**

Child components receive callbacks from parents, avoiding tight coupling.

### 6. **Container/Presentational Pattern**

Separating state management (containers) from UI rendering (presentational components).

---

## Part 1: Understanding the Foundation

### The Magic of Matching APIs

The key insight that makes our responsive dialog work is that **both shadcn's Dialog and Drawer expose identical control APIs**:

```typescript
// Both components accept these props
interface ControlProps {
  open?: boolean; // Controls visibility
  onOpenChange?: (open: boolean) => void; // Called when visibility should change
}
```

This isn't by accident—it's intentional API design that enables seamless swapping between the two.

### How Dialog Works (Desktop)

**File:** `src/components/ui/dialog.tsx`

```typescript
function Dialog({
  ...props
}: React.ComponentProps<typeof DialogPrimitive.Root>) {
  return <DialogPrimitive.Root data-slot="dialog" {...props} />;
}
```

The Dialog component forwards all props to Radix UI's `DialogPrimitive.Root`, which:

- **Reads** the `open` prop to determine if it should be visible
- **Calls** `onOpenChange(false)` when the user tries to close it (clicking X, pressing Escape, or clicking the backdrop)

**Important:** Dialog is a **controlled component**—it doesn't have its own internal state. It relies on the parent to update the `open` prop for it to actually close.

### How Drawer Works (Mobile)

**File:** `src/components/ui/drawer.tsx`

```typescript
function Drawer({
  ...props
}: React.ComponentProps<typeof DrawerPrimitive.Root>) {
  return <DrawerPrimitive.Root data-slot="drawer" {...props} />;
}
```

The Drawer component forwards props to Vaul's `DrawerPrimitive.Root`, which:

- **Reads** the `open` prop to determine visibility
- **Calls** `onOpenChange(false)` when the user swipes down or clicks the backdrop

**Key Insight:** Despite different interactions (click vs swipe), both components use the same callback mechanism.

---

## Part 2: Building the Mobile Detection Hook

Before we can switch between Dialog and Drawer, we need to detect the screen size.

### Step 1: Create the `useIsMobile` Hook

**File:** `src/hooks/use-mobile.ts`

```typescript
import * as React from 'react';

const MOBILE_BREAKPOINT = 768;

export function useIsMobile() {
  const [isMobile, setIsMobile] = React.useState<boolean | undefined>(
    undefined
  );

  React.useEffect(() => {
    const mql = window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`);
    const onChange = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
    };
    mql.addEventListener('change', onChange);
    setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
    return () => mql.removeEventListener('change', onChange);
  }, []);

  return !!isMobile;
}
```

**Pattern Used:** This demonstrates the **React Hooks Pattern** for encapsulating logic.

**Key Features:**

1. **Initial `undefined` state:** Prevents hydration mismatch in SSR (server doesn't know screen size)
2. **Media query listener:** Updates when viewport is resized
3. **Cleanup:** Removes listener on unmount (prevents memory leaks)
4. **Boolean coercion:** `!!isMobile` ensures consistent boolean return

**Why 768px?**
This matches Tailwind's `md` breakpoint, ensuring consistency across your design system.

---

## Part 3: Building the ResponsiveDialog Component

Now we'll create the core component that adapts between Dialog and Drawer.

### Step 2: Create ResponsiveDialog

**File:** `src/components/responsive-dialog.tsx`

```typescript
'use client';

import { useIsMobile } from '@/hooks/use-mobile';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription
} from '@/components/ui/dialog';
import {
  Drawer,
  DrawerContent,
  DrawerHeader,
  DrawerTitle,
  DrawerDescription
} from '@/components/ui/drawer';

interface ResponsiveDialogProps {
  title: string;
  description: string;
  children: React.ReactNode;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export const ResponsiveDialog = ({
  title,
  description,
  children,
  open,
  onOpenChange
}: ResponsiveDialogProps) => {
  const isMobile = useIsMobile();

  if (isMobile) {
    return (
      <Drawer open={open} onOpenChange={onOpenChange}>
        <DrawerContent>
          <DrawerHeader>
            <DrawerTitle>{title}</DrawerTitle>
            <DrawerDescription>{description}</DrawerDescription>
          </DrawerHeader>
          <div className="p-4">{children}</div>
        </DrawerContent>
      </Drawer>
    );
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
          <DialogDescription>{description}</DialogDescription>
        </DialogHeader>
        {children}
      </DialogContent>
    </Dialog>
  );
};
```

### Patterns in This Component

#### 1. Adapter Pattern

`ResponsiveDialog` acts as an adapter, providing a unified interface for two different components:

```typescript
// Same API regardless of which component renders
<ResponsiveDialog
  open={isOpen}
  onOpenChange={setIsOpen}
  title="My Dialog"
  description="Dialog description"
>
  {/* content */}
</ResponsiveDialog>
```

#### 2. Composition Pattern

The component uses `children` prop to accept any content:

```typescript
children: React.ReactNode; // Accept any valid React content
```

This makes the component **highly reusable**—it doesn't care what goes inside.

#### 3. Controlled Component Pattern

Notice that `ResponsiveDialog`:

- Accepts `open` prop (doesn't create its own state)
- Accepts `onOpenChange` callback (doesn't mutate state directly)
- Passes both props through to Dialog/Drawer

This means the **parent component controls the state**.

### Why This Design Works

Both branches (Dialog and Drawer) receive identical props:

- `open={open}` → Controls visibility
- `onOpenChange={onOpenChange}` → Handles close requests

The parent component doesn't need to know which one is rendered—it just manages state.

### Mobile-Specific Padding

Notice this line in the Drawer branch:

```typescript
<div className="p-4">{children}</div>
```

Mobile devices need extra padding for touch-friendly spacing. The Dialog version doesn't need this wrapper because `DialogContent` already has padding.

---

## Part 4: Creating a Domain-Specific Dialog Wrapper

Now we'll create a wrapper specifically for creating new agents.

### Step 3: Create NewAgentDialog

**File:** `src/modules/agents/ui/components/new-agent-dialog.tsx`

```typescript
import { ResponsiveDialog } from '@/components/responsive-dialog';
import { AgentForm } from './agent-form';

interface NewAgentDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export const NewAgentDialog = ({ open, onOpenChange }: NewAgentDialogProps) => {
  return (
    <ResponsiveDialog
      title="New Agent"
      description="Create a new agent"
      open={open}
      onOpenChange={onOpenChange}
    >
      <AgentForm
        onSuccess={() => onOpenChange(false)}
        onCancel={() => onOpenChange(false)}
      />
    </ResponsiveDialog>
  );
};
```

### Patterns in This Component

#### 1. Facade Pattern

`NewAgentDialog` is a simplified interface (facade) that:

- Configures `ResponsiveDialog` with specific title/description
- Wires up the form callbacks
- Hides implementation details from parent components

#### 2. Callback Inversion Pattern

Look at how the form callbacks are wired:

```typescript
<AgentForm
  onSuccess={() => onOpenChange(false)} // Close on success
  onCancel={() => onOpenChange(false)} // Close on cancel
/>
```

The form doesn't know about dialog state—it just calls callbacks. The dialog wrapper decides what those callbacks do (close the dialog).

**Why this is powerful:**

- `AgentForm` can be reused outside dialogs
- Form logic is decoupled from dialog logic
- Easy to test components independently

### State Flow

Notice how `NewAgentDialog`:

1. **Receives** `open` and `onOpenChange` from its parent
2. **Passes** them through to `ResponsiveDialog`
3. **Uses** `onOpenChange` in form callbacks

This is **prop drilling** in action—state management responsibilities flow through the component tree.

---

## Part 5: Building the Form Component

Let's create the actual form that goes inside the dialog.

### Step 4: Create AgentForm

**File:** `src/modules/agents/ui/components/agent-form.tsx`

```typescript
import { useTRPC } from '@/trpc/client';
import { AgentGetOne } from '../../types';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { useForm } from 'react-hook-form';
import { z } from 'zod';
import { agentsInsertSchema } from '../../schema';
import { zodResolver } from '@hookform/resolvers/zod';
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from '@/components/ui/form';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import { Input } from '@/components/ui/input';
import { GeneratedAvatar } from '@/components/generated-avatar';
import { toast } from 'sonner';
import { useRouter } from 'next/navigation';

interface AgentFormProps {
  onSuccess?: () => void;
  onCancel?: () => void;
  initialValues?: AgentGetOne;
}

export const AgentForm = ({
  onSuccess,
  onCancel,
  initialValues
}: AgentFormProps) => {
  const router = useRouter();
  const trpc = useTRPC();
  const queryClient = useQueryClient();

  const createAgent = useMutation(
    trpc.agents.create.mutationOptions({
      onSuccess: async () => {
        await queryClient.invalidateQueries(
          trpc.agents.getMany.queryOptions({})
        );
        await queryClient.invalidateQueries(
          trpc.premium.getFreeUsage.queryOptions()
        );
        onSuccess?.(); // ⚠️ Trigger dialog close
      },
      onError: error => {
        toast.error(error.message);
        if (error.data?.code === 'FORBIDDEN') {
          router.push('/upgrade');
        }
      }
    })
  );

  const updateAgent = useMutation(
    trpc.agents.update.mutationOptions({
      onSuccess: async () => {
        await queryClient.invalidateQueries(
          trpc.agents.getMany.queryOptions({})
        );
        if (initialValues?.id) {
          await queryClient.invalidateQueries(
            trpc.agents.getOne.queryOptions({ id: initialValues.id })
          );
        }
        onSuccess?.(); // ⚠️ Trigger dialog close
      },
      onError: error => {
        toast.error(error.message);
      }
    })
  );

  const form = useForm<z.infer<typeof agentsInsertSchema>>({
    resolver: zodResolver(agentsInsertSchema),
    defaultValues: {
      name: initialValues?.name ?? '',
      instructions: initialValues?.instructions ?? ''
    }
  });

  const isEdit = !!initialValues?.id;
  const isPending = createAgent.isPending || updateAgent.isPending;

  const onSubmit = (values: z.infer<typeof agentsInsertSchema>) => {
    if (isEdit) {
      updateAgent.mutate({ ...values, id: initialValues.id });
    } else {
      createAgent.mutate(values);
    }
  };

  return (
    <Form {...form}>
      <form className="space-y-4" onSubmit={form.handleSubmit(onSubmit)}>
        <GeneratedAvatar
          seed={form.watch('name')}
          variant="botttsNeutral"
          className="border size-16"
        />
        <FormField
          name="name"
          control={form.control}
          render={({ field }) => (
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input {...field} placeholder="e.g. Math tutor" />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          name="instructions"
          control={form.control}
          render={({ field }) => (
            <FormItem>
              <FormLabel>Instructions</FormLabel>
              <FormControl>
                <Textarea
                  {...field}
                  placeholder="You are a helpful math assistant that can answer questions and help with assignments."
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <div className="flex justify-between gap-x-2">
          {onCancel && (
            <Button
              variant="ghost"
              disabled={isPending}
              type="button"
              onClick={() => onCancel()}
            >
              Cancel
            </Button>
          )}
          <Button disabled={isPending} type="submit">
            {isEdit ? 'Update' : 'Create'}
          </Button>
        </div>
      </form>
    </Form>
  );
};
```

### Key Patterns in AgentForm

#### 1. Optional Callback Props

```typescript
onSuccess?: () => void;
onCancel?: () => void;
```

Using optional callbacks makes the form flexible:

- Works inside dialogs (with callbacks)
- Works on standalone pages (without callbacks)
- Parent controls what happens on success/cancel

#### 2. Separation of Concerns

The form:

- ✅ Knows about: form validation, API calls, error handling
- ❌ Doesn't know about: dialog state, modal behavior, routing context

This makes it **reusable** and **testable**.

#### 3. The Critical Callback Timing

Look at when `onSuccess` is called:

```typescript
onSuccess: async () => {
  await queryClient.invalidateQueries(...);  // Refresh data
  onSuccess?.();                              // THEN close dialog
}
```

The dialog closes **after** data is refreshed, ensuring the UI is up-to-date when the dialog disappears.

#### 4. Defensive Programming

Notice the optional chaining:

```typescript
onSuccess?.(); // Only call if provided
onCancel?.(); // Only call if provided
```

This prevents errors when the form is used without callbacks.

---

## Part 6: Connecting Everything with State Management

Now we'll create the parent component that owns the state and orchestrates everything.

### Step 5: Create AgentsListHeader

**File:** `src/modules/agents/ui/components/agents-list-header.tsx`

```typescript
'use client';

import { Button } from '@/components/ui/button';
import { PlusIcon, XCircleIcon } from 'lucide-react';
import { NewAgentDialog } from './new-agent-dialog';
import { ScrollArea, ScrollBar } from '@/components/ui/scroll-area';
import { useState } from 'react';
import { useAgentsFilters } from '../../hooks/use-agents-filters';
import { AgentsSearchFilter } from './agents-search-filter';
import { DEFAULT_PAGE } from '@/constants';

export const AgentsListHeader = () => {
  const [filters, setFilters] = useAgentsFilters();
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const isAnyFilterModified = !!filters.search;

  const onClearFilters = () => {
    setFilters({
      search: '',
      page: DEFAULT_PAGE
    });
  };

  return (
    <>
      <NewAgentDialog open={isDialogOpen} onOpenChange={setIsDialogOpen} />
      <div className="py-4 px-4 md:px-8 flex flex-col gap-y-4">
        <div className="flex items-center justify-between">
          <h5 className="font-medium text-xl">My Agents</h5>
          <Button onClick={() => setIsDialogOpen(true)}>
            <PlusIcon />
            New Agent
          </Button>
        </div>
        <ScrollArea>
          <div className="flex items-center gap-x-2 p-1">
            <AgentsSearchFilter />
            {isAnyFilterModified && (
              <Button variant="outline" size="sm" onClick={onClearFilters}>
                <XCircleIcon />
                Clear
              </Button>
            )}
          </div>
          <ScrollBar orientation="horizontal" />
        </ScrollArea>
      </div>
    </>
  );
};
```

### Understanding State Ownership

#### The "Aha!" Moment: onOpenChange IS setState

Here's the elegant insight at the heart of this pattern:

```typescript
// 1. Create state with useState
const [isDialogOpen, setIsDialogOpen] = useState(false);

// 2. Pass the setter directly as onOpenChange
<NewAgentDialog
  open={isDialogOpen} // Current state value
  onOpenChange={setIsDialogOpen} // State setter function
/>;
```

**Why can we pass the setter directly?**

The function signatures match perfectly:

```typescript
// useState gives you:
setIsDialogOpen: (value: boolean) => void

// Dialog/Drawer expect:
onOpenChange: (open: boolean) => void

// They're identical! ✅
```

When Radix UI or Vaul wants to close the dialog, they call:

```typescript
onOpenChange(false);
```

Which is actually calling:

```typescript
setIsDialogOpen(false);
```

**This is React's controlled component pattern at its most elegant.**

### State Flow Visualization

#### Opening the Dialog:

```
User clicks "New Agent" button
        ↓
setIsDialogOpen(true)
        ↓
React re-renders with new state
        ↓
<NewAgentDialog open={true} />
        ↓
<ResponsiveDialog open={true} />
        ↓
<Dialog open={true} /> or <Drawer open={true} />
        ↓
Dialog/Drawer becomes visible
```

#### Closing the Dialog (via form submission):

```
User submits form
        ↓
AgentForm.onSubmit
        ↓
API success
        ↓
onSuccess?.() called
        ↓
NewAgentDialog: onOpenChange(false)
        ↓
AgentsListHeader: setIsDialogOpen(false)
        ↓
React re-renders with new state
        ↓
<NewAgentDialog open={false} />
        ↓
Dialog/Drawer animates out and closes
```

#### Closing the Dialog (via Escape key or backdrop click):

```
User presses Escape or clicks backdrop
        ↓
Radix UI/Vaul internally calls: onOpenChange(false)
        ↓
This bubbles up to: setIsDialogOpen(false)
        ↓
[Same flow as above]
```

### Why State Lives Here

The state lives in `AgentsListHeader` because:

1. **Proximity to trigger:** The button that opens the dialog is here
2. **Logical ownership:** This component owns the user interaction
3. **Appropriate scope:** The state doesn't need to be lifted higher
4. **Simplicity:** No need for global state or context

---

## Part 7: Complete Component Hierarchy

Let's visualize how all the pieces fit together:

```
AgentsListHeader (State Owner)
│   State: isDialogOpen, setIsDialogOpen
│   Trigger: "New Agent" button
│
└── NewAgentDialog (Facade/Wrapper)
    │   Props: open, onOpenChange
    │   Config: title, description
    │
    └── ResponsiveDialog (Adapter)
        │   Props: open, onOpenChange, children
        │   Logic: Choose Dialog vs Drawer
        │
        ├── Dialog (Desktop ≥768px)
        │   │   Library: Radix UI
        │   │   Props: open, onOpenChange
        │   │
        │   └── DialogContent
        │       └── DialogHeader + children
        │
        └── Drawer (Mobile <768px)
            │   Library: Vaul
            │   Props: open, onOpenChange
            │
            └── DrawerContent
                └── DrawerHeader + children
```

### Data Flow

**Props flow down (unidirectional):**

```
isDialogOpen → open → open → open (to Dialog/Drawer)
```

**Callbacks flow up (event bubbling):**

```
User action → onOpenChange(false) → onOpenChange(false) → setIsDialogOpen(false)
```

---

## Part 8: Composition Patterns Deep Dive

Let's examine each pattern in detail:

### 1. Controlled Component Pattern

**What it is:** Components that don't manage their own state—the parent controls them.

**Where we use it:**

- `ResponsiveDialog` doesn't have state—it receives `open` and `onOpenChange`
- Dialog and Drawer are controlled by `ResponsiveDialog`
- The entire chain is controlled by `AgentsListHeader`

**Benefits:**

- Single source of truth (state in one place)
- Predictable behavior (easy to trace state changes)
- Programmatic control (parent can open/close anytime)
- Testing is easier (inject state via props)

**Example:**

```typescript
// ❌ Uncontrolled (internal state)
const [isOpen, setIsOpen] = useState(false);
return <Dialog>...</Dialog>; // Dialog manages itself

// ✅ Controlled (external state)
<ResponsiveDialog
  open={isOpen} // Parent provides state
  onOpenChange={setIsOpen} // Parent provides setter
/>;
```

### 2. Composition Pattern

**What it is:** Building complex UIs by combining smaller components using `children`.

**Where we use it:**

```typescript
<ResponsiveDialog>
  <AgentForm /> {/* Any component can go here */}
</ResponsiveDialog>
```

**Benefits:**

- Flexibility (different content for different use cases)
- Reusability (ResponsiveDialog works with ANY children)
- Separation of concerns (dialog doesn't know about form)

**Real-world usage:**

```typescript
// Same ResponsiveDialog, different content:

// Use case 1: Create agent
<ResponsiveDialog title="New Agent">
  <AgentForm />
</ResponsiveDialog>

// Use case 2: Confirm deletion
<ResponsiveDialog title="Confirm Delete">
  <ConfirmationButtons />
</ResponsiveDialog>

// Use case 3: Image preview
<ResponsiveDialog title="Image Preview">
  <ImageViewer src={url} />
</ResponsiveDialog>
```

### 3. Adapter Pattern

**What it is:** A component that provides a unified interface for different implementations.

**Where we use it:**
`ResponsiveDialog` adapts between Dialog and Drawer:

```typescript
// Unified API:
<ResponsiveDialog open={state} onOpenChange={setState} />

// Internally adapts to:
// Desktop → <Dialog />
// Mobile → <Drawer />
```

**Benefits:**

- Parent components don't need device-specific logic
- Swap implementations without changing parent code
- Centralized responsive logic

### 4. Callback Inversion (Inversion of Control)

**What it is:** Instead of child components calling parent methods, they receive callbacks from parents.

**Where we use it:**

```typescript
// Child doesn't know what onSuccess does
<AgentForm onSuccess={() => onOpenChange(false)} />

// Parent decides: "when form succeeds, close dialog"
```

**Benefits:**

- Loose coupling (form doesn't know about dialog)
- Reusability (form works in different contexts)
- Testability (easy to mock callbacks)

**Comparison:**

```typescript
// ❌ Tight coupling (child knows about parent)
<AgentForm dialogController={dialogRef} />
// Form calls: dialogRef.current.close()

// ✅ Loose coupling (child calls callback)
<AgentForm onSuccess={() => closeDialog()} />
// Form calls: onSuccess()
```

### 5. Facade Pattern

**What it is:** A simplified interface that hides complex subsystems.

**Where we use it:**
`NewAgentDialog` is a facade that:

```typescript
// Parent sees simple API:
<NewAgentDialog open={isOpen} onOpenChange={setIsOpen} />

// But internally it:
// 1. Configures ResponsiveDialog with title/description
// 2. Renders AgentForm with specific callbacks
// 3. Wires up the form → dialog connection
```

**Benefits:**

- Simplified API for common use cases
- Hide implementation details
- Encapsulate configuration

### 6. Container/Presentational Pattern

**What it is:** Separating state management (containers) from UI rendering (presentational).

**Where we use it:**

**Container (Smart Component):**

```typescript
// AgentsListHeader - manages state
const [isDialogOpen, setIsDialogOpen] = useState(false);
```

**Presentational (Dumb Component):**

```typescript
// ResponsiveDialog - just renders UI
export const ResponsiveDialog = ({ open, onOpenChange, children }) => {
  return isMobile ? <Drawer /> : <Dialog />;
};
```

**Benefits:**

- Clear separation of concerns
- Presentational components are highly reusable
- Easier to test (presentational components are pure)

---

## Part 9: Advanced Usage Examples

### Example 1: Programmatic Control

Since the parent owns the state, you can control the dialog from anywhere:

```typescript
export const AgentsListHeader = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  // Keyboard shortcut
  useEffect(() => {
    const handleKeyPress = (e: KeyboardEvent) => {
      if (e.key === 'n' && e.ctrlKey) {
        setIsDialogOpen(true);
      }
    };
    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, []);

  // Open from any event
  const handleRowDoubleClick = () => {
    setIsDialogOpen(true);
  };

  return (
    <>
      <NewAgentDialog open={isDialogOpen} onOpenChange={setIsDialogOpen} />
      {/* Your UI */}
    </>
  );
};
```

### Example 2: Preventing Close During Loading

You can control when the dialog can be closed:

```typescript
export const NewAgentDialog = ({ open, onOpenChange }: NewAgentDialogProps) => {
  const [isPending, setIsPending] = useState(false);

  const handleOpenChange = (open: boolean) => {
    // Prevent closing during submission
    if (!open && isPending) {
      return; // Don't close
    }
    onOpenChange(open);
  };

  return (
    <ResponsiveDialog
      open={open}
      onOpenChange={handleOpenChange}
      title="New Agent"
      description="Create a new agent"
    >
      <AgentForm
        onSuccess={() => onOpenChange(false)}
        onPendingChange={setIsPending}
      />
    </ResponsiveDialog>
  );
};
```

### Example 3: Multiple Dialogs

You can have multiple dialogs controlled by the same parent:

```typescript
export const AgentsListHeader = () => {
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);

  return (
    <>
      <NewAgentDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} />
      <DeleteAgentDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} />

      <Button onClick={() => setIsCreateOpen(true)}>Create</Button>
      <Button onClick={() => setIsDeleteOpen(true)}>Delete</Button>
    </>
  );
};
```

### Example 4: Dialog State in URL

You can sync dialog state with URL query params:

```typescript
export const AgentsListHeader = () => {
  const searchParams = useSearchParams();
  const router = useRouter();

  const isDialogOpen = searchParams.get('dialog') === 'new-agent';

  const setIsDialogOpen = (open: boolean) => {
    if (open) {
      router.push('?dialog=new-agent');
    } else {
      router.push('?');
    }
  };

  return <NewAgentDialog open={isDialogOpen} onOpenChange={setIsDialogOpen} />;
};
```

Now users can bookmark the URL with the dialog open, and the back button works correctly!

---

## Part 10: Testing Strategies

### Testing ResponsiveDialog

```typescript
import { render, screen } from '@testing-library/react';
import { ResponsiveDialog } from './responsive-dialog';
import * as useMobileHook from '@/hooks/use-mobile';

describe('ResponsiveDialog', () => {
  it('renders Dialog on desktop', () => {
    jest.spyOn(useMobileHook, 'useIsMobile').mockReturnValue(false);

    render(
      <ResponsiveDialog
        title="Test"
        description="Test description"
        open={true}
        onOpenChange={jest.fn()}
      >
        <div>Content</div>
      </ResponsiveDialog>
    );

    expect(screen.getByRole('dialog')).toBeInTheDocument();
  });

  it('renders Drawer on mobile', () => {
    jest.spyOn(useMobileHook, 'useIsMobile').mockReturnValue(true);

    render(
      <ResponsiveDialog
        title="Test"
        description="Test description"
        open={true}
        onOpenChange={jest.fn()}
      >
        <div>Content</div>
      </ResponsiveDialog>
    );

    // Drawer-specific assertions
    expect(screen.getByText('Content')).toBeInTheDocument();
  });
});
```

### Testing Form Callbacks

```typescript
describe('AgentForm', () => {
  it('calls onSuccess after successful submission', async () => {
    const onSuccess = jest.fn();

    render(<AgentForm onSuccess={onSuccess} />);

    // Fill and submit form
    await userEvent.type(screen.getByLabelText('Name'), 'Test Agent');
    await userEvent.click(screen.getByText('Create'));

    await waitFor(() => {
      expect(onSuccess).toHaveBeenCalled();
    });
  });

  it('calls onCancel when cancel button is clicked', async () => {
    const onCancel = jest.fn();

    render(<AgentForm onCancel={onCancel} />);

    await userEvent.click(screen.getByText('Cancel'));

    expect(onCancel).toHaveBeenCalled();
  });
});
```

### Integration Testing

```typescript
describe('New Agent Flow', () => {
  it('completes full flow: open → fill → submit → close', async () => {
    render(<AgentsListHeader />);

    // Open dialog
    await userEvent.click(screen.getByText('New Agent'));
    expect(screen.getByRole('dialog')).toBeVisible();

    // Fill form
    await userEvent.type(screen.getByLabelText('Name'), 'Test Agent');
    await userEvent.type(
      screen.getByLabelText('Instructions'),
      'Test instructions'
    );

    // Submit
    await userEvent.click(screen.getByText('Create'));

    // Dialog closes
    await waitFor(() => {
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });
  });
});
```

---

## Part 11: Common Patterns and Best Practices

### 1. Always Use Type-Safe Props

```typescript
// ✅ Good: Explicit interface
interface NewAgentDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

// ❌ Bad: Any or loose types
interface NewAgentDialogProps {
  open: any;
  onOpenChange: Function;
}
```

### 2. Keep State Close to Usage

```typescript
// ✅ Good: State in component that uses it
export const AgentsListHeader = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  return <NewAgentDialog open={isDialogOpen} ... />;
};

// ❌ Bad: State in page component (unnecessary lifting)
export const AgentsPage = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  return <AgentsListHeader dialogState={isDialogOpen} ... />;
};
```

### 3. Use Semantic Callback Names

```typescript
// ✅ Good: Clear intent
<AgentForm
  onSuccess={() => closeDialog()}
  onCancel={() => closeDialog()}
/>

// ❌ Less clear
<AgentForm
  onComplete={() => closeDialog()}
  onDismiss={() => closeDialog()}
/>
```

### 4. Handle All Close Paths

Ensure your dialog closes properly via:

- ✅ Form submission success
- ✅ Cancel button
- ✅ Escape key
- ✅ Backdrop click
- ✅ Swipe down (mobile)

The `onOpenChange` callback handles all of these automatically when you pass it through correctly.

### 5. Reset State on Close

```typescript
export const NewAgentDialog = ({ open, onOpenChange }: NewAgentDialogProps) => {
  const formRef = useRef<HTMLFormElement>(null);

  useEffect(() => {
    if (!open) {
      formRef.current?.reset(); // Reset form when dialog closes
    }
  }, [open]);

  return (
    <ResponsiveDialog open={open} onOpenChange={onOpenChange}>
      <AgentForm ref={formRef} />
    </ResponsiveDialog>
  );
};
```

---

## Part 12: Troubleshooting Guide

### Dialog Doesn't Open

**Symptoms:** Button click doesn't show dialog

**Debug steps:**

```typescript
const [isDialogOpen, setIsDialogOpen] = useState(false);

console.log('Dialog state:', isDialogOpen);  // Check state value

<Button onClick={() => {
  console.log('Button clicked');  // Verify click handler runs
  setIsDialogOpen(true);
  console.log('State set to true');  // Verify setter is called
}}>
```

**Common causes:**

- State not updating (check useState initialization)
- Props not passed correctly (check prop names)
- Component not re-rendering (check React DevTools)

### Dialog Doesn't Close

**Symptoms:** Dialog stays open when it should close

**Debug steps:**

```typescript
<ResponsiveDialog
  open={open}
  onOpenChange={newOpen => {
    console.log('onOpenChange called with:', newOpen); // Should be false
    onOpenChange(newOpen);
  }}
/>
```

**Common causes:**

- Cancel button has `type="submit"` (should be `type="button"`)
- Callback not connected correctly
- Event propagation stopped somewhere
- State not updating in parent

### Wrong Component Renders (Mobile/Desktop)

**Symptoms:** Dialog shows on mobile or Drawer shows on desktop

**Debug steps:**

```typescript
const isMobile = useIsMobile();
console.log('Is mobile:', isMobile, 'Width:', window.innerWidth);
```

**Common causes:**

- Wrong breakpoint value (should be 768)
- Testing in browser DevTools (not real device)
- SSR hydration mismatch

### Hydration Mismatch Error

**Symptoms:** React hydration error in console

**Solution:** Make sure `useIsMobile` starts with `undefined`:

```typescript
const [isMobile, setIsMobile] = useState<boolean | undefined>(undefined);
//                                                    ↑
//                                      Matches server render
```

---

## Part 13: Extending the Pattern

### Adding Confirmation Dialogs

```typescript
interface ConfirmDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  title: string;
  description: string;
  onConfirm: () => void;
}

export const ConfirmDialog = ({
  open,
  onOpenChange,
  title,
  description,
  onConfirm
}: ConfirmDialogProps) => {
  const handleConfirm = () => {
    onConfirm();
    onOpenChange(false);
  };

  return (
    <ResponsiveDialog
      title={title}
      description={description}
      open={open}
      onOpenChange={onOpenChange}
    >
      <div className="flex gap-2 justify-end">
        <Button variant="ghost" onClick={() => onOpenChange(false)}>
          Cancel
        </Button>
        <Button variant="destructive" onClick={handleConfirm}>
          Confirm
        </Button>
      </div>
    </ResponsiveDialog>
  );
};
```

### Adding Multi-Step Dialogs

```typescript
export const MultiStepDialog = ({ open, onOpenChange }: DialogProps) => {
  const [step, setStep] = useState(1);

  const handleClose = () => {
    setStep(1); // Reset to first step
    onOpenChange(false);
  };

  return (
    <ResponsiveDialog
      title={`Step ${step} of 3`}
      open={open}
      onOpenChange={handleClose}
    >
      {step === 1 && <Step1 onNext={() => setStep(2)} />}
      {step === 2 && (
        <Step2 onNext={() => setStep(3)} onBack={() => setStep(1)} />
      )}
      {step === 3 && (
        <Step3 onComplete={handleClose} onBack={() => setStep(2)} />
      )}
    </ResponsiveDialog>
  );
};
```

### Adding Animation Callbacks

```typescript
export const ResponsiveDialog = ({
  open,
  onOpenChange,
  onAnimationComplete,
  ...props
}: ResponsiveDialogProps & {
  onAnimationComplete?: () => void;
}) => {
  useEffect(() => {
    if (!open && onAnimationComplete) {
      // Wait for close animation
      const timer = setTimeout(onAnimationComplete, 200);
      return () => clearTimeout(timer);
    }
  }, [open, onAnimationComplete]);

  // ... rest of component
};
```

---

## Conclusion

You've now built a production-ready responsive dialog system! Let's recap what you've learned:

### Key Concepts

1. **Controlled Components**: State managed by parent, not component itself
2. **Composition**: Building complex UIs from simple, reusable pieces
3. **Adapters**: Unified interface for different implementations
4. **Callback Inversion**: Loose coupling via callbacks
5. **Container/Presentational**: Separating state from UI

### The Pattern in One Diagram

```
Parent (State Owner)
  ↓ open, onOpenChange
Wrapper (Configuration)
  ↓ open, onOpenChange, title, description
Adapter (Device Detection)
  ↓ open, onOpenChange
Dialog or Drawer (UI)
  ↑ user interactions
  onOpenChange(false)
  ↑ bubbles back up
Parent updates state
```

### Why This Pattern Works

1. **Reusable**: ResponsiveDialog works with any content
2. **Maintainable**: Each component has one responsibility
3. **Testable**: Components can be tested in isolation
4. **Predictable**: Unidirectional data flow
5. **Flexible**: Easy to extend and customize
6. **Accessible**: Built on accessible primitives (Radix UI, Vaul)

### Next Steps

- Implement this pattern in your own projects
- Create additional dialog types (confirm, alert, prompt)
- Add animations and transitions
- Implement dialog stacking (multiple dialogs)
- Add keyboard shortcuts and focus management

### Further Reading

- [Radix UI Dialog Documentation](https://www.radix-ui.com/docs/primitives/components/dialog)
- [Vaul (Drawer) Documentation](https://github.com/emilkowalski/vaul)
- [React Controlled Components](https://react.dev/learn/sharing-state-between-components)
- [Composition vs Inheritance](https://react.dev/learn/thinking-in-react)

---

## Appendix: Full Code Reference

### File Structure

```
src/
├── components/
│   ├── responsive-dialog.tsx       # Core adaptive component
│   └── ui/
│       ├── dialog.tsx              # shadcn Dialog (Radix UI)
│       └── drawer.tsx              # shadcn Drawer (Vaul)
├── hooks/
│   └── use-mobile.ts               # Device detection hook
└── modules/
    └── agents/
        └── ui/
            └── components/
                ├── agents-list-header.tsx    # State owner
                ├── new-agent-dialog.tsx      # Dialog wrapper
                └── agent-form.tsx            # Form content
```

### Quick Start Checklist

- [ ] Install dependencies: `@radix-ui/react-dialog`, `vaul`
- [ ] Create `use-mobile.ts` hook
- [ ] Add shadcn Dialog and Drawer components
- [ ] Create `ResponsiveDialog` component
- [ ] Create domain-specific dialog wrapper
- [ ] Add form component with callbacks
- [ ] Create parent component with state
- [ ] Test on mobile and desktop
- [ ] Add keyboard shortcuts (optional)
- [ ] Add URL state sync (optional)

Happy coding! 🚀
