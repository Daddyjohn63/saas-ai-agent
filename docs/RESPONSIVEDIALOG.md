# Responsive Dialog Component Tutorial

## Overview

This tutorial explains how the responsive dialog system works in the SaaS AI Agent application. The system intelligently switches between a desktop Dialog and a mobile Drawer based on screen size, providing an optimal user experience across devices.

## Component Architecture

### Component Hierarchy

```
AgentsListHeader (State Controller)
│   owns: isDialogOpen, setIsDialogOpen
│
└── NewAgentDialog (Dialog Wrapper)
    │   receives: open, onOpenChange
    │
    └── ResponsiveDialog (Adaptive Container)
        │   receives: open, onOpenChange
        │   decides: Dialog vs Drawer based on screen size
        │
        ├── Dialog (Desktop, ≥768px)
        │   │   shadcn wrapper for Radix UI
        │   │   receives: open, onOpenChange
        │   │
        │   └── DialogPrimitive.Root (Radix UI)
        │       │   reads: open prop
        │       │   calls: onOpenChange(false) on close
        │       │
        │       └── DialogContent
        │           └── DialogHeader + AgentForm
        │
        └── Drawer (Mobile, <768px)
            │   shadcn wrapper for Vaul
            │   receives: open, onOpenChange
            │
            └── DrawerPrimitive.Root (Vaul)
                │   reads: open prop
                │   calls: onOpenChange(false) on swipe/close
                │
                └── DrawerContent
                    └── DrawerHeader + AgentForm
```

**State Flow:** `isDialogOpen` flows down as `open` prop through all layers until it reaches Radix UI or Vaul.

**Event Flow:** User interactions (click X, press Escape, swipe down) trigger `onOpenChange(false)` which bubbles up to call `setIsDialogOpen(false)`.

### File Structure

- **`agents-list-header.tsx`** - Parent component managing dialog state
- **`new-agent-dialog.tsx`** - Wrapper providing dialog context
- **`responsive-dialog.tsx`** - Adaptive component switching between Dialog/Drawer
- **`agent-form.tsx`** - Form component with success/cancel callbacks
- **`use-mobile.ts`** - Hook detecting mobile breakpoint
- **`ui/dialog.tsx`** - shadcn Dialog component (Radix UI wrapper)
- **`ui/drawer.tsx`** - shadcn Drawer component (Vaul wrapper)

---

## Understanding the Foundation: shadcn Dialog & Drawer

Before diving into how our custom components work, it's essential to understand the underlying shadcn/ui primitives that make the responsive dialog pattern possible.

### Why Both Components Share the Same API

The key insight that makes `ResponsiveDialog` work seamlessly is that **both Dialog and Drawer expose identical APIs** for controlling their visibility:

```typescript
// Both components accept these props
interface SharedProps {
  open?: boolean; // Controls visibility
  onOpenChange?: (open: boolean) => void; // Called when visibility should change
}
```

This shared API is not accidental—it's by design, allowing us to swap between them without changing our state management logic.

### Dialog Component (Desktop)

**Location:** `src/components/ui/dialog.tsx`

