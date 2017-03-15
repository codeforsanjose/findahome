# frozen_string_literal: true
class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :property_type
      t.integer :bedrooms
      t.integer :bathrooms
      t.string :lease_length
      t.integer :year_built_approx
      t.integer :square_feet_approx
      t.string :furnished
      t.boolean :trash_service
      t.string :lawn_care
      t.string :basement
      t.string :parking_type
      t.string :allotted_parking_spaces
      t.boolean :parking_in_front_of_property_entrance
      t.string :lease_extra_spaces
      t.string :unit_entry
      t.boolean :lever_style_door_handles
      t.boolean :door_knock_and_bell_signaller
      t.boolean :standard_peephole
      t.boolean :entry_door_intercom
      t.boolean :deadbolt_on_entry_door
      t.boolean :secured_entry_to_building
      t.boolean :automatic_entry_door
      t.boolean :accessible_elevators
      t.boolean :unit_on_first_foor
      t.boolean :multi_story_unit
      t.string :bus_stop
      t.boolean :playground
      t.string :stove
      t.string :refrigerator_and_freezer
      t.boolean :air_conditioner
      t.string :clothes_washer
      t.string :clothes_dryer
      t.string :laundry_room_and_facility
      t.string :smoke_detector
      t.string :carbon_monoxide_detector
      t.string :heating_type
      t.string :water_heater
      t.string :counter_height
      t.string :non_digital_kitchen_appliances
      t.boolean :front_controls_on_stoveandcook_top
      t.string :vanity_height
      t.boolean :grab_bars
      t.boolean :reinforced_for_grab_bar
      t.boolean :roll_in_shower
      t.boolean :lowered_toilet
      t.boolean :raised_toilet
      t.boolean :gated_facility
      t.boolean :sidewalks
      t.boolean :emergency_exits
      t.boolean :dumpsters
      t.boolean :pool
      t.boolean :work_out_room
      t.boolean :theater
      t.boolean :community_shuttle
      t.boolean :within_paratransit_route
      t.string :sign_language_friendly_boolean
      t.boolean :recreational_facilities
      t.string :name
      t.string :address
      t.boolean :criminal_check
      t.boolean :credit_check
      t.boolean :accepts_section_8
      t.boolean :tax_credit_property
      t.boolean :subsidized_rent_ok
      t.boolean :seniors_only
      t.boolean :pets
      t.boolean :smoking
      t.string :security_deposit
      t.string :application_fee
      t.string :date_available
      t.string :flooring_materials
      t.string :other_appliances_included

      t.timestamps
    end
  end
end
