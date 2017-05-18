# frozen_string_literal: true
class ChangeNameToApartmentNameForListings < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :name, :apartment_name
  end
end