**Foundation:** Built on [@radix-ui/react-dialog](https://www.radix-ui.com/docs/primitives/components/dialog)

#### Component Structure

```typescript
// Root component - manages dialog state
<Dialog open={boolean} onOpenChange={(open: boolean) => void}>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Title</DialogTitle>
      <DialogDescription>Description</DialogDescription>
    </DialogHeader>
    {/* Your content here */}
  </DialogContent>
</Dialog>
```

#### Key Features

1. **Modal Overlay**: Semi-transparent backdrop (`bg-black/50`)
2. **Centered Positioning**: Fixed at screen center with `translate-x-[-50%] translate-y-[-50%]`
3. **Automatic Close Button**: X icon in top-right corner
4. **Keyboard Support**:
   - `Escape` key closes dialog
   - Focus trap keeps tab navigation within dialog
5. **Click Outside**: Clicking backdrop closes dialog
6. **Animations**: Fade and zoom effects on open/close

#### How State Works in Dialog

```typescript
function Dialog({
  ...props
}: React.ComponentProps<typeof DialogPrimitive.Root>) {
  return <DialogPrimitive.Root data-slot="dialog" {...props} />;
}
```

The `Dialog` component passes all props (including `open` and `onOpenChange`) directly to Radix UI's `DialogPrimitive.Root`. Radix handles:

- **Reading `open` prop**: Determines visibility state
- **Calling `onOpenChange`**: Triggered when user attempts to close via:
  - Clicking the X button
  - Pressing Escape key
  - Clicking the overlay backdrop
  - Any other dismissal action

**Critical Point:** Dialog is a **controlled component**. It doesn't manage its own state—it reads `open` to determine visibility and calls `onOpenChange` to request state changes. The parent component must update the `open` prop for the dialog to actually close.

#### The "Aha!" Moment: onOpenChange IS setState

Here's the key insight that makes this pattern so elegant:

```typescript
// In AgentsListHeader, you create state:
const [isDialogOpen, setIsDialogOpen] = useState(false);

// Then you pass the setter DIRECTLY as onOpenChange:
<NewAgentDialog
  open={isDialogOpen} // Current value → flows down
  onOpenChange={setIsDialogOpen} // State setter → called by Dialog
/>;
```

**Why this works:** The signatures match perfectly!

```typescript
// useState gives you:
setIsDialogOpen: (value: boolean) => void

// Dialog/Drawer expect:
onOpenChange: (open: boolean) => void

// They're identical! ✅
```

**What happens when user closes the dialog:**

```typescript
// 1. User clicks X button
// 2. Radix UI internally calls:
props.onOpenChange(false);

// 3. Which is actually calling:
setIsDialogOpen(false);

// 4. State updates, React re-renders
// 5. open={false} flows back down
// 6. Dialog closes ✨
```

**The beauty:** You don't need a wrapper function like `onOpenChange={(open) => setIsDialogOpen(open)}`—you can pass the setter directly because the function signatures align perfectly. This is React's controlled component pattern at its most elegant.

#### Dialog Close Mechanism

```typescript
<DialogPrimitive.Close>
  <XIcon />
  <span className="sr-only">Close</span>
</DialogPrimitive.Close>
```

When clicked, this triggers `onOpenChange(false)`. The parent component must respond by setting `open={false}`.

### Drawer Component (Mobile)

**Location:** `src/components/ui/drawer.tsx`

**Foundation:** Built on [Vaul](https://github.com/emilkowalski/vaul) by Emil Kowalski

#### Component Structure

```typescript
// Root component - manages drawer state
<Drawer open={boolean} onOpenChange={(open: boolean) => void}>
  <DrawerContent>
    <DrawerHeader>
      <DrawerTitle>Title</DrawerTitle>
      <DrawerDescription>Description</DrawerDescription>
    </DrawerHeader>
    {/* Your content here */}
  </DrawerContent>
</Drawer>
```

#### Key Features

1. **Bottom Sheet**: Slides up from bottom of screen
2. **Drag Handle**: Visual indicator for swipe interaction (rounded bar at top)
3. **Touch Gestures**:
   - Swipe down to dismiss
   - Drag to adjust height
4. **Overlay Backdrop**: Same as Dialog (`bg-black/50`)
5. **Max Height**: Limited to 80vh for better mobile UX
6. **Animations**: Smooth slide-in/out transitions

#### How State Works in Drawer

```typescript
function Drawer({
  ...props
}: React.ComponentProps<typeof DrawerPrimitive.Root>) {
  return <DrawerPrimitive.Root data-slot="drawer" {...props} />;
}
```

Just like Dialog, Drawer passes all props to Vaul's `DrawerPrimitive.Root`. Vaul handles:

- **Reading `open` prop**: Determines visibility state
- **Calling `onOpenChange`**: Triggered when user attempts to close via:
  - Swiping down
  - Clicking the backdrop
  - Any programmatic dismissal

**Critical Point:** Drawer is also a **controlled component** with identical behavior to Dialog. It reads `open` and calls `onOpenChange(false)` when the user wants to dismiss it.

Just like Dialog, when you pass `onOpenChange={setIsDialogOpen}`, Vaul will call your state setter directly when the user swipes down or taps the backdrop. Same pattern, different gesture!

#### Drawer Swipe Behavior

The drag handle and swipe gesture are built into `DrawerContent`:

```typescript
<div className="bg-muted mx-auto mt-4 hidden h-2 w-[100px] shrink-0 rounded-full group-data-[vaul-drawer-direction=bottom]/drawer-content:block" />
```

When user swipes down past a threshold, Vaul calls `onOpenChange(false)`.

### Why This API Design Matters

The identical `open` and `onOpenChange` API between Dialog and Drawer is **the foundation** that enables our responsive dialog pattern. Here's why:

#### 1. Consistent Controlled Component Pattern

Both components follow React's controlled component pattern:

```typescript
// Parent owns state
const [isOpen, setIsOpen] = useState(false);

// Both components use same props
<Dialog open={isOpen} onOpenChange={setIsOpen} />
<Drawer open={isOpen} onOpenChange={setIsOpen} />
```

No matter which component renders, the state management logic remains identical.

#### 2. Unified Close Mechanisms

Despite different UIs and interactions, both components call the same callback:

```typescript
// Dialog: User clicks X button
onOpenChange(false);

// Drawer: User swipes down
onOpenChange(false);

// Either: User clicks backdrop
onOpenChange(false);
```

The parent component doesn't need to know **how** the user closed the dialog—just that they want it closed.

#### 3. Predictable State Flow

```
Parent State (source of truth)
       ↓
   open={state}
       ↓
Dialog/Drawer reads state
       ↓
User triggers close
       ↓
onOpenChange(false) called
       ↓
Parent updates state
       ↓
open={false}
       ↓
Dialog/Drawer closes
```

This unidirectional flow works identically for both components.

#### 4. Seamless Swapping

Because the APIs match, ResponsiveDialog can switch between them transparently:

```typescript
// Both accept identical props
const dialogProps = { open, onOpenChange, children };

if (isMobile) {
  return <Drawer {...dialogProps} />;
}
return <Dialog {...dialogProps} />;
```

No conditional logic needed for state management—just swap the component.

### Technical Implementation Details

#### Dialog (Radix UI)

Radix UI provides low-level primitives with full accessibility:

- **ARIA attributes**: Automatic `role="dialog"`, `aria-modal="true"`, `aria-labelledby`
- **Focus management**: Traps focus within dialog, returns focus on close
- **Keyboard navigation**: Escape to close, Tab to cycle through focusable elements
- **Screen reader support**: Announces dialog open/close, reads labels

The shadcn wrapper adds styling and animations but preserves all Radix functionality.

#### Drawer (Vaul)

Vaul provides gesture-based drawer with mobile optimizations:

- **Touch events**: Handles touchstart, touchmove, touchend for gestures
- **Velocity detection**: Considers swipe speed for dismissal threshold
- **Spring animations**: Smooth, physics-based transitions
- **Accessibility**: Maintains ARIA attributes similar to Dialog

The shadcn wrapper configures Vaul for bottom-sheet behavior and adds consistent styling.

### Why We Don't Use Uncontrolled Components

Both Dialog and Drawer support **uncontrolled mode** where they manage their own state:

```typescript
// ❌ Uncontrolled (we don't use this)
<Dialog>
  <DialogTrigger>Open</DialogTrigger>
  <DialogContent>...</DialogContent>
</Dialog>
```

We explicitly use **controlled mode** instead because:

1. **Parent needs control**: AgentsListHeader needs to open the dialog programmatically
2. **Callback integration**: Form submit success needs to close dialog
3. **State coordination**: Multiple components may need to know dialog state
4. **Testing**: Easier to test when state is explicit
5. **Predictability**: Single source of truth prevents desync issues
6. **Simplicity**: We can pass `setState` directly as `onOpenChange` (signatures match perfectly!)

### Props We Pass Through

Our ResponsiveDialog forwards these props to Dialog/Drawer:

```typescript
// ✅ Passed through
open: boolean; // Visibility state
onOpenChange: (open: boolean) => void; // State update callback

// ✅ Transformed into children
title: string; // Becomes DialogTitle/DrawerTitle
description: string; // Becomes DialogDescription/DrawerDescription
children: ReactNode; // Nested inside DialogContent/DrawerContent

// ❌ Not used (defaults from shadcn)
modal?: boolean; // Always true
defaultOpen?: boolean; // We use controlled mode
// ... other uncontrolled props
```

---

## Component Breakdown

### 1. AgentsListHeader (State Controller)

**Location:** `src/modules/agents/ui/components/agents-list-header.tsx`

**Purpose:** This is the **parent component** and **state owner**. It controls when the dialog opens and closes.

#### Key Responsibilities:

- **Owns the dialog state** via `useState`
- Renders the "New Agent" button that triggers the dialog
- Passes state and state setter to child components

#### State Management:

```typescript
const [isDialogOpen, setIsDialogOpen] = useState(false);
```

- `isDialogOpen`: Boolean state tracking whether dialog is visible
- `setIsDialogOpen`: State setter function passed down to children **as `onOpenChange`**

**Key insight:** `setIsDialogOpen` becomes the `onOpenChange` callback! When Dialog/Drawer wants to close, they call `onOpenChange(false)`, which directly updates the state. See the ["Aha!" Moment](#the-aha-moment-onOpenchange-is-setstate) section for why this works so elegantly.

#### Why State Lives Here:

The state lives in `AgentsListHeader` because:

1. **Proximity to trigger**: The "New Agent" button that opens the dialog is rendered here
2. **Logical ownership**: This component owns the user interaction that triggers the dialog
3. **Scope control**: The state doesn't need to be lifted higher into the page component
4. **Single responsibility**: Keeps dialog state management close to the UI that uses it

#### JSX Structure:

```typescript
<>
  {/* Dialog component with controlled state */}
  <NewAgentDialog open={isDialogOpen} onOpenChange={setIsDialogOpen} />

  <div className="py-4 px-4 md:px-8 flex flex-col gap-y-4">
    <div className="flex items-center justify-between">
      <h5 className="font-medium text-xl">My Agents</h5>

      {/* Trigger button */}
      <Button onClick={() => setIsDialogOpen(true)}>
        <PlusIcon />
        New Agent
      </Button>
    </div>
    {/* ... filters ... */}
  </div>
</>
```

#### Flow:

1. User clicks "New Agent" button
2. `onClick` handler calls `setIsDialogOpen(true)`
3. State update triggers re-render
4. `NewAgentDialog` receives `open={true}` prop
5. Dialog becomes visible

---

### 2. NewAgentDialog (Dialog Wrapper)

**Location:** `src/modules/agents/ui/components/new-agent-dialog.tsx`

**Purpose:** This is a **wrapper component** that configures the ResponsiveDialog with specific content and behavior for creating a new agent.

#### Props Interface:

```typescript
interface NewAgentDialogProps {
  open: boolean; // Current dialog visibility state
  onOpenChange: (open: boolean) => void; // Callback to update state
}
```

#### Key Characteristics:

- **Presentational wrapper**: Doesn't manage state itself
- **Configuration layer**: Sets dialog title, description, and content
- **State passthrough**: Forwards `open` and `onOpenChange` to ResponsiveDialog
- **Callback coordination**: Connects AgentForm callbacks to dialog state

#### JSX Structure:

```typescript
<ResponsiveDialog
  title="New Agent"
  description="Create a new agent"
  open={open} // Pass through from parent
  onOpenChange={onOpenChange} // Pass through from parent
>
  <AgentForm
    onSuccess={() => onOpenChange(false)} // Close on success
    onCancel={() => onOpenChange(false)} // Close on cancel
  />
</ResponsiveDialog>
```

#### Callback Pattern:

The component creates closure callbacks that:

1. **On Success**: Call `onOpenChange(false)` to close dialog after successful form submission
2. **On Cancel**: Call `onOpenChange(false)` to close dialog when user cancels

This pattern ensures:

- Form actions can control dialog visibility
- State flows back up to the parent owner
- Dialog closes automatically on completion

---

### 3. ResponsiveDialog (Adaptive Container)

**Location:** `src/components/responsive-dialog.tsx`

**Purpose:** This is the **core adaptive component** that renders different UI (Dialog vs Drawer) based on screen size while maintaining the same API.

#### Why This Component Works

ResponsiveDialog leverages the identical APIs of shadcn's Dialog and Drawer components (explained in the Foundation section above). Because both components accept:

- `open: boolean` - to control visibility
- `onOpenChange: (open: boolean) => void` - to handle state changes

ResponsiveDialog can seamlessly swap between them based on screen size **without any conditional logic for state management**.

#### Props Interface:

```typescript
interface ResponsiveDialogProps {
  title: string; // Dialog/Drawer title
  description: string; // Dialog/Drawer description
  children: React.ReactNode; // Content to render inside
  open: boolean; // Visibility state (passed to Dialog/Drawer)
  onOpenChange: (open: boolean) => void; // State change callback (passed to Dialog/Drawer)
}
```

**Key Design Decision:** ResponsiveDialog accepts `open` and `onOpenChange` props and forwards them directly to whichever component (Dialog or Drawer) is rendered. This means:

1. The parent component (AgentsListHeader) controls the state
2. ResponsiveDialog is a "dumb" component that just renders the appropriate UI
3. State management is identical regardless of which component is shown
4. No device-specific logic in parent components

#### Adaptive Logic:

```typescript
const isMobile = useIsMobile(); // Hook returns true if width < 768px

if (isMobile) {
  return <Drawer>...</Drawer>; // Mobile UI
}

return <Dialog>...</Dialog>; // Desktop UI
```

The `useIsMobile` hook determines which component to render, but both receive the same `open` and `onOpenChange` props.

#### Desktop Rendering (Dialog):

```typescript
<Dialog open={open} onOpenChange={onOpenChange}>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>{title}</DialogTitle>
      <DialogDescription>{description}</DialogDescription>
    </DialogHeader>
    {children} {/* Form rendered here */}
  </DialogContent>
</Dialog>
```

**How Props Flow:**

- `open={open}` → Passed to Radix UI's DialogPrimitive.Root
- `onOpenChange={onOpenChange}` → Called by Radix when user clicks X, presses Escape, or clicks backdrop
- `title` → Rendered in DialogTitle (required for accessibility)
- `description` → Rendered in DialogDescription (screen reader support)
- `children` → AgentForm or any other content

**Inherited Features** (from shadcn Dialog):

- Modal overlay with semi-transparent backdrop
- Centered positioning with animations
- X close button (top-right)
- Escape key closes dialog
- Click outside backdrop closes dialog
- Focus trap and keyboard navigation
- ARIA labels for accessibility

**Why We Pass Through State:**

The Dialog component itself is just a thin wrapper around Radix UI. By passing `open` and `onOpenChange` through ResponsiveDialog, we allow the parent (AgentsListHeader) to maintain full control while Radix handles all the interaction logic.

#### Mobile Rendering (Drawer):

```typescript
<Drawer open={open} onOpenChange={onOpenChange}>
  <DrawerContent>
    <DrawerHeader>
      <DrawerTitle>{title}</DrawerTitle>
      <DrawerDescription>{description}</DrawerDescription>
    </DrawerHeader>
    <div className="p-4">{children}</div>
  </DrawerContent>
</Drawer>
```

**How Props Flow:**

- `open={open}` → Passed to Vaul's DrawerPrimitive.Root
- `onOpenChange={onOpenChange}` → Called by Vaul when user swipes down or clicks backdrop
- `title` → Rendered in DrawerTitle
- `description` → Rendered in DrawerDescription
- `children` → Wrapped in padding div for mobile spacing

**Inherited Features** (from shadcn Drawer):

- Slides up from bottom of screen
- Drag handle visual indicator
- Swipe-down gesture to dismiss
- Velocity-based dismissal threshold
- Click backdrop to close
- Max 80vh height
- Spring animations
- Touch-optimized interactions

**Mobile-Specific Difference:**

Notice the extra wrapper: `<div className="p-4">{children}</div>`. This provides appropriate padding for mobile devices where content needs more breathing room. The Dialog version doesn't need this because DialogContent already has padding.

#### Why This Pattern Works:

This component provides:

1. **Unified API**: Same props regardless of device—parent components don't need to know which is rendered
2. **Automatic adaptation**: No conditional logic in parent components—just pass `open` and `onOpenChange`
3. **Consistent behavior**: Both variants support identical `open` and `onOpenChange` props thanks to Radix UI and Vaul's shared API design
4. **Reusability**: Can be used anywhere in the app for any dialog/drawer need
5. **Maintainability**: Changes to Dialog or Drawer behavior are isolated to shadcn components
6. **Accessibility**: Both options are fully accessible, with ARIA labels and keyboard support

#### The Magic: Identical State APIs

```typescript
// Desktop version calls this when user closes
onOpenChange(false); // Via Radix UI (X button/Escape/backdrop)

// Mobile version calls this when user closes
onOpenChange(false); // Via Vaul (swipe down/backdrop)

// ResponsiveDialog doesn't care which one—both result in:
AgentsListHeader: setIsDialogOpen(false);
```

The beauty of this pattern is that **ResponsiveDialog never needs to know HOW the dialog was closed**—it just forwards the `onOpenChange` callback, and both underlying components use it identically.

---

### 4. useIsMobile Hook

**Location:** `src/hooks/use-mobile.ts`

**Purpose:** Detects whether the current viewport is mobile-sized.

#### Configuration:

```typescript
const MOBILE_BREAKPOINT = 768; // pixels
```

Matches Tailwind's `md` breakpoint for consistency.

#### Implementation:

```typescript
export function useIsMobile() {
  const [isMobile, setIsMobile] = useState<boolean | undefined>(undefined);

  useEffect(() => {
    // Create media query listener
    const mql = window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`);

    // Update state on viewport change
    const onChange = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
    };

    // Listen for changes
    mql.addEventListener('change', onChange);

    // Set initial value
    setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);

    // Cleanup
    return () => mql.removeEventListener('change', onChange);
  }, []);

  return !!isMobile;
}
```

#### Key Features:

1. **Initial undefined state**: Prevents hydration mismatch in SSR
2. **Window listener**: Updates on viewport resize
3. **Media query API**: Uses native browser API for performance
4. **Cleanup**: Removes listener on unmount
5. **Boolean coercion**: `!!isMobile` ensures boolean return

#### Why Media Query Instead of CSS:

- React needs to know which component tree to render
- CSS alone can't conditionally render different components
- Media query provides JavaScript-accessible viewport state

---

### 5. AgentForm (Dialog Content)

**Location:** `src/modules/agents/ui/components/agent-form.tsx`

**Purpose:** The actual form content rendered inside the dialog.

#### Props Interface:

```typescript
interface AgentFormProps {
  onSuccess?: () => void; // Called after successful submission
  onCancel?: () => void; // Called when user cancels
  initialValues?: AgentGetOne; // For edit mode
}
```

#### Callback Integration:

The form accepts optional callbacks that are triggered by user actions:

```typescript
const createAgent = useMutation(
  trpc.agents.create.mutationOptions({
    onSuccess: async () => {
      // ... invalidate queries ...
      onSuccess?.(); // ⚠️ Triggers dialog close
    },
    onError: error => {
      toast.error(error.message);
    }
  })
);
```

#### Button Handlers:

```typescript
<Button
  variant="ghost"
  type="button"
  onClick={() => onCancel()}  // ⚠️ Triggers dialog close
