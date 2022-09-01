# frozen_string_literal: true

class CreateCustomerProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_products do |t|
      t.references :customer, index: true, foreign_key: { primary_key: :external_id, on_delete: :cascade }
      t.references :product, index: true, foreign_key: { primary_key: :external_id, on_delete: :cascade }
      t.index %i(customer_id product_id), unique: true

      t.timestamps
    end
  end
end
