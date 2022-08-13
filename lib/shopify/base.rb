# frozen_string_literal: true

module Shopify
  class Base
    attr_reader :shop

    def initialize(domain)
      @shop = Shop.find_by(domain:)
    end

    protected

      def activate_session(&)
        shop.with_shopify_session(&)
      end
  end
end
