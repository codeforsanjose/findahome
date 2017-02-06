class AddListingIdToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :listing_id, :integer
  end
end
