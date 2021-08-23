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

ActiveRecord::Schema.define(version: 2021_08_23_134601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_carts_on_house_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "pack_id"
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["pack_id"], name: "index_categories_on_pack_id"
    t.index ["sku"], name: "index_categories_on_sku", unique: true
  end

  create_table "charges", force: :cascade do |t|
    t.string "state"
    t.string "stripe_charge_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "coupon_id"
    t.index ["coupon_id"], name: "index_charges_on_coupon_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "logo_url"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.integer "percent_off"
    t.string "name"
    t.string "stripe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "house_details", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.integer "tenants"
    t.integer "size"
    t.string "address"
    t.datetime "contract_starting_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_house_details_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_houses_on_country_id"
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id"
    t.index ["cart_id"], name: "index_items_on_cart_id"
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "email"
    t.string "campaign_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_leads_on_email", unique: true
  end

  create_table "option_types", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_option_types_on_product_id"
  end

  create_table "option_value_variants", force: :cascade do |t|
    t.bigint "variant_id", null: false
    t.bigint "option_value_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_value_id"], name: "index_option_value_variants_on_option_value_id"
    t.index ["variant_id"], name: "index_option_value_variants_on_variant_id"
  end

  create_table "option_values", force: :cascade do |t|
    t.bigint "option_type_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_type_id"], name: "index_option_values_on_option_type_id"
  end

  create_table "order_marketings", force: :cascade do |t|
    t.string "title"
    t.string "step"
    t.boolean "sent"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "bounced"
    t.index ["order_id"], name: "index_order_marketings_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "charge_id"
    t.bigint "billing_id"
    t.bigint "shipping_id"
    t.string "affiliate_link"
    t.boolean "terms"
    t.index ["billing_id"], name: "index_orders_on_billing_id"
    t.index ["charge_id"], name: "index_orders_on_charge_id"
    t.index ["shipping_id"], name: "index_orders_on_shipping_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.date "arrival"
    t.string "flight_number"
    t.string "airport"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "uncomplete", default: false
    t.index ["order_id"], name: "index_pickups_on_order_id"
  end

  create_table "product_details", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_details_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "category_id", null: false
    t.string "name"
    t.string "sku"
    t.float "activation_price"
    t.float "subscription_price"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "country_id", null: false
    t.string "image_url"
    t.float "undiscounted_price"
    t.text "full_description"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["country_id"], name: "index_products_on_country_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "shippings", force: :cascade do |t|
    t.string "address"
    t.text "instructions"
    t.string "state"
    t.string "tracking_id"
    t.date "delivery_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "state"
    t.string "stripe_id"
    t.integer "activation_price_cents"
    t.integer "subscription_price_cents"
    t.bigint "order_id", null: false
    t.datetime "starting_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "paid", default: false
    t.bigint "coupon_id"
    t.index ["coupon_id"], name: "index_subscriptions_on_coupon_id"
    t.index ["order_id"], name: "index_subscriptions_on_order_id"
  end

  create_table "user_marketings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "step"
    t.boolean "sent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "bounced"
    t.boolean "subscribed", default: true
    t.index ["user_id"], name: "index_user_marketings_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_user_services_on_house_id"
    t.index ["service_id"], name: "index_user_services_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "stripe_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.float "activation_price"
    t.float "subscription_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "carts", "houses"
  add_foreign_key "categories", "packs"
  add_foreign_key "charges", "coupons"
  add_foreign_key "house_details", "houses"
  add_foreign_key "houses", "countries"
  add_foreign_key "houses", "users"
  add_foreign_key "items", "carts"
  add_foreign_key "items", "orders"
  add_foreign_key "items", "products"
  add_foreign_key "option_types", "products"
  add_foreign_key "option_value_variants", "option_values"
  add_foreign_key "option_value_variants", "variants"
  add_foreign_key "option_values", "option_types"
  add_foreign_key "order_marketings", "orders"
  add_foreign_key "orders", "billings"
  add_foreign_key "orders", "charges"
  add_foreign_key "orders", "shippings"
  add_foreign_key "orders", "users"
  add_foreign_key "pickups", "orders"
  add_foreign_key "product_details", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "countries"
  add_foreign_key "services", "categories"
  add_foreign_key "subscriptions", "coupons"
  add_foreign_key "subscriptions", "orders"
  add_foreign_key "user_marketings", "users"
  add_foreign_key "user_services", "houses"
  add_foreign_key "user_services", "services"
  add_foreign_key "variants", "products"
end
