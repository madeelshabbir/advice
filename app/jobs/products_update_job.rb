# frozen_string_literal: true

class ProductsUpdateJob < Products::BaseJob
  private

    def perform_action
      products.find_or_initialize_by(external_id: params[:id]).update!(payload)
    end
end
