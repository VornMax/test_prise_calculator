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

ActiveRecord::Schema[7.2].define(version: 2024_10_15_141618) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "contract_discount"
    t.bigint "price_group_id"
    t.index ["price_group_id"], name: "index_customers_on_price_group_id"
  end

  create_table "nomenclature_groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "product_id"
    t.decimal "price", precision: 10, scale: 2
    t.integer "delivery_date"
    t.jsonb "bonuses"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_offers_on_product_id"
  end

  create_table "price_groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_rules", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "nomenclature_group_id"
    t.bigint "price_group_id"
    t.bigint "customer_id"
    t.decimal "original_price", precision: 10, scale: 2
    t.decimal "markup_or_discount", precision: 5, scale: 2
    t.string "rule_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_price_rules_on_customer_id"
    t.index ["nomenclature_group_id"], name: "index_price_rules_on_nomenclature_group_id"
    t.index ["price_group_id"], name: "index_price_rules_on_price_group_id"
    t.index ["product_id"], name: "index_price_rules_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "article"
    t.string "brand"
    t.text "description"
    t.string "image"
    t.bigint "nomenclature_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nomenclature_group_id"], name: "index_products_on_nomenclature_group_id"
  end

  add_foreign_key "customers", "price_groups"
  add_foreign_key "offers", "products"
  add_foreign_key "price_rules", "customers"
  add_foreign_key "price_rules", "nomenclature_groups"
  add_foreign_key "price_rules", "price_groups"
  add_foreign_key "price_rules", "products"
  add_foreign_key "products", "nomenclature_groups"
end
