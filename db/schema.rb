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

ActiveRecord::Schema.define(version: 20180107005329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.datetime "started_date_time", null: false
    t.decimal "time"
    t.string "http_method", null: false
    t.string "url"
    t.integer "response_status"
    t.decimal "response_content_size"
    t.string "response_content_mime_type"
    t.decimal "timings_blocked"
    t.decimal "timings_dns"
    t.decimal "timings_ssl"
    t.decimal "timings_connect"
    t.decimal "timings_send"
    t.decimal "timings_wait"
    t.decimal "timings_receive"
    t.jsonb "raw", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "har_id", null: false
    t.index ["har_id"], name: "index_entries_on_har_id"
    t.index ["http_method"], name: "index_entries_on_http_method"
    t.index ["response_content_mime_type"], name: "index_entries_on_response_content_mime_type"
    t.index ["response_content_size"], name: "index_entries_on_response_content_size"
    t.index ["response_status"], name: "index_entries_on_response_status"
    t.index ["started_date_time"], name: "index_entries_on_started_date_time"
    t.index ["time"], name: "index_entries_on_time"
    t.index ["timings_blocked"], name: "index_entries_on_timings_blocked"
    t.index ["timings_connect"], name: "index_entries_on_timings_connect"
    t.index ["timings_dns"], name: "index_entries_on_timings_dns"
    t.index ["timings_receive"], name: "index_entries_on_timings_receive"
    t.index ["timings_send"], name: "index_entries_on_timings_send"
    t.index ["timings_ssl"], name: "index_entries_on_timings_ssl"
    t.index ["timings_wait"], name: "index_entries_on_timings_wait"
    t.index ["url"], name: "index_entries_on_url"
  end

  create_table "hars", force: :cascade do |t|
    t.datetime "started_date_time", null: false
    t.string "title", null: false
    t.decimal "page_timings_on_content_loaded", null: false
    t.decimal "page_timings_on_load", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "raw"
    t.index ["page_timings_on_content_loaded"], name: "index_hars_on_page_timings_on_content_loaded"
    t.index ["page_timings_on_load"], name: "index_hars_on_page_timings_on_load"
    t.index ["started_date_time"], name: "index_hars_on_started_date_time"
  end

end
