class Listing < ApplicationRecord
  validates_uniqueness_of :listing_id

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }
end
