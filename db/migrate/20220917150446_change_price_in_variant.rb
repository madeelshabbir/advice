# frozen_string_literal: true

class ChangePriceInVariant < ActiveRecord::Migration[7.0]
  def change
    change_column_null :variants, :price, false
  end
end
