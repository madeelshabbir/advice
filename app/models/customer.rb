# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :shop

  has_many :customer_products, primary_key: :external_id, dependent: :destroy
  has_many :wishlist, through: :customer_products, source: :product

  validates :external_id, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
