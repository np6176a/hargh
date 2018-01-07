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

ActiveRecord::Schema.define(version: 20180106222948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hars", force: :cascade do |t|
    t.datetime "started_date_time", null: false
    t.string "title", null: false
    t.decimal "page_timings_on_content_loaded", null: false
    t.decimal "page_timings_on_load", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_timings_on_content_loaded"], name: "index_hars_on_page_timings_on_content_loaded"
    t.index ["page_timings_on_load"], name: "index_hars_on_page_timings_on_load"
    t.index ["started_date_time"], name: "index_hars_on_started_date_time"
  end

end
