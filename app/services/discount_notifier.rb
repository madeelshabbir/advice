# frozen_string_literal: true

class DiscountNotifier
  def initialize(product, params)
    @product = product
    @params = params
  end

  def notify
    return unless notify_wishers?

    WishlistMailer.discount_notification(product.id).deliver_later!
  end

  private

    attr_reader :product, :params

    def notify_wishers?
      product.wishers.present? &&
        product.variants.where(external_id: params[:variants].pluck(:id)).detect do |variant|
          offer_changed?(variant, new_variants(variant.external_id))
        end.present?
    end

    def offer_changed?(variant, new_variant)
      new_variant.present? && new_variant.last.present? && new_variant.second.to_d < new_variant.third.to_d &&
        (variant.price != new_variant.second.to_d || variant.compare_at_price != new_variant.last.to_d)
    end

    def new_variants(id)
      new_variants_prices.detect { |variant| variant.first == id }
    end

    def new_variants_prices
      @new_variants_prices ||= params[:variants].pluck(:id, :price, :compare_at_price)
    end
end
