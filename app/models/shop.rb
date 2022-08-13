# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorageWithScopes

  alias_attribute :shopify_domain, :domain
  alias_attribute :shopify_token, :token

  has_many :customers, dependent: :destroy
  has_many :products, dependent: :destroy

  after_create_commit :create_shopify_assets

  def api_version
    ShopifyApp.configuration.api_version
  end

  private

    def create_shopify_assets
      AssetsCreateJob.perform_later(domain)
    end
end
