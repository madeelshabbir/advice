# frozen_string_literal: true

module Queries
  module Graphql
    module Product
      BULK = <<~GQL
        query($batch_size: Int, $start: String) {
          products(first: $batch_size, after: $start) {
            pageInfo {
              hasNextPage
            }
            edges {
              cursor
              node {
                id
                title
                handle
                images(first: 1) {
                  nodes {
                    url
                  }
                }
                variants(first: 100) {
                  nodes {
                    id
                    price
                    title
                    compareAtPrice
                  }
                }
              }
            }
          }
        }
      GQL
    end
  end
end
