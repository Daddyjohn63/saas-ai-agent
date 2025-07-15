import {
  parseAsInteger,
  parseAsString,
  useQueryStates,
  parseAsStringEnum
} from 'nuqs';

import { DEFAULT_PAGE } from '@/constants';

import { MeetingStatus } from '../types';

export const useMeetingsFilters = () => {
  return useQueryStates({
    search: parseAsString.withDefault('').withOptions({ clearOnDefault: true }),
    page: parseAsInteger
      .withDefault(DEFAULT_PAGE)
      .withOptions({ clearOnDefault: true }),
    status: parseAsStringEnum(Object.values(MeetingStatus)),
    agentId: parseAsString.withDefault('').withOptions({ clearOnDefault: true })
  });
};
//controls and synchs binding between the url and the local state
// localhost:3000?search=hello <==> useState()

// clearOnDefault is only meaningful if you have a default value.
// Since status has no default, there’s nothing to clear, so you don’t need clearOnDefault for it.
// If you want status to have a default and be cleared from the URL when it matches, you could add .withDefault('someStatus').withOptions({ clearOnDefault: true }).
