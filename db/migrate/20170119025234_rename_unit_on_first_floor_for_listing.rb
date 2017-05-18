# frozen_string_literal: true
class RenameUnitOnFirstFloorForListing < ActiveRecord::Migration[5.0]
  def change
    change_table :listings do |t|
      t.rename :unit_on_first_foor, :unit_on_first_floor
    end
  end
end
