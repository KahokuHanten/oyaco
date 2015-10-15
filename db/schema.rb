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

ActiveRecord::Schema.define(version: 20151015041241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.date     "event_date"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string   "name",       null: false
    t.date     "date",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "holidays", ["date"], name: "index_holidays_on_date", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "relation"
    t.date     "birthday"
    t.integer  "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "birthday_year"
    t.integer  "birthday_month"
    t.integer  "birthday_day"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "people", "users"
end
