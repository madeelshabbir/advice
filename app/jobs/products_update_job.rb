# frozen_string_literal: true

class ProductsUpdateJob < Products::BaseJob
  private

    def perform_action
      products.find_or_initialize_by(external_id: params[:id]).tap do |product|
        product.update!(payload)
        create_or_update_variants(product)
      end
    end
end