>
  Cancel
</Button>

<Button type="submit">
  {isEdit ? 'Update' : 'Create'}  // Submit triggers onSuccess
</Button>
```

#### Why Callbacks Instead of Direct State Access:

1. **Separation of concerns**: Form doesn't know about dialog state
2. **Reusability**: Form can be used outside dialogs
3. **Testability**: Easy to test form without dialog wrapper
4. **Flexibility**: Parent controls what happens on success/cancel

---

## State Flow Diagram

### Opening the Dialog

```
User clicks "New Agent"
        ↓
AgentsListHeader.onClick
        ↓
setIsDialogOpen(true)
        ↓
State update triggers re-render
        ↓
<NewAgentDialog open={true} />
        ↓
<ResponsiveDialog open={true} />
        ↓
useIsMobile() determines device
        ↓
<Dialog open={true} /> OR <Drawer open={true} />
        ↓
Component becomes visible
```

### Closing the Dialog (Success Path)

```
User submits form
        ↓
AgentForm.onSubmit
        ↓
createAgent.mutate()
        ↓
API success
        ↓
onSuccess?.() called
        ↓
NewAgentDialog: onOpenChange(false)
        ↓
AgentsListHeader: setIsDialogOpen(false)
        ↓
State update triggers re-render
        ↓
