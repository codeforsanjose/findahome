# frozen_string_literal: true
class Listing < ApplicationRecord
  validates_uniqueness_of :listing_id

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  include Swagger::Blocks

  swagger_schema :Listing do
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :tag do
      key :type, :string
    end
  end

  swagger_schema :PetInput do
    allOf do
      schema do
        key :'$ref', :Pet
      end
      schema do
        key :required, [:name]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end
end
