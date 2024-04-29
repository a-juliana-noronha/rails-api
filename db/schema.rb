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

ActiveRecord::Schema.define(version: 2024_04_15_222505) do

  create_table "accounts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "account_type"
    t.string "color"
    t.string "icon"
    t.decimal "initial_amount", precision: 10, default: "0"
    t.boolean "is_default", default: false
    t.string "status", default: "active"
    t.bigint "cost_center_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cost_center_id"], name: "index_accounts_on_cost_center_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "cards", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "issuer"
    t.string "icon"
    t.string "color"
    t.decimal "limit", precision: 10
    t.integer "closing_day"
    t.integer "due_day"
    t.boolean "is_default", default: false
    t.string "status", default: "active"
    t.bigint "account_id"
    t.bigint "cost_center_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_cards_on_account_id"
    t.index ["cost_center_id"], name: "index_cards_on_cost_center_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.string "color"
    t.string "status", default: "active"
    t.decimal "monthly_limit", precision: 10
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "cost_centers", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.string "color"
    t.string "status", default: "active"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cost_centers_on_user_id"
  end

  create_table "goals", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.string "icon"
    t.decimal "amount", precision: 10
    t.date "due_date"
    t.string "status", default: "active"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "payment_plans", charset: "utf8mb3", force: :cascade do |t|
    t.decimal "total_amount", precision: 10
    t.decimal "total_installments", precision: 10
    t.integer "days"
    t.boolean "reminder"
    t.string "status", default: "active"
    t.bigint "card_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_payment_plans_on_card_id"
    t.index ["user_id"], name: "index_payment_plans_on_user_id"
  end

  create_table "reminders", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "transaction_type"
    t.decimal "amount", precision: 10
    t.integer "due_day"
    t.string "status", default: "active"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "account_id"
    t.bigint "card_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_reminders_on_account_id"
    t.index ["card_id"], name: "index_reminders_on_card_id"
    t.index ["category_id"], name: "index_reminders_on_category_id"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "transactions", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "transaction_type"
    t.decimal "amount", precision: 10, scale: 2
    t.date "date"
    t.integer "current_installment"
    t.boolean "paid"
    t.string "status", default: "active"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "goal_id"
    t.bigint "account_id"
    t.bigint "card_id"
    t.bigint "payment_plan_id"
    t.bigint "reminder_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["card_id"], name: "index_transactions_on_card_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["goal_id"], name: "index_transactions_on_goal_id"
    t.index ["payment_plan_id"], name: "index_transactions_on_payment_plan_id"
    t.index ["reminder_id"], name: "index_transactions_on_reminder_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "role"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "cost_centers"
  add_foreign_key "accounts", "users"
  add_foreign_key "cards", "accounts"
  add_foreign_key "cards", "cost_centers"
  add_foreign_key "cards", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "cost_centers", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "payment_plans", "cards"
  add_foreign_key "payment_plans", "users"
  add_foreign_key "reminders", "accounts"
  add_foreign_key "reminders", "cards"
  add_foreign_key "reminders", "categories"
  add_foreign_key "reminders", "users"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "cards"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "goals"
  add_foreign_key "transactions", "payment_plans"
  add_foreign_key "transactions", "reminders"
  add_foreign_key "transactions", "users"
end
