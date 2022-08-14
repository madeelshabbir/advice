# frozen_string_literal: true

module Shopify
  class Base
    def initialize(domain)
      @shop = Shop.find_by(domain:)
    end

    protected

      attr_reader :shop

      def activate_session(&)
        shop.with_shopify_session(&)
      end

      def session
        @session ||= ShopifyAPI::Auth::Session.new(shop: shop.domain, access_token: shop.token)
      end
  end
end
