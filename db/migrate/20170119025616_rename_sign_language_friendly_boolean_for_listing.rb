# frozen_string_literal: true
class RenameSignLanguageFriendlyBooleanForListing < ActiveRecord::Migration[5.0]
  def change
    change_table :listings do |t|
      t.rename :sign_language_friendly_boolean, :sign_language_friendly
    end

    change_column(:listings, :sign_language_friendly, 'boolean USING CAST(sign_language_friendly AS boolean)')
  end
end
