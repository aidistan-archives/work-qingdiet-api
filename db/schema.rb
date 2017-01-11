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

ActiveRecord::Schema.define(version: 20170110085109) do

  create_table "addresses", force: :cascade do |t|
    t.string   "name"
    t.string   "consignee"
    t.string   "mobile"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "town"
    t.string   "detail"
    t.datetime "last_used_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.string   "client_id"
    t.string   "client_secret"
    t.text     "redirect_uri"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["client_id"], name: "index_apps_on_client_id", unique: true
  end

  create_table "measurements", force: :cascade do |t|
    t.float    "age"
    t.float    "height"
    t.float    "weight"
    t.float    "activity_level"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_measurements_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "kind",         default: 0
    t.integer  "expires_in"
    t.datetime "expired_at"
    t.string   "last_used_ip"
    t.datetime "last_used_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "app_id"
    t.integer  "user_id"
    t.index ["app_id"], name: "index_tokens_on_app_id"
    t.index ["user_id"], name: "index_tokens_on_user_id"
    t.index ["uuid"], name: "index_tokens_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
