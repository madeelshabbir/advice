# frozen_string_literal: true

class CustomerProduct < ApplicationRecord
  belongs_to :customer, primary_key: :external_id
  belongs_to :product, primary_key: :external_id

  validates :customer_id, uniqueness: { scope: :product_id }

  after_create_commit :append_customer_id_tag
  after_destroy :delete_customer_id_tag

  private

    %i(append delete).each do |action|
      define_method("#{action}_customer_id_tag") do
        Shopify::Product.new(product.shop.domain).send("#{action}_tag", product_id:, tag: "customer_id:#{customer_id}:")
      end
    end
end
