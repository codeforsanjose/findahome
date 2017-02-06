class AddLightRailStationToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :light_rail_station, :string
  end
end
