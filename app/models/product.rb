# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :shop

  has_many :variants, primary_key: :external_id, dependent: :destroy
  has_many :customer_products, primary_key: :external_id, dependent: :destroy
  has_many :wishers, through: :customer_products, source: :customer

  accepts_nested_attributes_for :variants

  validates :external_id, :title, :handle, presence: true
  validates :external_id, uniqueness: true

  delegate :name, :domain, to: :shop, prefix: :shop

  def wishers_emails
    wishers.pluck(:email)
  end
end
