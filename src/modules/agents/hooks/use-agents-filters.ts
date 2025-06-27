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

//controls and synchs binding between the url and the local state
// localhost:3000?search=hello <==> useState()
