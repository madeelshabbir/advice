# frozen_string_literal: true

module Builders
  module Graphql
    class Product
      WHITELISTED_PARAMS = %i(external_id title handle featured_image).freeze
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
            whitelist_param(product)
          end
        end

        def whitelist_param(product)
          product.tap do |record|
            record.external_id = record.id.split('/').last
            record.featured_image = record.images.edges.pick(:node)&.url
          end.to_h.slice(*WHITELISTED_PARAMS).convert_to_object
        end

        def log_errors
          params.errors.pluck(:message).each do |message|
            Rails.logger.error(message)
          end
        end
    end
  end
end
