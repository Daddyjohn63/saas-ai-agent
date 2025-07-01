import '@testing-library/jest-dom';
import { render, screen } from '@testing-library/react';
import { AgentsListHeader } from '../components/agents-list-header';

//mock avatar as npm package using @dicebear/core which is ESM only and jest config would not ignore.
jest.mock('@/components/generated-avatar', () => ({
  GeneratedAvatar: () => <div data-testid="mock-avatar">Mock Avatar</div>
}));

// Mock nuqs useQueryStates to avoid Next.js router dependency
jest.mock('nuqs', () => ({
  useQueryStates: () => [
    { search: '', page: 1 }, // default filters
    jest.fn()
  ],
  parseAsString: { withDefault: () => ({ withOptions: () => {} }) },
  parseAsInteger: { withDefault: () => ({ withOptions: () => {} }) }
}));

describe('AgentsListHeader', () => {
  it('renders the agents-list-header with all elements', () => {
    render(<AgentsListHeader />);

    // Check for header
    expect(screen.getByText('My Agents')).toBeInTheDocument();
    // Check for New Agent button
    expect(
      screen.getByRole('button', { name: /New Agent/i })
    ).toBeInTheDocument();
    // Check for search filter (by role or placeholder)
    expect(screen.getByRole('textbox')).toBeInTheDocument();
    // Clear button should not be visible initially (no filter)
    expect(
      screen.queryByRole('button', { name: /Clear/i })
    ).not.toBeInTheDocument();
  });
});
