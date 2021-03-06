# frozen_string_literal: true
class ListingSerializer < ActiveModel::Serializer
  attributes :id,
             :listing_id,
             :property_name,
             :property_address,
             :property_website,
             :property_manager,
             :property_management_phone,
             :property_type,
             :population,
             :extremely_low_income_units,
             :very_low_income_units,
             :moderate_income_units,
             :hud_units,
             :total_affordable_units,
             :latitude,
             :longitude,
             :created_at,
             :updated_at
end
