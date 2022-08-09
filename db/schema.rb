# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_09_100810) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_products", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "product_id"], name: "index_customer_products_on_customer_id_and_product_id", unique: true
    t.index ["customer_id"], name: "index_customer_products_on_customer_id"
    t.index ["product_id"], name: "index_customer_products_on_product_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.bigint "external_id", null: false
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["external_id"], name: "index_customers_on_external_id", unique: true
    t.index ["shop_id"], name: "index_customers_on_shop_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.string "featured_image"
    t.bigint "external_id", null: false
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_products_on_external_id", unique: true
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "domain", null: false
    t.string "token", null: false
    t.string "access_scopes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_shops_on_domain", unique: true
  end

  add_foreign_key "customer_products", "customers", primary_key: "external_id", on_delete: :cascade
  add_foreign_key "customer_products", "products", primary_key: "external_id", on_delete: :cascade
  add_foreign_key "customers", "shops", on_delete: :cascade
  add_foreign_key "products", "shops", on_delete: :cascade
end
