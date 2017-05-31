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

ActiveRecord::Schema.define(version: 20170531143241) do

  create_table "cards", force: :cascade do |t|
    t.string   "cc_type",     limit: 255
    t.string   "card_number", limit: 255
    t.integer  "month_end",   limit: 4
    t.integer  "year_end",    limit: 4
    t.string   "owner",       limit: 255
    t.string   "alias",       limit: 255
    t.boolean  "is_active",               default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "currency_id", limit: 4
  end

  create_table "categories_groups", force: :cascade do |t|
    t.string   "alias",      limit: 255
    t.boolean  "is_active",              default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "categories_groups_unit_categories", id: false, force: :cascade do |t|
    t.integer "unit_category_id",    limit: 4
    t.integer "categories_group_id", limit: 4
  end

  add_index "categories_groups_unit_categories", ["categories_group_id"], name: "index_categories_groups_unit_categories_on_categories_group_id", using: :btree
  add_index "categories_groups_unit_categories", ["unit_category_id"], name: "index_categories_groups_unit_categories_on_unit_category_id", using: :btree

  create_table "category_mappings", force: :cascade do |t|
    t.integer  "unit_category_id", limit: 4
    t.string   "name_pattern",     limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
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

  create_table "money_transactions", force: :cascade do |t|
    t.integer  "money_unit_id",           limit: 4
    t.integer  "ref_last_transaction_id", limit: 4
    t.float    "amount",                  limit: 24
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "money_units", force: :cascade do |t|
    t.date     "transaction_date"
    t.integer  "unit_category_id", limit: 4
    t.integer  "counterparty_id",  limit: 4
    t.integer  "currency_id",      limit: 4
    t.integer  "tax_id",           limit: 4
    t.string   "transaction_type", limit: 255
    t.string   "name",             limit: 255
    t.string   "job_description",  limit: 255
    t.decimal  "starting_amount",              precision: 16, scale: 2
    t.boolean  "is_active",                                             default: true
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "percent",    limit: 24
    t.text     "desc",       limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "is_active",                default: true
  end

  create_table "unit_categories", force: :cascade do |t|
    t.integer  "categories_group_id", limit: 4
    t.string   "name",                limit: 255
    t.integer  "counterparty_id",     limit: 4
    t.integer  "tax_id",              limit: 4
    t.boolean  "is_active",                       default: true
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "v_money_units_outs", id: false, force: :cascade do |t|
    t.string  "transaction_type", limit: 255
    t.decimal "amount",                       precision: 16, scale: 2
    t.date    "transaction_date"
    t.string  "alias",            limit: 255
  end

end