<NewAgentDialog open={false} />
        ↓
<ResponsiveDialog open={false} />
        ↓
<Dialog open={false} /> OR <Drawer open={false} />
        ↓
Component closes with animation
```

### Closing the Dialog (Cancel Path)

```
User clicks "Cancel" button
        ↓
AgentForm: onCancel()
        ↓
NewAgentDialog: onOpenChange(false)
        ↓
AgentsListHeader: setIsDialogOpen(false)
        ↓
[Same flow as success path]
```

### Closing the Dialog (Outside Click / Escape)

```
User presses Escape or clicks backdrop
        ↓
Dialog/Drawer: onOpenChange(false) called by shadcn
        ↓
NewAgentDialog: onOpenChange(false) forwarded
        ↓
AgentsListHeader: setIsDialogOpen(false)
        ↓
[Same flow as success path]
```

---

## Prop Drilling Pattern

This implementation uses **controlled component pattern** with prop drilling:

```
State Owner (AgentsListHeader)
│
├─ State: isDialogOpen
├─ Setter: setIsDialogOpen
│
└─> Passes to Child (NewAgentDialog)
    │
    ├─ Prop: open={isDialogOpen}
    ├─ Prop: onOpenChange={setIsDialogOpen}
    │
    └─> Passes to Grandchild (ResponsiveDialog)
        │
        ├─ Prop: open={open}
        ├─ Prop: onOpenChange={onOpenChange}
        │
        └─> Passes to shadcn (Dialog/Drawer)
            │
            └─ Prop: open={open}
            └─ Prop: onOpenChange={onOpenChange}
