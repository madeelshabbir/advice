# frozen_string_literal: true

class ShopifyWebhookJob < ApplicationJob
  extend ShopifyAPI::Webhooks::Handler

  class << self
    def handle(topic:, shop:, body:)
      perform_later(topic:, domain: shop, params: body)
    end
  end

  protected

    def perform(topic:, domain:, params:); end
end
