# frozen_string_literal: true

module Products
  class ImportJob < ApplicationJob
    def perform(domain)
      @shop = Shop.find_by(domain:)
      return if shop.blank?

      import_bulk_records
    end

    private

      attr_reader :shop

      def import_bulk_records
        Shopify::Product.new(shop.domain).find_in_batches do |products|
          products.each do |product|
            shop.products.find_or_initialize_by(external_id: product.external_id).update!(product.as_json)
          end
        end
      end
  end
end
