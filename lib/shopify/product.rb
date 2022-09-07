# frozen_string_literal: true

module Shopify
  class Product < Base
    %i(append delete).each do |action|
      define_method("#{action}_tag") do |product_id:, tag:|
        activate_session { update_tags(product_id:, tag:, action:) }
      end
    end

    def find_in_batches(batch_size: 9, start: nil, &block)
      execute(query: Queries::Graphql::Product::BULK, batch_size:, start:, &block)
    end

    private

      def find_by(id)
        ShopifyAPI::Product.find(id:)
      rescue ShopifyAPI::Errors::HttpResponseError
        nil
      end

      def update_tags(product_id:, tag:, action:)
        find_by(product_id).tap do |product|
          break if product.nil?

          product.tags = product.tags.split(', ').tap do |tags|
            tags.send(action, tag)
          end.join(', ')
          product.save!
        end
      end

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
