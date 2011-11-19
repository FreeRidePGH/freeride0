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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111119002553) do

  create_table "bike_assesments", :force => true do |t|
    t.integer  "bike_id"
    t.integer  "user_id"
    t.string   "quality"
    t.string   "condition"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bike_brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bike_models", :force => true do |t|
    t.integer  "brand_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bikes", :force => true do |t|
    t.integer  "model_id"
    t.integer  "brand_id"
    t.integer  "location_id"
    t.decimal  "wheel_size"
    t.decimal  "top_tube"
    t.decimal  "seat_tube"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_in"
    t.datetime "date_out"
    t.string   "status"
    t.integer  "bike_id"
  end

  create_table "eab_projects", :force => true do |t|
    t.integer  "bike_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bike_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_histories", :force => true do |t|
    t.integer  "bike_id"
    t.string   "location_name"
    t.datetime "last_date_at_location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "hook_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bike_id"
    t.string   "title"
    t.string   "details"
    t.datetime "last_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repair_hours_entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bike_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "eab_project_id"
  end

  create_table "safety_inspections", :force => true do |t|
    t.integer  "bike_id"
    t.integer  "inspector_id"
    t.datetime "inspection_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "safety_item_responses", :force => true do |t|
    t.integer  "safety_inspection_id"
    t.integer  "safety_item_id"
    t.boolean  "is_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "safety_items", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "instructions"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.decimal  "account_value"
    t.boolean  "has_read_packet"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.boolean  "can_text_phone"
    t.string   "address"
  end

  create_table "volunteer_hours_entries", :force => true do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
