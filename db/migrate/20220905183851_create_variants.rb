# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|
      t.string :title, null: false
      t.decimal :price
      t.decimal :compare_at_price
      t.bigint :external_id, null: false
      t.index %i(external_id product_id), unique: true
      t.index %i(title product_id), unique: true
      t.references :product, index: true, foreign_key: { primary_key: :external_id, on_delete: :cascade }

      t.timestamps
    end
  end
end
