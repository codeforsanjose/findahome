# frozen_string_literal: true
class Listing < ApplicationRecord
  validates_uniqueness_of :listing_id

  geocoded_by :property_address
  after_validation :geocode, if: ->(obj) { obj.property_address.present? && obj.property_address_changed? }
end
