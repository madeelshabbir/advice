# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorageWithScopes

  alias_attribute :shopify_domain, :domain
  alias_attribute :shopify_token, :token

  has_many :customers, dependent: :destroy
  has_many :products, dependent: :destroy

  after_update :setup, if: :saved_change_to_shopify_token?
  after_create_commit :setup

  def api_version
    ShopifyApp.configuration.api_version
  end

  private

    def setup
      export_shopify_assets
      import_shopify_products
    end

    def export_shopify_assets
      Assets::ExportJob.perform_later(domain)
    end

    def import_shopify_products
      Products::ImportJob.perform_later(domain)
    end
end
