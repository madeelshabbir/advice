# frozen_string_literal: true

class CreateCustomer < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.bigint :external_id, null: false
      t.index :email, unique: true
      t.index :external_id, unique: true
      t.references :shop, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