```

### Why This Pattern:

1. **Single source of truth**: State lives in one place (AgentsListHeader)
2. **Unidirectional data flow**: State flows down, events flow up
3. **Predictable behavior**: Easy to trace where state changes
4. **Component independence**: Each component can be tested in isolation

---

## Design Principles

### 1. Controlled Components

All dialog components are **controlled** (state managed by parent) rather than **uncontrolled** (internal state):

**Benefits:**

- Parent has full control over visibility
- Easier to integrate with other state (e.g., form resets)
- More predictable behavior
- Can be controlled programmatically

### 2. Callback Inversion

Instead of child components reaching up to close dialogs, they receive callbacks:

```typescript
// ✅ Good: Callback pattern
<AgentForm onSuccess={() => closeDialog()} />

// ❌ Bad: Direct state access
<AgentForm dialogState={dialogState} />
```

**Benefits:**

- Loose coupling between components
- Form doesn't know about dialog
- Easier to test and reuse

### 3. Composition over Configuration

The dialog is composed of smaller pieces rather than one large configurable component:

```typescript
<ResponsiveDialog>
  <AgentForm /> {/* Any content can go here */}
</ResponsiveDialog>
```

**Benefits:**

- Flexible: Different content per use case
- Reusable: ResponsiveDialog works with any children
- Maintainable: Each component has single responsibility

### 4. Responsive Abstraction

Mobile vs desktop logic is hidden inside ResponsiveDialog:

```typescript
// Parent doesn't need to know about device type
<ResponsiveDialog open={open} onOpenChange={setOpen}>
  {/* Same API regardless of device */}
