# frozen_string_literal: true

module WishlistsHelper
  def app_customer_wishlist_liquid_path
    "#{app_path}/customers/{{customer.id}}/wishlist"
  end

  def app_customer_wishlist_path(customer_id)
    "#{app_path}#{customer_wishlist_path(customer_id)}"
  end

  def app_path
    "/apps/#{ENV.fetch('SHOPIFY_APP_HANDLE')}"
  end
end
