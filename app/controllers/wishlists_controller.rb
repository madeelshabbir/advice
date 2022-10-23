# frozen_string_literal: true

class WishlistsController < ApplicationController
  include ShopifyApp::RequireKnownShop
  include WishlistsHelper

  skip_before_action :verify_authenticity_token

  before_action :create_or_update_customer, only: :update

  def show
    @pagy, @products = pagy_countless(customer.wishlist, items: 50)

    if params[:page].present?
      render :scrollable_list, content_type: 'application/liquid'
    else
      render :show, content_type: 'application/liquid'
    end
  end

  def update
    customer.customer_products.find_or_create_by!(product_id:)
    redirect_to(app_customer_wishlist_path(customer.external_id))
  end

  def destroy
    customer.customer_products.find_by!(product_id:).destroy!
    redirect_to(app_customer_wishlist_path(customer.external_id))
  end

  private

    def create_or_update_customer
      current_shop.customers.find_or_initialize_by(external_id: params[:customer_id]).update(customer_params)
    end

    def product_id
      @product_id ||= Product.find_by!(external_id: params[:product_id]).external_id
    end

    def customer
      @customer ||= current_shop.customers.find_by!(external_id: params[:customer_id])
    end

    def customer_params
      params.permit(%i(first_name last_name email))
    end

    def current_shop
      @current_shop ||= Shop.find_by!(domain: current_shopify_domain)
    end
end
