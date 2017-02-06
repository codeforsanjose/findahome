class AddAdditionalPropertyOptionsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :additional_property_options, :string
  end
end
