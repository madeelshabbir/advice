# frozen_string_literal: true

class WishlistMailer < ApplicationMailer
  helper :wishlists

  def discount_notification(product_id)
    @product = Product.find(product_id)
    LogNotifier.info('Test', *resource_and_action, **params)
    mail(subject: I18n.t('mailers.discount_notification.subject', shop_name: @product.shop_name),
         to: wishers_emails)
  end

  private

    def wishers_emails
      @wishers_emails ||= @product.wishers_emails
    end

    def params
      @params ||= {
        product_id: @product.external_id,
        emails: wishers_emails
      }
    end
end
