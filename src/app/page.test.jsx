import '@testing-library/jest-dom';
import { render, screen } from '@testing-library/react';

import Home from './page';

describe('Basic page test', () => {
  it('should render the page', () => {
    render(<Home />);
    expect(screen.getByText('Counter Test')).toBeDefined();
  });
});
