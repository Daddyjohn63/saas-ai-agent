import { parseAsInteger, parseAsString, useQueryStates } from 'nuqs';

import { DEFAULT_PAGE } from '@/constants';

export const useAgentsFilters = () => {
  return useQueryStates({
    search: parseAsString.withDefault('').withOptions({ clearOnDefault: true }),
    page: parseAsInteger
      .withDefault(DEFAULT_PAGE)
      .withOptions({ clearOnDefault: true })
  });
};

//controls and synchs binding between the url and the local state - two-way binding
// localhost:3000?search=hello <==> useState()

//pageSize is not included as we dont want the user to ass something silly like 1,000,000 and break the app.

//can only access though a client component
//for server side see params.ts
