class ChangeListingsIDtoListingId < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :listings_id, :listing_id
  end
end
