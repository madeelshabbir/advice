# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product, primary_key: :external_id

  validates :external_id, :title, presence: true
  validates :external_id, uniqueness: { scope: :product_id }
  validates :title, uniqueness: { scope: :product_id }
end
