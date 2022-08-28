# frozen_string_literal: true

class ShopifyWebhookJob < ApplicationJob
  extend ShopifyAPI::Webhooks::Handler

  class << self
    def handle(shop:, body:, **)
      perform_later(domain: shop, params: body)
    end
  end

  protected

    attr_reader :domain, :params

    def perform(domain:, params:)
      @domain = domain
      @params = params.with_indifferent_access

      perform_action
    end

    def shop
      @shop ||= Shop.find_by!(domain:)
    end
end
