class AddSocialUrlToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :social_url, :string
  end
end
