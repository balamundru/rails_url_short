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

ActiveRecord::Schema.define(version: 2019_08_03_131017) do

  create_table "session_trackers", force: :cascade do |t|
    t.text "session_id"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shorturls", force: :cascade do |t|
    t.text "original_url"
    t.string "short_url"
    t.text "sanitize_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visits", default: 0
  end

  create_table "url_analytics", force: :cascade do |t|
    t.text "short_url"
    t.text "original_url"
    t.datetime "visited_time"
    t.integer "shorturl_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
