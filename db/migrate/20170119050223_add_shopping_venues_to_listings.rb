# frozen_string_literal: true
class AddShoppingVenuesToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :shopping_venues, :string
  end
end
