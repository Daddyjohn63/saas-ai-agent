'use client';

import { ErrorState } from '@/components/error-state';
import { LoadingState } from '@/components/loading-state';

import { useTRPC } from '@/trpc/client';

import { useSuspenseQuery } from '@tanstack/react-query';
import { DataTable } from '../components/data-table';
import { columns, Payment } from '../components/columns';

const mockData: Payment[] = [
  {
    id: '728ed52f',
    amount: 100,
    status: 'pending',
    email: 'm@example.com'
  }
  // ...
];

export const AgentsView = () => {
  const trpc = useTRPC();
  //agents - is the router name we provided in _app.ts
  //getMany is the procedure we cretaed in agents/server/procedures.ts
  const { data } = useSuspenseQuery(trpc.agents.getMany.queryOptions());

  // return <div>{JSON.stringify(data, null, 2)}</div>;
  return (
    <div>
      <DataTable data={mockData} columns={columns} />
    </div>
  );
};

export const AgentsViewLoading = () => {
  return (
    <LoadingState
      title="Loading Agents "
      description="This may take a few seconds"
    />
  );
};

export const AgentsViewError = () => {
  return (
    <ErrorState
      title="Error Loading Agents"
      description="Something went wrong"
    />
  );
};
