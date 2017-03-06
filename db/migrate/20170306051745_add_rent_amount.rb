class AddRentAmount < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :rent_amount, :integer
  end
end
