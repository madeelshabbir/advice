# frozen_string_literal: true

module Builders
  module Graphql
    class Product
      WHITELISTED_PARAMS = %i(external_id title handle featured_image variants_attributes).freeze
      VARIANT_WHITELISTED_PARAMS = %i(external_id title price compare_at_price).freeze
      EMPTY_RESPONSE = [].freeze

      def initialize(params)
        @params = params.convert_to_object
      end

      def build
        return payload if params.errors.blank?

        log_errors
        EMPTY_RESPONSE
      end

      private

        attr_reader :params

        def payload
          params.data.products.edges.pluck(:node).map do |product|
            whitelist_params(product)
          end
        end

        def whitelist_params(product)
          product.tap do |record|
            record.external_id = record.id.split('/').last
            record.featured_image = record.images.nodes.to_a.first&.url
            record.variants_attributes = record.variants.nodes.to_a.map do |variant|
              variant_whitelist_params(variant)
            end
          end.to_h.slice(*WHITELISTED_PARAMS).convert_to_object
        end

        def variant_whitelist_params(variant)
          variant.tap do |record|
            record.external_id = record.id.split('/').last
            record.compare_at_price = record.compareAtPrice
          end.to_h.slice(*VARIANT_WHITELISTED_PARAMS)
        end

        def log_errors
          params.errors.pluck(:message).each do |message|
            Rails.logger.error(message)
          end
        end
    end
  end
end
