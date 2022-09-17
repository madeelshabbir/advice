# frozen_string_literal: true

class WishlistMailer < ApplicationMailer
  helper :wishlists

  def discount_notification(product)
    @product = product
    mail(subject: I18n.t('mailers.discount_notification.subject', shop_name: product.shop_name),
         to: @product.wishers_emails)
  end
end
