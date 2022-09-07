# frozen_string_literal: true

module Products
  class BaseJob < ShopifyWebhookJob
    VARIANT_WHITELISTED_PARAMS = %i(title price compare_at_price).freeze

    protected

      def payload
        {
          external_id: params[:id],
          title: params[:title],
          handle: params[:handle],
          featured_image: params.dig(:images, 0, :src)
        }
      end

      def create_or_update_variants(product)
        params[:variants].each do |params|
          product.variants
                 .find_or_initialize_by(external_id: params[:id])
                 .update!(**params.slice(*VARIANT_WHITELISTED_PARAMS))
        end
      end

      def products
        @products ||= shop.products
      end
  end
end
