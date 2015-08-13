# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150810202723) do

  create_table "cards", force: :cascade do |t|
    t.string   "cc_type",     limit: 255
    t.string   "card_number", limit: 255
    t.integer  "month_end",   limit: 4
    t.integer  "year_end",    limit: 4
    t.string   "owner",       limit: 255
    t.string   "alias",       limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "currency_id", limit: 4
  end

  create_table "counterparties", force: :cascade do |t|
    t.string   "counterparty_name", limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "is_active",                     default: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "cbr_num",        limit: 255
    t.string   "name",           limit: 255
    t.string   "sign",           limit: 255
    t.float    "rate",           limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "currency_count", limit: 4
  end

  create_table "money_units", force: :cascade do |t|
    t.integer  "counterparty_id",      limit: 4
    t.integer  "currency_id",          limit: 4
    t.integer  "tax_id",               limit: 4
    t.string   "type",                 limit: 255
    t.string   "name",                 limit: 255
    t.string   "period",               limit: 255
    t.integer  "current_period_price", limit: 4
    t.integer  "next_period_price",    limit: 4
    t.date     "current_period"
    t.date     "next_period"
    t.boolean  "is_active"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "percent",    limit: 24
    t.text     "desc",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "unit_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
