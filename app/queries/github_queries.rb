module GithubQueries

  Search = Github::Client.parse <<-'GRAPHQL'
    query ($query: String!, $type: SearchType!, $numOfResults: Int!, $nextPageCursor: String) {
      search(type: $type, query: $query, first: $numOfResults, after: $nextPageCursor) {
        pageInfo {
          endCursor
          hasNextPage
        }
        edges {
          node {
            ... on Repository {
              primaryLanguage {
                name
              }
            }
          }
        }
      }
    }
  GRAPHQL

end
