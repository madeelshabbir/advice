# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorageWithScopes

  alias_attribute :shopify_domain, :domain
  alias_attribute :shopify_token, :token

  def api_version
    ShopifyApp.configuration.api_version
  end
end
