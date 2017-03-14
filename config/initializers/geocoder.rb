# frozen_string_literal: true
Geocoder.configure(
  lookup:    :google,
  use_https: true,
  api_key:   ENV['GMAPS_GEO_KEY'],
  timeout:   5,
  cache:     Redis.new
)
