# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database
# with its default values.
#
# The data can then be loaded with the rails db:seed command (or created alongside
# the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movi

Listing.create(
property_type: 'Apartment',
bedrooms: 2,
bathrooms: 1.0,
lease_length: 'One Year',
square_feet_approx: 1015,
apartment_name: 'Delmas Park Apartments',
address: '350 Bird Avenue, San Jose, CA 95126',
accepts_section_8: true,
security_deposit: '$700',
application_fee: '$30 per adult',
date_available: 'Waiting List',
listing_id: 1,
rent_amount: 1499,
latitude: 37.3242903,
longitude: -121.89968379999999)

Listing.create(
property_type: 'Studio',
bedrooms: 0,
bathrooms: 1.0,
lease_length: 'One Year',
square_feet_approx: 625,
apartment_name: 'Delmas Park Apartments',
address: '350 Bird Avenue, San Jose, CA 95126',
accepts_section_8: true,
security_deposit: '$500',
application_fee: '$30 per adult',
date_available: 'Waiting List',
listing_id: 2,
rent_amount: 979,
latitude: 37.3242903,
longitude: -121.89968379999999)

Listing.create(
property_type: 'Apartment',
bedrooms: 1,
bathrooms: 1.0,
lease_length: 'One Year',
square_feet_approx: 715,
apartment_name: 'Villa Torre Apartments',
address: '955 South Sixth Street, San Jose, CA 95112',
accepts_section_8: true,
security_deposit: '$1,232',
application_fee: '$33 per adult',
date_available: 'Waiting List',
listing_id: 3,
rent_amount: 1232,
latitude: 37.3245349,
longitude: -121.87495030000002)

Listing.create(
property_type: 'Apartment',
bedrooms: 1,
bathrooms: 1.0,
lease_length: 'One Year',
apartment_name: 'Belovida At Newbury Park Apartments',
address: '1777 Newbury Park Drive, San Jose, CA 95133',
accepts_section_8: true,
security_deposit: '$500',
application_fee: '$46 per adult',
date_available: 'Waiting List',
listing_id: 4,
rent_amount: 1002,
latitude: 37.3665838,
longitude: -121.867343)

Listing.create(
property_type: 'Apartment',
bedrooms: 0,
bathrooms: 1.0,
lease_length: 'One Year',
square_feet_approx: 476,
apartment_name: 'Casa De Los Amigos',
address: '967 Lundy Street, San Jose, CA 95133',
accepts_section_8: false,
security_deposit: '$810',
application_fee: 'None',
date_available: 'Waiting List',
listing_id: 5,
rent_amount: 810,
latitude: 37.3721286,
longitude: -121.8735691)
