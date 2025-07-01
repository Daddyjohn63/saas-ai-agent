//TEST THAT THE FORM SUBMITS
import '@testing-library/jest-dom';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { AgentsListHeader } from '../components/agents-list-header';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

// 🧠 Spy to verify the mutation gets called
const mockMutation = jest.fn();

// 🧪 Mock tRPC client
jest.mock('@/trpc/client', () => ({
  useTRPC: () => ({
    agents: {
      create: {
        mutationOptions: () => ({
          mutationFn: mockMutation
        })
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

// 🎭 Other mocks
jest.mock('@/components/generated-avatar', () => ({
  GeneratedAvatar: () => <div data-testid="mock-avatar">Mock Avatar</div>
}));
jest.mock('nuqs', () => ({
  useQueryStates: () => [{ search: '', page: 1 }, jest.fn()],
  parseAsString: { withDefault: () => ({ withOptions: () => {} }) },
  parseAsInteger: { withDefault: () => ({ withOptions: () => {} }) }
}));

describe('AgentsListHeader dialog form', () => {
  it('submits the form with name and instructions', async () => {
    const queryClient = new QueryClient();

    render(
      <QueryClientProvider client={queryClient}>
        <AgentsListHeader />
      </QueryClientProvider>
    );

    // 1. Open the dialog
    fireEvent.click(screen.getByRole('button', { name: /New Agent/i }));
    const dialog = await screen.findByRole('dialog');
    expect(dialog).toBeInTheDocument();

    // 2. Fill in form fields
    fireEvent.change(screen.getByLabelText('Name'), {
      target: { value: 'Agent Smith' }
    });

    fireEvent.change(screen.getByLabelText('Instructions'), {
      target: { value: 'Intercept all humans' }
    });

    // 3. Submit the form
    fireEvent.click(screen.getByRole('button', { name: /Create/i }));

    // 4. Wait for the mock mutation to be called
    await waitFor(() => {
      expect(mockMutation).toHaveBeenCalledWith({
        name: 'Agent Smith',
        instructions: 'Intercept all humans'
      });
    });
  });
});
