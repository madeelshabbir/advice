# frozen_string_literal: true

class ProductsCreateJob < Products::BaseJob
  private

    def perform_action
      products.create!(payload)
    end
end
