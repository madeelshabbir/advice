# frozen_string_literal: true

module Shopify
  class Graphql < Base
    def execute(resource_name:, query:, variables:)
      @resource_name = resource_name
      @response = client.query(query:, variables:).body
    end

    def next_page?
      response.dig('data', resource_name, 'pageInfo', 'hasNextPage')
    end

    def cursor
      response.dig('data', resource_name, 'edges').to_a.last.to_h.dig('cursor')
    end

    private

      attr_reader :resource_name, :response

      def client
        @client ||= ShopifyAPI::Clients::Graphql::Admin.new(session:)
      end
  end
end
