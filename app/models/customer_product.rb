# frozen_string_literal: true

class CustomerProduct < ApplicationRecord
  belongs_to :customer, primary_key: :external_id
  belongs_to :product, primary_key: :external_id

  validates :customer_id, uniqueness: { scope: :product_id }
end
