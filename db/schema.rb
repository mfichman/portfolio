# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170322154018) do

  create_table "accounts", force: :cascade do |t|
    t.string   "account_number", null: false
    t.string   "institution",    null: false
    t.string   "name",           null: false
    t.string   "tax_status",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "assets", force: :cascade do |t|
    t.decimal  "expense_ratio", null: false
    t.string   "category",      null: false
    t.string   "exchange",      null: false
    t.string   "name",          null: false
    t.string   "symbol",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name"], name: "index_assets_on_name", unique: true
  end

  create_table "lots", force: :cascade do |t|
    t.integer  "cost_basis_cents",    default: 0,     null: false
    t.string   "cost_basis_currency", default: "USD", null: false
    t.integer  "shares",                              null: false
    t.integer  "asset_id",                            null: false
    t.integer  "account_id",                          null: false
    t.date     "opened_on",                           null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.date     "quoted_on"
    t.integer  "high_cents",     default: 0,     null: false
    t.string   "high_currency",  default: "USD", null: false
    t.integer  "low_cents",      default: 0,     null: false
    t.string   "low_currency",   default: "USD", null: false
    t.integer  "close_cents",    default: 0,     null: false
    t.string   "close_currency", default: "USD", null: false
    t.integer  "open_cents",     default: 0,     null: false
    t.string   "open_currency",  default: "USD", null: false
    t.integer  "volume"
    t.integer  "asset_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.date     "completed_on",                    null: false
    t.integer  "account_id",                      null: false
    t.integer  "asset_id",                        null: false
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.integer  "price_cents",     default: 0,     null: false
    t.string   "price_currency",  default: "USD", null: false
    t.decimal  "shares",                          null: false
    t.string   "type",                            null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["asset_id"], name: "index_transactions_on_asset_id"
  end

end
