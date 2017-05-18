# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movi
Listing.destroy_all

Listing.create([
  {
    property_name: "Casa Feliz Studios",
    property_address:	"525 S.9th Street, San Jose, CA 95112",
    property_website:	"http://jsco.net/property/casa-feliz-studios/",
    property_manager:	"John Stewart Company",
    property_management_phone: "(408) 516-4776",
    property_type:	"Special Needs Housing"
  },
  {
    property_name: 	"Creekview Inn",
    property_address:	"965 Lundy Avenue, San Jose, CA 95133",
    property_website:	"http://www.firsthousing.com/contact/rental/",
    property_manager:	"EAH, Inc.",
    property_management_phone: "(408) 254-4540",
    property_type:	"Special Needs Housing"
  },
  {
    property_name: 	"Avenida Espana Gardens",
    property_address:	"181 Rawls Ct., San Jose, CA 95139",
    property_website:	"http://jsco.net/property/avenida-espaa-gardens/",
    property_manager:	"John Stewart Company",
    property_management_phone: "(408) 972-5529",
    property_type:	"Senior Housing Units"
  },
  {
    property_name: 	"Belovida Apartments",
    property_address:	"1777 Newbury Park Dr., San Jose, CA 95133",
    property_website:	"http://www.belovidanewburypark.com/",
    property_manager:	"EAH Housing Inc.",
    property_management_phone: "(877) 264-2669",
    property_type:	"Senior Housing Units"
  },
  {
    property_name: 	"Miraido Village Mixed-use Project",
    property_address:	"566 N. 6th Street, San Jose, CA 95112",
    property_website:	"http://www.miraidovillageapartments.com/san-jose-ca-apartments.asp",
    property_manager:	"Evans Property Management, Inc.",
    property_management_phone: "(408) 297-0990",
    property_type:	"Family Housing Units"
  },
  {
    property_name: 	"Monte Alban",
    property_address:	"1324 Santee Dr., San Jose, CA 95122",
    property_website: "http://jsco.net/property/monte-alban-apartments/",
    property_manager:	"John Stewart Company",
    property_management_phone: "(408) 286-1903",
    property_type:	"Family Housing Units"
  }
])
