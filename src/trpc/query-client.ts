import {
  defaultShouldDehydrateQuery,
  QueryClient
} from '@tanstack/react-query';
/**
 * Creates and returns a new {@link QueryClient} instance with custom default options.
 *
 * The returned client sets a 30-second stale time for queries and customizes dehydration to include queries that are either normally dehydrated or have a status of 'pending'.
 *
 * @returns A configured {@link QueryClient} instance.
 */
export function makeQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 30 * 1000
      },
      dehydrate: {
        // serializeData: superjson.serialize,
        shouldDehydrateQuery: query =>
          defaultShouldDehydrateQuery(query) || query.state.status === 'pending'
      },
      hydrate: {
        // deserializeData: superjson.deserialize,
      }
    }
  });
}
