// src/modules/auth/ui/views/sign-in-view.test.tsx
import '@testing-library/jest-dom';
import {
  render,
  screen,
  fireEvent,
  waitFor,
  act
} from '@testing-library/react';
import { SignInView } from './sign-in-view';
import { authClient } from '@/lib/auth-client';

// Mock the auth client
jest.mock('@/lib/auth-client', () => ({
  authClient: {
    signIn: {
      email: jest.fn(),
      social: jest.fn()
    }
  }
}));

describe('SignInView', () => {
  beforeEach(() => {
    // Clear all mocks before each test
    jest.clearAllMocks();
  });

  it('renders the sign in form with all elements', () => {
    render(<SignInView />);

    // Check for main elements
    expect(screen.getByText('Welcome back')).toBeInTheDocument();
    expect(screen.getByText('Login to your account')).toBeInTheDocument();

    // Check form inputs
    expect(screen.getByLabelText('Email')).toBeInTheDocument();
    expect(screen.getByLabelText('Password')).toBeInTheDocument();

    // Check buttons
    expect(screen.getByRole('button', { name: 'Sign in' })).toBeInTheDocument();
    expect(
      screen.getByRole('button', { name: 'Sign in with Google' })
    ).toBeInTheDocument();
    expect(
      screen.getByRole('button', { name: 'Sign in with GitHub' })
    ).toBeInTheDocument();

    // Check sign up link
    expect(screen.getByText('Sign up')).toHaveAttribute('href', '/sign-up');
  });

  it('validates email format', async () => {
    render(<SignInView />);

    const emailInput = screen.getByLabelText('Email');
    const submitButton = screen.getByRole('button', { name: 'Sign in' });

    // Test invalid email
    await act(async () => {
      fireEvent.change(emailInput, { target: { value: 'invalid@email' } });
      fireEvent.click(submitButton);
    });

    await waitFor(() => {
      expect(screen.getByText('Invalid email')).toBeInTheDocument();
    });

    // Test valid email
    await act(async () => {
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.click(submitButton);
    });

    await waitFor(() => {
      expect(screen.queryByText('Invalid email')).not.toBeInTheDocument();
    });
  });

  it('validates required password', async () => {
    render(<SignInView />);

    const emailInput = screen.getByLabelText('Email');
    const submitButton = screen.getByRole('button', { name: 'Sign in' });

    // Enter valid email but no password
    await act(async () => {
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.click(submitButton);
    });

    await waitFor(() => {
      expect(screen.getByText('Password is required')).toBeInTheDocument();
    });
  });

  it('handles email sign in submission', async () => {
    render(<SignInView />);

    const emailInput = screen.getByLabelText('Email');
    const passwordInput = screen.getByLabelText('Password');
    const submitButton = screen.getByRole('button', { name: 'Sign in' });

    // Fill in form
    await act(async () => {
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      fireEvent.click(submitButton);
    });

    await waitFor(() => {
      expect(authClient.signIn.email).toHaveBeenCalledWith(
        {
          email: 'test@example.com',
          password: 'password123',
          callbackURL: '/'
        },
        expect.any(Object)
      );
    });
  });

  it('handles Google social sign in', async () => {
    render(<SignInView />);

    const googleButton = screen.getByRole('button', {
      name: 'Sign in with Google'
    });

    await act(async () => {
      fireEvent.click(googleButton);
    });

    await waitFor(() => {
      expect(authClient.signIn.social).toHaveBeenCalledWith(
        {
          provider: 'google',
          callbackURL: '/'
        },
        expect.any(Object)
      );
    });
  });

  it('handles GitHub social sign in', async () => {
    render(<SignInView />);

    const githubButton = screen.getByRole('button', {
      name: 'Sign in with GitHub'
    });

    await act(async () => {
      fireEvent.click(githubButton);
    });

    await waitFor(() => {
      expect(authClient.signIn.social).toHaveBeenCalledWith(
        {
          provider: 'github',
          callbackURL: '/'
        },
        expect.any(Object)
      );
    });
  });

  it('displays error message when sign in fails', async () => {
    // Mock the auth client to return an error
    (authClient.signIn.email as jest.Mock).mockImplementation(
      (_, { onError }) => {
        onError({ error: { message: 'Invalid credentials' } });
      }
    );

    render(<SignInView />);

    const emailInput = screen.getByLabelText('Email');
    const passwordInput = screen.getByLabelText('Password');
    const submitButton = screen.getByRole('button', { name: 'Sign in' });

    // Fill in form
    await act(async () => {
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      fireEvent.click(submitButton);
    });

    await waitFor(() => {
      expect(screen.getByText('Invalid credentials')).toBeInTheDocument();
    });
  });

  it('disables buttons during pending state', async () => {
    // Mock the auth client to not resolve immediately
    (authClient.signIn.email as jest.Mock).mockImplementation(() => {
      return new Promise(() => {}); // Never resolves
    });

    render(<SignInView />);

    const emailInput = screen.getByLabelText('Email');
    const passwordInput = screen.getByLabelText('Password');
    const submitButton = screen.getByRole('button', { name: 'Sign in' });

    // Fill in form
    await act(async () => {
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      fireEvent.click(submitButton);
    });

    // Check if button is disabled
    expect(submitButton).toBeDisabled();
  });
});
