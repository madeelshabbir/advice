# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :shop

  has_many :variants, primary_key: :external_id, dependent: :destroy
  has_many :customer_products, primary_key: :external_id, dependent: :destroy
  has_many :customers, through: :customer_products

  accepts_nested_attributes_for :variants

  validates :external_id, :title, :handle, presence: true
  validates :external_id, uniqueness: true
end
