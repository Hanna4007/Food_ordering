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

ActiveRecord::Schema[7.0].define(version: 2024_03_24_132641) do
  create_table "company_orders", force: :cascade do |t|
    t.decimal "company_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "in progress", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.string "name"
    t.decimal "unit_price", precision: 10, scale: 2
    t.decimal "total_price", precision: 10, scale: 2
    t.integer "quantity"
    t.integer "personal_order_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_order_id"], name: "index_order_items_on_personal_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "personal_orders", force: :cascade do |t|
    t.decimal "total_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "company_order_id"
    t.string "status", default: "in progress", null: false
    t.index ["company_order_id"], name: "index_personal_orders_on_company_order_id"
    t.index ["user_id"], name: "index_personal_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_products_on_restaurant_id"
  end

  create_table "products_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.index ["user_id", "product_id"], name: "index_products_users_on_user_id_and_product_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname", null: false
    t.string "phone_number", null: false
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "order_items", "personal_orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "personal_orders", "company_orders"
  add_foreign_key "personal_orders", "users"
  add_foreign_key "products", "restaurants"
end
