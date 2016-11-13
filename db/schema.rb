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

ActiveRecord::Schema.define(version: 20161109030736) do

  create_table "accounts", force: :cascade do |t|
    t.string   "account_number", null: false
    t.string   "institution",    null: false
    t.string   "name",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "assets", force: :cascade do |t|
    t.decimal  "expense_ratio", null: false
    t.string   "asset_class",   null: false
    t.string   "exchange",      null: false
    t.string   "market_cap",    null: false
    t.string   "name",          null: false
    t.string   "style",         null: false
    t.string   "symbol",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
  end

end
