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

ActiveRecord::Schema[7.0].define(version: 2023_03_30_134840) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", limit: 255, default: "", null: false
    t.string "last_name", limit: 255, default: "", null: false
    t.string "phone", limit: 15, default: "", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", limit: 255, default: "", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.integer "total_transaction_sum_cents", default: 0, null: false
    t.string "total_transaction_sum_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.index ["email"], name: "index_merchants_on_email", unique: true
    t.index ["jti"], name: "index_merchants_on_jti"
    t.index ["reset_password_token"], name: "index_merchants_on_reset_password_token", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.string "uuid", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.bigint "merchant_id"
    t.bigint "follow_transaction_id"
    t.integer "status", default: 0, null: false
    t.string "type", default: "", null: false
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.string "transactionable_type", null: false
    t.bigint "transactionable_id", null: false
    t.index ["customer_id"], name: "index_transactions_on_customer_id"
    t.index ["follow_transaction_id"], name: "index_transactions_on_follow_transaction_id"
    t.index ["merchant_id"], name: "index_transactions_on_merchant_id"
    t.index ["transactionable_type", "transactionable_id"], name: "index_transactions_on_transactionable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.integer "status", default: 0, null: false
    t.string "first_name", limit: 255, default: "", null: false
    t.string "last_name", limit: 255, default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "transactions", "customers"
  add_foreign_key "transactions", "transactions", column: "follow_transaction_id"
end