</ResponsiveDialog>
```

**Benefits:**

- Simplified parent components
- Consistent API across devices
- Centralized responsive logic

---

## Common Use Cases

### Creating a New Dialog

To create a new dialog following this pattern:

```typescript
// 1. Create wrapper component
export const MyDialog = ({ open, onOpenChange }) => {
  return (
    <ResponsiveDialog
      title="My Dialog"
      description="Dialog description"
      open={open}
      onOpenChange={onOpenChange}
    >
      <MyContent
        onSuccess={() => onOpenChange(false)}
        onCancel={() => onOpenChange(false)}
      />
    </ResponsiveDialog>
  );
};

// 2. Use in parent component
const ParentComponent = () => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <>
      <MyDialog open={isOpen} onOpenChange={setIsOpen} />
      <Button onClick={() => setIsOpen(true)}>Open Dialog</Button>
    </>
  );
};
```

### Programmatic Control

Since state is owned by parent, you can control it programmatically:

```typescript
const AgentsListHeader = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  // Open dialog from any event
  const handleKeyPress = e => {
    if (e.key === 'n' && e.ctrlKey) {
      setIsDialogOpen(true); // Keyboard shortcut
    }
  };

  // Close dialog from anywhere
  const handleEscape = () => {
    setIsDialogOpen(false);
  };

  // ...
};
```

### Conditional Rendering

Prevent rendering dialog until needed:

```typescript
{
  isDialogOpen && (
    <NewAgentDialog open={isDialogOpen} onOpenChange={setIsDialogOpen} />
  );
}
```

This can improve performance by not mounting the dialog until it's needed.

---

## Best Practices

### 1. Keep State Close to Usage

The dialog state lives in `AgentsListHeader` because that's where it's needed. Don't lift state unnecessarily to page level unless multiple siblings need access.

### 2. Use Semantic Callbacks

Name callbacks for their purpose, not their implementation:

```typescript
// ✅ Good
onSuccess={() => closeDialog()}
onCancel={() => closeDialog()}

// ❌ Less clear
onComplete={() => closeDialog()}
onDismiss={() => closeDialog()}
```

### 3. Handle All Close Paths

Ensure dialog closes properly via:

- ✅ Form submission success
- ✅ Cancel button
- ✅ Escape key
- ✅ Outside click
- ✅ Swipe down (mobile)

The `onOpenChange` prop handles all these automatically.

### 4. Prevent State Leaks

Reset form state when dialog closes:

```typescript
const form = useForm({...});

// Reset on dialog close
useEffect(() => {
  if (!open) {
    form.reset();
  }
}, [open, form]);
```

### 5. Loading States

Disable closing during async operations:

```typescript
<Button
  variant="ghost"
  disabled={isPending} // ⚠️ Prevent close during save
  onClick={() => onCancel()}
>
  Cancel
</Button>
```

---

## Troubleshooting

### Dialog Doesn't Open

**Check:**

1. Is state being set? Add console.log in onClick handler
2. Is state being passed correctly? Check prop names match
3. Is ResponsiveDialog receiving correct props?
4. Are there any errors in console?

```typescript
// Debug state flow
const [isDialogOpen, setIsDialogOpen] = useState(false);
console.log('Dialog state:', isDialogOpen);

