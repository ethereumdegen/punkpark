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

ActiveRecord::Schema.define(version: 20170804135230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "eth_address"
    t.datetime "last_signed_in"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["eth_address"], name: "index_accounts_on_eth_address", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "token"
    t.datetime "authenticated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["account_id"], name: "index_providers_on_account_id", using: :btree
  end

  create_table "punks", force: :cascade do |t|
    t.string   "avatar"
    t.string   "owner_eth_address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
