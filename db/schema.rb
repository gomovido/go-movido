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

ActiveRecord::Schema.define(version: 2020_10_14_211053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "country"
    t.string "city"
    t.string "zipcode"
    t.string "street"
    t.string "street_number"
    t.string "floor"
    t.string "internet_status"
    t.string "phone"
    t.string "mobile_phone"
    t.string "building"
    t.string "stairs"
    t.string "door"
    t.string "gate_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "billings", force: :cascade do |t|
    t.string "address"
    t.string "first_name"
    t.string "last_name"
    t.string "bic"
    t.string "iban"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "description"
    t.integer "price"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.date "start_date"
    t.string "state"
    t.bigint "address_id", null: false
    t.bigint "billing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_subscriptions_on_address_id"
    t.index ["billing_id"], name: "index_subscriptions_on_billing_id"
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
    t.boolean "already_moved", default: false
    t.date "moving_date"
    t.string "phone"
    t.string "city"
    t.boolean "housed", default: false
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "subscriptions", "addresses"
  add_foreign_key "subscriptions", "billings"
  add_foreign_key "subscriptions", "products"
end
