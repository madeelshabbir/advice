# frozen_string_literal: true

module Shopify
  class Product < Base
    def find_in_batches(batch_size: 200, start: nil, &block)
      execute(query: Queries::Graphql::Product::BULK, batch_size:, start:, &block)
    end

    private

      def execute(query:, batch_size:, start:, &block)
        yield build_graphql_response(query:, batch_size:, start:)
        execute(query:, batch_size:, start: client.cursor, &block) if client.next_page?
      end

      def build_graphql_response(query:, batch_size:, start:)
        response = client.execute(resource_name:, query:, variables: { batch_size:, start: })
        Builders::Graphql::Product.new(response).build
      end

      def client
        @client ||= Shopify::Graphql.new(shop.domain)
      end

      def resource_name
        self.class.name.demodulize.underscore.pluralize
      end
  end
end
