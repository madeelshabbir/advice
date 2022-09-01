# frozen_string_literal: true

class AddHandleInProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :products, bulk: true do |t|
      t.string :handle, null: false
      t.index :handle, unique: true
    end
  end
end
