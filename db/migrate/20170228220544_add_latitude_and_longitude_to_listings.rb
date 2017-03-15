# frozen_string_literal: true
class AddLatitudeAndLongitudeToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :latitude, :float
    add_column :listings, :longitude, :float
  end
end
