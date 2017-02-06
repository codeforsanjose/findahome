class Listing < ApplicationRecord
  validates_uniqueness_of :listing_id
end
