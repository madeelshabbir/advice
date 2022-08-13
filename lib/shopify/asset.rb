# frozen_string_literal: true

module Shopify
  class Asset < Base
    SOURCE_DIRECTORY = 'app/assets/shopify/'

    def find_or_create!(theme_id:, key:)
      activate_session do
        find_by!(theme_id:, key:)
      rescue ShopifyAPI::Errors::HttpResponseError
        create!(theme_id:, key:)
      end
    end

    private

      def find_by!(theme_id:, key:)
        ShopifyAPI::Asset.all(theme_id:, asset: { key: }).first
      end

      def build(theme_id:, key:)
        ShopifyAPI::Asset.new.tap do |asset|
          asset.theme_id = theme_id
          asset.key = key
          asset.value = content(key)
        end
      end

      def create!(theme_id:, key:)
        build(theme_id:, key:).tap(&:save!)
      end

      def content(key)
        ERB.new(File.read(SOURCE_DIRECTORY + key)).result(binding)
      end
  end
end
