# frozen_string_literal: true

class ShopUpdateJob < ShopifyWebhookJob
  private

    def perform_action
      shop.update!(domain: params[:domain])
    end
end
