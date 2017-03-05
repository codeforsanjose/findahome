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

ActiveRecord::Schema.define(version: 20170228220544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.string   "property_type"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.string   "lease_length"
    t.integer  "year_built_approx"
    t.integer  "square_feet_approx"
    t.string   "furnished"
    t.boolean  "trash_service"
    t.string   "lawn_care"
    t.string   "basement"
    t.string   "parking_type"
    t.string   "allotted_parking_spaces"
    t.boolean  "parking_in_front_of_property_entrance"
    t.string   "lease_extra_spaces"
    t.string   "unit_entry"
    t.boolean  "lever_style_door_handles"
    t.boolean  "door_knock_and_bell_signaller"
    t.boolean  "standard_peephole"
    t.boolean  "entry_door_intercom"
    t.boolean  "deadbolt_on_entry_door"
    t.boolean  "secured_entry_to_building"
    t.boolean  "automatic_entry_door"
    t.boolean  "accessible_elevators"
    t.boolean  "unit_on_first_floor"
    t.boolean  "multi_story_unit"
    t.string   "bus_stop"
    t.boolean  "playground"
    t.string   "stove"
    t.string   "refrigerator_and_freezer"
    t.boolean  "air_conditioner"
    t.string   "clothes_washer"
    t.string   "clothes_dryer"
    t.string   "laundry_room_and_facility"
    t.string   "smoke_detector"
    t.string   "carbon_monoxide_detector"
    t.string   "heating_type"
    t.string   "water_heater"
    t.string   "counter_height"
    t.string   "non_digital_kitchen_appliances"
    t.boolean  "front_controls_on_stoveandcook_top"
    t.string   "vanity_height"
    t.boolean  "grab_bars"
    t.boolean  "reinforced_for_grab_bar"
    t.boolean  "roll_in_shower"
    t.boolean  "lowered_toilet"
    t.boolean  "raised_toilet"
    t.boolean  "gated_facility"
    t.boolean  "sidewalks"
    t.boolean  "emergency_exits"
    t.boolean  "dumpsters"
    t.boolean  "pool"
    t.boolean  "work_out_room"
    t.boolean  "theater"
    t.boolean  "community_shuttle"
    t.boolean  "within_paratransit_route"
    t.boolean  "sign_language_friendly"
    t.boolean  "recreational_facilities"
    t.string   "apartment_name"
    t.string   "address"
    t.boolean  "criminal_check"
    t.boolean  "credit_check"
    t.boolean  "accepts_section_8"
    t.boolean  "tax_credit_property"
    t.boolean  "subsidized_rent_ok"
    t.boolean  "seniors_only"
    t.boolean  "pets"
    t.boolean  "smoking"
    t.string   "security_deposit"
    t.string   "application_fee"
    t.string   "date_available"
    t.string   "flooring_materials"
    t.string   "other_appliances_included"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "light_rail_station"
    t.string   "shopping_venues"
    t.string   "social_url"
    t.string   "additional_property_options"
    t.integer  "listing_id"
    t.float    "latitude"
    t.float    "longitude"
    t.index ["listing_id"], name: "index_listings_on_listing_id", unique: true, using: :btree
  end

end
