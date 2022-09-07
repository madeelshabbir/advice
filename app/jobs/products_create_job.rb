# frozen_string_literal: true

class ProductsCreateJob < Products::BaseJob
  private

    def perform_action
      products.find_or_create_by!(payload).tap do |product|
        create_or_update_variants(product)
      end
    end
end
