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

ActiveRecord::Schema.define(version: 2024_04_15_222503) do

  create_table "accounts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "account_type"
    t.string "color"
    t.string "icon"
    t.decimal "initial_amount", precision: 10, default: "0"
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "categories", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.string "color"
    t.string "status"
    t.decimal "monthly_limit", precision: 10
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "credit_cards", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "issuer"
    t.string "icon"
    t.string "color"
    t.decimal "limit", precision: 10
    t.string "closing_date"
    t.date "due_date"
    t.string "status"
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_credit_cards_on_account_id"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "goals", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.string "icon"
    t.decimal "amount", precision: 10
    t.date "due_date"
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "transactions", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "transaction_type"
    t.decimal "amount", precision: 10
    t.date "date"
    t.date "accrual_date"
    t.boolean "reminder"
    t.string "status"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "goal_id"
    t.bigint "account_id"
    t.bigint "credit_card_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["credit_card_id"], name: "index_transactions_on_credit_card_id"
    t.index ["goal_id"], name: "index_transactions_on_goal_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "role"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "credit_cards", "accounts"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "credit_cards"
  add_foreign_key "transactions", "goals"
  add_foreign_key "transactions", "users"
end
