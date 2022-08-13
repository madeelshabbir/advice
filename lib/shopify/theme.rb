# frozen_string_literal: true

module Shopify
  class Theme < Base
    def all(role: nil)
      activate_session { ShopifyAPI::Theme.all(role:) }
    end
  end
end
