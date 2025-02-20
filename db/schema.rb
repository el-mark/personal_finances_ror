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

ActiveRecord::Schema[8.0].define(version: 2025_01_18_150454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "budget"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "emails", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recipient"
    t.string "sender"
    t.string "subject"
    t.json "json_raw_message"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "email_id"
    t.date "transaction_date", default: "2024-11-25"
    t.string "transaction_code"
    t.string "issuer"
    t.string "source"
    t.string "destination"
    t.integer "currency", default: 0, null: false
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "category"
    t.integer "frequency"
    t.text "description"
    t.index ["email_id"], name: "index_transactions_on_email_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "user_emails", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_emails_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "transactions", "emails"
  add_foreign_key "transactions", "users"
  add_foreign_key "user_emails", "users"
end
