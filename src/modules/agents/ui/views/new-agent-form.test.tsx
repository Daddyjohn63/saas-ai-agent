//TEST THE DIALOG APPEARS ON CLICK
import '@testing-library/jest-dom';
import { render, screen, fireEvent } from '@testing-library/react';
import { AgentsListHeader } from '../components/agents-list-header';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

// Mock tRPC client to isolate the test from provider requirements
jest.mock('@/trpc/client', () => ({
  useTRPC: () => ({
    agents: {
      create: {
        mutationOptions: () => ({})
      },
      getMany: {
        queryOptions: () => ({})
      },
      getOne: {
        queryOptions: () => ({})
      }
    }
  })
}));

// Mock dependencies as in your other test file
jest.mock('@/components/generated-avatar', () => ({
  GeneratedAvatar: () => <div data-testid="mock-avatar">Mock Avatar</div>
}));
jest.mock('nuqs', () => ({
  useQueryStates: () => [{ search: '', page: 1 }, jest.fn()],
  parseAsString: { withDefault: () => ({ withOptions: () => {} }) },
  parseAsInteger: { withDefault: () => ({ withOptions: () => {} }) }
}));

describe('AgentsListHeader dialog', () => {
  it('dialog is not present until button is clicked, then form appears', async () => {
    const queryClient = new QueryClient();

    render(
      <QueryClientProvider client={queryClient}>
        <AgentsListHeader />
      </QueryClientProvider>
    );

    // 1. Dialog should not be present initially
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument();

    // 2. Click the "New Agent" button
    fireEvent.click(screen.getByRole('button', { name: /New Agent/i }));

    // 3. Dialog should now be present
    const dialog = await screen.findByRole('dialog');
    expect(dialog).toBeInTheDocument();

    // 4. Check for dialog heading and form fields
    expect(
      screen.getByRole('heading', { level: 2, name: /New Agent/i })
    ).toBeInTheDocument();
    expect(screen.getByText('Create a new agent')).toBeInTheDocument();
    expect(screen.getByLabelText('Name')).toBeInTheDocument();
    expect(screen.getByLabelText('Instructions')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Create/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Cancel/i })).toBeInTheDocument();
  });
});
