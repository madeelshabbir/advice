# frozen_string_literal: true

module Products
  class BaseJob < ShopifyWebhookJob
    protected

      def payload
        {
          external_id: params[:id],
          title: params[:title],
          featured_image: params.dig(:images, 0, :src)
        }
      end

      def products
        @products ||= shop.products
      end
  end
end
