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

ActiveRecord::Schema.define(version: 2021_06_03_111842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.bigint "user_preference_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_preference_id"], name: "index_carts_on_user_preference_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
  end
  
  create_table "billings", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "charges", force: :cascade do |t|
    t.string "state"
    t.string "stripe_charge_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "logo_url"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "email"
    t.string "campaign_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_leads_on_email", unique: true
  end
  
  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "user_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "country_id", null: false
    t.date "arrival"
    t.integer "stay_duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_user_preferences_on_country_id"
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "user_preference_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_user_services_on_service_id"
    t.index ["user_preference_id"], name: "index_user_services_on_user_preference_id"
  end
  
  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "charge_id", null: false
    t.bigint "billing_id", null: false
    t.bigint "shipping_id", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_id"], name: "index_orders_on_billing_id"
    t.index ["charge_id"], name: "index_orders_on_charge_id"
    t.index ["shipping_id"], name: "index_orders_on_shipping_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.date "arrival"
    t.string "flight_number"
    t.string "airport"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "currency"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carts", "user_preferences"
  add_foreign_key "user_preferences", "countries"
  add_foreign_key "user_preferences", "users"
  add_foreign_key "user_services", "services"
  add_foreign_key "user_services", "user_preferences"
  add_foreign_key "orders", "billings"
  add_foreign_key "orders", "charges"
  add_foreign_key "orders", "shippings"
  add_foreign_key "orders", "users"
  add_foreign_key "pickups", "orders"
  add_foreign_key "product_details", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
end
