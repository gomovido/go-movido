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

ActiveRecord::Schema.define(version: 2021_04_26_163236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "city"
    t.string "zipcode"
    t.string "street"
    t.string "floor"
    t.string "building"
    t.string "stairs"
    t.string "door"
    t.string "gate_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "headline"
    t.string "feature_1"
    t.string "feature_2"
    t.string "feature_3"
    t.string "feature_4"
    t.string "affiliate_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_banks_on_category_id"
    t.index ["company_id"], name: "index_banks_on_company_id"
  end

  create_table "billings", force: :cascade do |t|
    t.string "address"
    t.string "bic"
    t.string "iban"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "bank"
    t.bigint "subscription_id", null: false
    t.string "holder_name"
    t.string "account_number"
    t.string "sort_code"
    t.index ["subscription_id"], name: "index_billings_on_subscription_id"
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "university"
    t.string "phone"
    t.string "room_type"
    t.string "lease_duration"
    t.text "requirements"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "flat_id"
    t.string "status"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "sku"
    t.integer "form_timer"
    t.text "description"
    t.string "subtitle"
    t.boolean "open"
    t.integer "sort_id"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "charges", force: :cascade do |t|
    t.string "stripe_charge_id"
    t.string "status"
    t.bigint "subscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscription_id"], name: "index_charges_on_subscription_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "logo_url"
    t.string "cancel_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "policy_link"
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flat_preferences", force: :cascade do |t|
    t.date "move_in"
    t.bigint "user_id", null: false
    t.integer "range_min_price"
    t.integer "range_max_price"
    t.string "location"
    t.string "flat_type"
    t.text "recommandations", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country"
    t.date "move_out"
    t.text "facilities", default: [], array: true
    t.text "coordinates", default: [], array: true
    t.index ["user_id"], name: "index_flat_preferences_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "mobiles", force: :cascade do |t|
    t.string "offer_type"
    t.string "name"
    t.string "area"
    t.float "price"
    t.integer "time_contract"
    t.float "sim_card_price"
    t.boolean "active", default: false
    t.boolean "sim_needed", default: false
    t.integer "data"
    t.string "data_unit"
    t.integer "call"
    t.bigint "category_id", null: false
    t.bigint "company_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_mobiles_on_category_id"
    t.index ["company_id"], name: "index_mobiles_on_company_id"
    t.index ["country_id"], name: "index_mobiles_on_country_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "birthdate"
    t.string "birth_city"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "product_feature_translations", force: :cascade do |t|
    t.bigint "product_feature_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "description"
    t.index ["locale"], name: "index_product_feature_translations_on_locale"
    t.index ["product_feature_id"], name: "index_product_feature_translations_on_product_feature_id"
  end

  create_table "product_features", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mobile_id"
    t.bigint "wifi_id"
    t.integer "order"
    t.index ["mobile_id"], name: "index_product_features_on_mobile_id"
    t.index ["wifi_id"], name: "index_product_features_on_wifi_id"
  end

  create_table "special_offer_translations", force: :cascade do |t|
    t.bigint "special_offer_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["locale"], name: "index_special_offer_translations_on_locale"
    t.index ["special_offer_id"], name: "index_special_offer_translations_on_special_offer_id"
  end

  create_table "special_offers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mobile_id"
    t.bigint "wifi_id"
    t.index ["mobile_id"], name: "index_special_offers_on_mobile_id"
    t.index ["wifi_id"], name: "index_special_offers_on_wifi_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "state"
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "delivery_address"
    t.string "sim"
    t.string "contact_phone"
    t.string "locale"
    t.string "product_type"
    t.bigint "product_id"
    t.index ["address_id"], name: "index_subscriptions_on_address_id"
    t.index ["product_type", "product_id"], name: "index_subscriptions_on_product_type_and_product_id"
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
    t.string "slug"
    t.string "username"
    t.string "provider"
    t.string "uid"
    t.string "stripe_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "wifis", force: :cascade do |t|
    t.string "name"
    t.string "area"
    t.float "price"
    t.integer "time_contract"
    t.integer "data_speed"
    t.float "setup_price"
    t.boolean "active"
    t.bigint "category_id", null: false
    t.bigint "company_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_wifis_on_category_id"
    t.index ["company_id"], name: "index_wifis_on_company_id"
    t.index ["country_id"], name: "index_wifis_on_country_id"
  end

  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "users"
  add_foreign_key "banks", "categories"
  add_foreign_key "banks", "companies"
  add_foreign_key "billings", "subscriptions"
  add_foreign_key "billings", "users"
  add_foreign_key "bookings", "users"
  add_foreign_key "charges", "subscriptions"
  add_foreign_key "flat_preferences", "users"
  add_foreign_key "mobiles", "categories"
  add_foreign_key "mobiles", "companies"
  add_foreign_key "mobiles", "countries"
  add_foreign_key "people", "users"
  add_foreign_key "product_features", "mobiles"
  add_foreign_key "product_features", "wifis"
  add_foreign_key "special_offers", "mobiles"
  add_foreign_key "special_offers", "wifis"
  add_foreign_key "subscriptions", "addresses"
  add_foreign_key "wifis", "categories"
  add_foreign_key "wifis", "companies"
  add_foreign_key "wifis", "countries"
end
