# frozen_string_literal: true

class AssetsCreateJob < ApplicationJob
  def perform(domain)
    Shopify::Theme.new(domain).all.each do |theme|
      file_paths.each do |key|
        Shopify::Asset.new(domain).find_or_create!(theme_id: theme.id, key:)
      rescue ShopifyAPI::Errors::HttpResponseError
        Rails.logger.error(I18n.t('shopify.assets.errors.create', theme: theme.id, key:))
      end
    end
  end

  private

    def file_paths
      @file_paths ||= Dir.glob("#{Shopify::Asset::SOURCE_DIRECTORY}**/*.liquid").map do |path|
        path.sub(Shopify::Asset::SOURCE_DIRECTORY, '')
      end
    end
end
