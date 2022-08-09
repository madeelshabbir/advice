# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :shop

  has_many :customer_products, primary_key: :external_id, dependent: :destroy
  has_many :customers, through: :customer_products

  validates :external_id, :title, presence: true
end
