# frozen_string_literal: true
class MakeListingIdUniqueForListings < ActiveRecord::Migration[5.0]
  def change
    add_index :listings, :listing_id, unique: true
  end
end
