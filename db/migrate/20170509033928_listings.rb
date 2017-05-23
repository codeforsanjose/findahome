class Listings < ActiveRecord::Migration[5.0]
  def change
  	create_table :listings do |t|
  		t.integer :listings_id
	    t.string :property_name
	    t.string :property_address
	    t.float :latitude
	    t.float :longitude
	    t.string :property_website
	    t.string :property_manager
	    t.string :property_management_phone
	    t.string :type
	    t.string :population
	    t.integer :extremely_low_income_units
	    t.integer :very_low_income_units
	    t.integer :moderate_income_units
	    t.integer :hud_units
	    t.integer :total_affordable_units

		t.timestamps
	end 
  end
end
 
