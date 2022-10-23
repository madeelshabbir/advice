# frozen_string_literal: true

module SharedHelper
  def app_path
    "/apps/#{ENV.fetch('SHOPIFY_APP_HANDLE')}"
  end
end
