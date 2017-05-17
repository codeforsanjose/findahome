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

ActiveRecord::Schema.define(version: 20170509033928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.integer  "listings_id"
    t.string   "property_name"
    t.string   "property_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "property_website"
    t.string   "property_manager"
    t.string   "property_management_phone"
    t.string   "type"
    t.string   "population"
    t.integer  "extremely_low_income_units"
    t.integer  "very_low_income_units"
    t.integer  "moderate_income_units"
    t.integer  "hud_units"
    t.integer  "total_affordable_units"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
