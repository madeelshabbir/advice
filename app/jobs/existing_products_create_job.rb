# frozen_string_literal: true

class ExistingProductsCreateJob < ApplicationJob
  def perform(domain)
    @shop = Shop.find_by(domain:)
    return if shop.blank?

    create_bulk_records
  end

  private

    attr_reader :shop

    def create_bulk_records
      Shopify::Product.new(shop.domain).find_in_batches do |products|
        shop.products.create!(products.as_json)
      end
    end
end
