# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_06_125352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "country"
    t.string "city"
    t.string "zipcode"
    t.string "street"
    t.string "floor"
    t.string "internet_status"
    t.string "mobile_phone"
    t.string "building"
    t.string "stairs"
    t.string "door"
    t.string "gate_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.boolean "phoned"
    t.boolean "valid_address"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
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
    t.index ["subscription_id"], name: "index_billings_on_subscription_id"
    t.index ["user_id"], name: "index_billings_on_user_id"
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
    t.index ["slug"], name: "index_categories_on_slug", unique: true
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

  create_table "product_features", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_features_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "description"
    t.integer "price"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rating"
    t.integer "reviews"
    t.string "logo_url"
    t.string "slug"
    t.string "sku"
    t.boolean "unlimited_data"
    t.boolean "unlimited_call"
    t.boolean "obligation"
    t.string "time_contract"
    t.string "data_limit"
    t.string "delivery_price"
    t.string "delivery_time"
    t.boolean "delivery"
    t.float "sim_card_price"
    t.string "call_limit"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "state"
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "delivery_address"
    t.index ["address_id"], name: "index_subscriptions_on_address_id"
    t.index ["product_id"], name: "index_subscriptions_on_product_id"
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
    t.string "country"
    t.boolean "not_housed"
    t.string "slug"
    t.string "username"
    t.string "birth_city"
    t.date "birthdate"
    t.string "city"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "billings", "subscriptions"
  add_foreign_key "billings", "users"
  add_foreign_key "product_features", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "subscriptions", "addresses"
  add_foreign_key "subscriptions", "products"
end
