# frozen_string_literal: true

class CreateProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :featured_image
      t.bigint :external_id, null: false
      t.index :external_id, unique: true
      t.references :shop, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