<Button onClick={() => {
  console.log('Button clicked');
  setIsDialogOpen(true);
}}>
```

### Dialog Doesn't Close

**Check:**

1. Is onOpenChange being called with `false`?
2. Are callbacks connected correctly?
3. Is button type="button" (not type="submit")?
4. Is event propagation stopped somewhere?

```typescript
// Debug callbacks
onSuccess={() => {
  console.log('Success called, closing dialog');
  onOpenChange(false);
}}
```

### Wrong Component on Mobile/Desktop

**Check:**

1. Is useIsMobile() returning expected value?
2. Is MOBILE_BREAKPOINT correct (768)?
3. Test actual device, not just browser resize
4. Check if window object exists (SSR issue)

```typescript
// Debug responsive state
const isMobile = useIsMobile();
console.log('Is mobile:', isMobile, 'Width:', window.innerWidth);
```

### Hydration Mismatch

**Issue:** Server renders one component, client renders another

**Solution:** useIsMobile starts with `undefined` to match server render:

```typescript
const [isMobile, setIsMobile] = useState<boolean | undefined>(undefined);
return !!isMobile; // undefined becomes false initially
```

---

## Testing Considerations

### Unit Testing Components

Each component can be tested independently:

```typescript
// Test ResponsiveDialog
describe('ResponsiveDialog', () => {
  it('renders Dialog on desktop', () => {
    jest.spyOn(hooks, 'useIsMobile').mockReturnValue(false);
    render(<ResponsiveDialog {...props} />);
    expect(screen.getByRole('dialog')).toBeInTheDocument();
  });

  it('renders Drawer on mobile', () => {
    jest.spyOn(hooks, 'useIsMobile').mockReturnValue(true);
    render(<ResponsiveDialog {...props} />);
    // Assert drawer is rendered
  });
});

