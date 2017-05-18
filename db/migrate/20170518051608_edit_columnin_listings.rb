class EditColumninListings < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :type, :property_type
  end
end
