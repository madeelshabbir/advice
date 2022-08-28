# frozen_string_literal: true

class ProductsDeleteJob < ShopifyWebhookJob
  private

    def perform_action
      shop.products.find_by!(external_id: params[:id]).destroy!
    end
end
