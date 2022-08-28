# frozen_string_literal: true

WEBHOOK_TOPICS = %w(shop/update products/create products/update products/delete).freeze

ShopifyApp.configure do |config|
  config.application_name = ENV.fetch('SHOPIFY_APP_NAME')
  config.old_secret = ''
  config.scope = ENV.fetch('SHOPIFY_ACCESS_SCOPE')
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = ENV.fetch('SHOPIFY_API_VERSION')
  config.shop_session_repository = 'Shop'
  config.reauth_on_access_scope_changes = true
  config.api_key = ENV.fetch('SHOPIFY_API_KEY')
  config.secret = ENV.fetch('SHOPIFY_API_SECRET')
  config.webhooks = WEBHOOK_TOPICS.map do |topic|
    { topic:, address: "webhooks/#{topic.tr('/', '_')}", format: 'json' }
  end
end

Rails.application.config.after_initialize do
  if ShopifyApp.configuration.api_key.present? && ShopifyApp.configuration.secret.present?
    ShopifyAPI::Context.setup(
      api_key: ShopifyApp.configuration.api_key,
      api_secret_key: ShopifyApp.configuration.secret,
      api_version: ShopifyApp.configuration.api_version,
      host_name: URI(ENV.fetch('SHOPIFY_APP_HOST', '')).host || '',
      scope: ShopifyApp.configuration.scope,
      is_private: !ENV.fetch('SHOPIFY_APP_PRIVATE_SHOP', '').empty?,
      is_embedded: ShopifyApp.configuration.embedded_app,
      session_storage: ShopifyApp::SessionRepository,
      logger: Rails.logger,
      private_shop: ENV.fetch('SHOPIFY_APP_PRIVATE_SHOP', nil),
      user_agent_prefix: "ShopifyApp/#{ShopifyApp::VERSION}"
    )

    ShopifyApp::WebhooksManager.add_registrations
  end
end