// Test AgentForm callbacks
describe('AgentForm', () => {
  it('calls onSuccess after successful submission', async () => {
    const onSuccess = jest.fn();
    render(<AgentForm onSuccess={onSuccess} />);
    // Submit form
    await waitFor(() => expect(onSuccess).toHaveBeenCalled());
  });
});
```

### Integration Testing

Test the full flow:

```typescript
describe('New Agent Flow', () => {
  it('opens dialog, creates agent, closes dialog', async () => {
    render(<AgentsListHeader />);

    // Click button
    await userEvent.click(screen.getByText('New Agent'));

    // Dialog opens
    expect(screen.getByRole('dialog')).toBeVisible();

    // Fill form
    await userEvent.type(screen.getByLabelText('Name'), 'Test Agent');

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

## shadcn Component Code Reference

For deeper understanding, here's how the actual shadcn components are structured in our codebase.

### Dialog Implementation

**File:** `src/components/ui/dialog.tsx`

The Dialog component is a thin wrapper around Radix UI primitives:

```typescript
// Root component - passes all props including open/onOpenChange to Radix
function Dialog({
  ...props
}: React.ComponentProps<typeof DialogPrimitive.Root>) {
  return <DialogPrimitive.Root data-slot="dialog" {...props} />;
}
```

**Key Point:** The spread operator `{...props}` passes ALL props through, including:

- `open?: boolean`
- `onOpenChange?: (open: boolean) => void`
- `modal?: boolean`
- `defaultOpen?: boolean`

This is why ResponsiveDialog can pass `open` and `onOpenChange` directly—they flow through to Radix.

### DialogContent Structure

```typescript
function DialogContent({
  className,
  children,
  showCloseButton = true,
  ...props
}: React.ComponentProps<typeof DialogPrimitive.Content> & {
  showCloseButton?: boolean;
}) {
  return (
    <DialogPortal data-slot="dialog-portal">
      <DialogOverlay /> {/* Backdrop */}
      <DialogPrimitive.Content
        className={cn(
          'bg-background fixed top-[50%] left-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 rounded-lg border p-6 shadow-lg duration-200',
          className
        )}
        {...props}
      >
        {children}
        {showCloseButton && (
          <DialogPrimitive.Close>
            {' '}
            {/* This triggers onOpenChange(false) */}
            <XIcon />
            <span className="sr-only">Close</span>
          </DialogPrimitive.Close>
        )}
      </DialogPrimitive.Content>
    </DialogPortal>
  );
}
```

**Key Elements:**

- **DialogPortal**: Renders content in a React portal (outside DOM hierarchy)
- **DialogOverlay**: The semi-transparent backdrop that triggers `onOpenChange(false)` on click
- **DialogPrimitive.Close**: The X button that triggers `onOpenChange(false)` on click
- **Positioning**: `top-[50%] left-[50%] translate-x-[-50%] translate-y-[-50%]` centers the dialog

### DialogOverlay Implementation

```typescript
function DialogOverlay({
  className,
  ...props
}: React.ComponentProps<typeof DialogPrimitive.Overlay>) {
  return (
    <DialogPrimitive.Overlay
      className={cn(
        'fixed inset-0 z-50 bg-black/50', // Semi-transparent backdrop
        'data-[state=open]:animate-in data-[state=open]:fade-in-0',
        'data-[state=closed]:animate-out data-[state=closed]:fade-out-0',
        className
      )}
      {...props}
    />
  );
}
```

When user clicks this overlay, Radix UI calls `onOpenChange(false)`.

### Drawer Implementation

**File:** `src/components/ui/drawer.tsx`

The Drawer component wraps Vaul with a similar API:

```typescript
// Root component - passes all props including open/onOpenChange to Vaul
function Drawer({
  ...props
}: React.ComponentProps<typeof DrawerPrimitive.Root>) {
  return <DrawerPrimitive.Root data-slot="drawer" {...props} />;
}
```

**Key Point:** Just like Dialog, the spread operator passes through `open` and `onOpenChange` to Vaul.

### DrawerContent Structure

```typescript
function DrawerContent({
  className,
  children,
  ...props
}: React.ComponentProps<typeof DrawerPrimitive.Content>) {
  return (
    <DrawerPortal data-slot="drawer-portal">
      <DrawerOverlay /> {/* Backdrop */}
      <DrawerPrimitive.Content
        className={cn(
          'group/drawer-content bg-background fixed z-50 flex h-auto flex-col',
          'data-[vaul-drawer-direction=bottom]:inset-x-0 data-[vaul-drawer-direction=bottom]:bottom-0',
          'data-[vaul-drawer-direction=bottom]:mt-24 data-[vaul-drawer-direction=bottom]:max-h-[80vh]',
          'data-[vaul-drawer-direction=bottom]:rounded-t-lg data-[vaul-drawer-direction=bottom]:border-t',
          className
        )}
        {...props}
      >
        {/* Drag handle indicator - only visible on bottom drawer */}
        <div className="bg-muted mx-auto mt-4 hidden h-2 w-[100px] shrink-0 rounded-full group-data-[vaul-drawer-direction=bottom]/drawer-content:block" />
        {children}
      </DrawerPrimitive.Content>
    </DrawerPortal>
  );
}
```

**Key Elements:**

- **DrawerPortal**: Renders content in a React portal
- **DrawerOverlay**: Backdrop that triggers `onOpenChange(false)` on click
- **Drag handle**: The rounded bar that indicates swipe interaction
- **Direction support**: Drawer can slide from bottom (default), top, left, or right
- **Max height**: `max-h-[80vh]` prevents drawer from covering entire screen

### How Both Components Use onOpenChange

Both Radix UI and Vaul use the same pattern for controlled components:

```typescript
// Internally, both libraries do something like this:

// User action (click X, press Escape, swipe down, etc.)
const handleClose = () => {
  if (props.onOpenChange) {
    props.onOpenChange(false); // Request parent to close
  }
};

// Parent must update state for dialog to actually close
// <Dialog open={state} /> or <Drawer open={state} />
```

Neither component maintains internal state when `open` is provided—they're fully controlled by the parent.

### Why PropTypes Match

Both Radix UI and Vaul were designed with the same controlled component pattern in mind:

**Radix UI (Dialog) API:**

```typescript
interface DialogRootProps {
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
  defaultOpen?: boolean; // uncontrolled mode
  modal?: boolean;
}
```

**Vaul (Drawer) API:**

```typescript
interface DrawerRootProps {
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
  defaultOpen?: boolean; // uncontrolled mode
  modal?: boolean;
}
```

This is NOT a coincidence—Vaul's API was intentionally designed to match Radix UI's pattern, making it easy to swap between them or create abstractions like ResponsiveDialog.

### Code Flow Example

Here's the complete flow from shadcn components up through ResponsiveDialog:

```typescript
// 1. User clicks X button in Dialog
<DialogPrimitive.Close> // shadcn dialog.tsx
  <XIcon />
</DialogPrimitive.Close>

// 2. Radix UI detects click and calls onOpenChange
// Radix internal logic calls: props.onOpenChange?.(false)

// 3. ResponsiveDialog receives callback
<Dialog
  open={open}
  onOpenChange={onOpenChange} // <-- This function gets called
/>

// 4. Callback propagates up to parent
<ResponsiveDialog
  open={isDialogOpen}
  onOpenChange={setIsDialogOpen} // <-- This is the onOpenChange above
/>

// 5. Parent state updates
const [isDialogOpen, setIsDialogOpen] = useState(false);
// setIsDialogOpen(false) is called

// 6. New state flows back down
<ResponsiveDialog open={false} /> // Now closed

// 7. ResponsiveDialog passes to Dialog
<Dialog open={false} />

// 8. Dialog renders with closed state
// Radix UI animates out and unmounts overlay
```

The same flow works identically for Drawer with swipe gestures or backdrop clicks.

---

## Summary

### Key Takeaways

1. **Foundation**: shadcn Dialog (Radix UI) and Drawer (Vaul) expose identical `open` and `onOpenChange` APIs
2. **State ownership**: Dialog state lives in the component that triggers it (AgentsListHeader)
3. **Prop drilling**: State and setter flow down through component tree to shadcn components
4. **Controlled pattern**: Both Dialog and Drawer are fully controlled—they don't manage internal state
5. **Callback pattern**: Children notify parents via callbacks when user attempts to close
6. **Responsive adaptation**: Single API works across devices via useIsMobile hook
7. **Seamless swapping**: ResponsiveDialog switches between Dialog/Drawer without changing state logic

### Why State Props Are Structured This Way

The `open` and `onOpenChange` prop pattern exists because:

1. **Radix UI and Vaul use it**: Both underlying libraries expose this controlled component API
2. **Consistency**: Using the same pattern across both ensures ResponsiveDialog can swap between them
3. **Control flow**: Parent owns state, children request changes via `onOpenChange`
4. **React patterns**: Follows standard controlled component conventions
5. **Predictability**: Unidirectional data flow makes state changes easy to track

### Component Roles

- **AgentsListHeader**: State owner and trigger (controls `isDialogOpen`)
- **NewAgentDialog**: Configuration wrapper (passes state through)
- **ResponsiveDialog**: Adaptive container (chooses Dialog or Drawer)
- **Dialog** (shadcn): Desktop UI wrapper for Radix UI
- **Drawer** (shadcn): Mobile UI wrapper for Vaul
- **DialogPrimitive/DrawerPrimitive**: Actual implementations that read `open` and call `onOpenChange`
- **AgentForm**: Content with callbacks

### Data Flow

```
User Action → State Update → Props Flow Down → UI Updates
     ↑                                              ↓
     ←──────────────── Callbacks Flow Up ←──────────
```

This pattern creates a maintainable, testable, and reusable dialog system that provides an excellent user experience across all devices.
