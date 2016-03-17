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

ActiveRecord::Schema.define(version: 20160317152446) do

  create_table "items", force: :cascade do |t|
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "purchase_id"
    t.integer  "product_type_id"
    t.decimal  "sale_price",      precision: 8, scale: 2
    t.decimal  "purchase_price",  precision: 8, scale: 2
    t.integer  "sale_id"
  end

  add_index "items", ["product_type_id"], name: "index_items_on_product_type_id"
  add_index "items", ["purchase_id"], name: "index_items_on_purchase_id"
  add_index "items", ["sale_id"], name: "index_items_on_sale_id"

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.decimal  "public_price",   precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "material_icon"
    t.string   "color_for_icon"
  end

  create_table "purchases", force: :cascade do |t|
    t.date     "purchase_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total",         precision: 8, scale: 2
  end

  create_table "sales", force: :cascade do |t|
    t.date     "sale_date"
    t.decimal  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                default: "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], name: "index_users_on_state"

end
