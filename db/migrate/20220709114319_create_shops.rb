# frozen_string_literal: true

class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops  do |t|
      t.string :domain, null: false
      t.string :token, null: false
      t.string :access_scopes
      t.index :domain, unique: true

      t.timestamps
    end
  end
end
