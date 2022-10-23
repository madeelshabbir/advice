# frozen_string_literal: true

module WishlistsHelper
  include SharedHelper

  def app_customer_wishlist_liquid_path
    "#{app_path}/customers/{{customer.id}}/wishlist"
  end

  def app_customer_wishlist_path(customer_id)
    "#{app_path}#{customer_wishlist_path(customer_id)}"
  end

  def product_path(product)
    "/products/#{product.handle}"
  end

  def product_url(product)
    "https://#{product.shop.domain}/products/#{product.handle}"
  end
end
