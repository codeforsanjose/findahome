# -*- coding: utf-8 -*-
# frozen_string_literal: true
require 'mechanize'

base_url = 'http://www.socialserve.com'
starting_url = "#{base_url}/tenant/CA/Search.html?type=rental&region_id=32090"

agent = Mechanize.new
agent.set_proxy '147.75.209.56', '10200'

search_page = agent.get(starting_url)

search_form = search_page.forms[0]

search_form.radiobuttons_with(name: 's8')[0].check
search_form.radiobuttons_with(name: 'rental_voucher_programs_5')[0].check
search_form.fields_with(name: 'high_rent')[0].options[-1].select
search_form.fields_with(name: 'showmax')[0].options[-1].select

search_results_page = agent.submit(search_form, search_form.buttons.first)

def collect_links(search_results_page)
  house_links = []
  search_results_page.links.each do |link|
    house_links << link.uri.to_s if link.uri.to_s =~ %r{\/ViewUnit\/}
  end

  house_links.uniq!
end

house_links = collect_links search_results_page

next_button = search_results_page.links_with(text: 'next')[0]
next_links = []
if house_links.count < 101
  next_page = next_button.click
  next_links = collect_links next_page
end

first_house = agent.get("#{base_url}#{next_links[0]}")

table_cells = first_house.search('div.h2')
table_cells.each do |cell|
  pp cell
end

def parse_one_to_one(table_cells)
  datums = [ "Property Type", "Bedrooms", "Bathrooms", "Lease Length", "Year Built (approx)", "Square Feet (approx)", "Maxinum # Occupants", "Furnished", "Trash Service", "Lawn Care", "Basement", "Parking Type", "Allotted Parking Spaces", "Parking in Front of Property Entrance", "Lease Extra Spaces", "Lever Style Door Handles", "Door Knock / Bell Signaller", "Standard Peephole", "Entry Door Intercom", "Deadbolt on Entry Door", "Secured Entry to Building", "Automatic Entry Door", "Accessible Elevators", "Unit on First Floor", "Multi Story Unit", "Bus Stop", "Light Rail Station", "Playground", "Shopping Venues", "Utilities included in Rent", "Stove", "Refrigerator / Freezer", "Air Conditioner", "Clothes Washer", "Clothes Dryer", "Laundry Room / Facility", "Smoke Detector", "Carbon Monoxide Detector", "Heating Type", "Water Heater", "Counter Height",  "Non-digital Kitchen Appliances", "Front Controls on Stove/Cook-top", "Vanity Height", "Grab Bars", "Reinforced for Grab Bar", "Roll-in Shower","'T' Turn or 60\" Turning Circle in Bathrooms", "Lowered Toilet", "Raised Toilet", "Gated Facility", "Carded Entry for Gate", "Sidewalks", "Emergency Exits", "Dumpsters", "Pool", "Work-out Room", "Theater", "Clubhouses", "Community Shuttle", "Within Paratransit Route", "Sign Language Friendly", "Playground", "Recreational Facilities", "Parking in Front of Property Entrance" ]

complete_data = {}

  table_cells.each_with_index do |cell, index|
    cell_first_content = cell.children[0].to_s.strip.chop

    if datums.include?(cell_first_content)

      table_cell_match_content = table_cells[index+1].children[1]
      if table_cell_match_content.nil?
         table_cell_match_content = table_cells[index+1].children[0]
      end

      complete_data.merge!({
        cell_first_content.to_sym => table_cell_match_content.children[0].to_s.gsub(/\n/, '').gsub(/\t/,'')
        #gsub to remove newline and new tabs.
      })
    end
  end
  complete_data
end

complete_data = parse_one_to_one(table_cells)
#pp complete_data

def parse_question_marks(table_cells)
  match_data = ["Criminal Check\:", "Pets\:", "Credit Check\:","Accepts Section 8\:", "Tax Credit Property\:", "Subsidized Rent OK\:", "Seniors only\:", "Pets\:", "Smoking\:", "Security Deposit\:", "Application Fee\:", "Date Available\:"]
  complete_data = {}
  table_cells.each_with_index do |cell, index|
    match_data.each do |data|
      if cell.children[2].to_s.match(data)
       table_cell_match_content = table_cells[index+1].children[1]
        complete_data.merge!({ cell.children[2].to_s.strip.gsub(/\]/, '').gsub(/\n/, '').gsub(/\t/, '').to_sym => table_cell_match_content.children[0].to_s.strip.gsub(/\n/, '').gsub(/\t/,'')})
     end
    end
  end
  complete_data
end

complete_data = parse_question_marks(table_cells)
#pp complete_data

def parse_data_next_rows(table_cells)
  match_data = ["Flooring Materials", "Additional Property Options", "Other Appliances Included"]
  complete_data = {}
  table_cells.each_with_index do |cell, index|
    match_data.each do |data|
      cell_content = cell.to_s
      if cell_content.match(data)
        table_cell_match_content = table_cells[index+1]
        complete_data.merge!({ cell.content.to_s.strip.gsub(/\]/, '').gsub(/\n/, '').gsub(/\t/, '').to_sym => table_cell_match_content.children[0].to_s.strip.gsub(/\n/, '').gsub(/\t/,'')})
      end
    end

  end

  complete_data
end

complete_data = parse_data_next_rows(table_cells)
#pp complete_data

#contact info
#Need to fix the regex output - includes HTML tags
def parse_contact_info(table_cells)
  first_match = "Contact Information:"
  match_data = [ "Property Management Company", "Private Owner", "Non-Profit" ]
  complete_data = {}
  match_data.each do |data|
    table_cells.each_with_index do |cell, index|
      if cell.to_s.match(data)
        table_cell_match_content = table_cells[index]
        complete_data.merge!({ first_match.to_sym => table_cell_match_content.to_s.strip.gsub(/\n/, '').gsub(/\t/,'') })

      end
    end
  end

  complete_data
end

complete_data = parse_contact_info(table_cells)
#pp complete_data

def parse_data_same_row(table_cells)
#  match_data = [ "Contact Information", "Promotional Message", "Will Property Pass HUD Lead Paint Guidelines?", "Owner/Manager Comments" ]
   complete_data = {}

  table_cells.each_with_index do |cell, index|
  match_data.each do |data|
    cell_content = cell.to_s
    if cell_content.match(data)
      table_cell_match_content = table_cells[index]
      complete_data.merge!({ cell.content.to_s.strip.gsub(/\]/, '').gsub(/\n/, '').gsub(/\t/, '').to_sym =>     table_cell_match_content.children[0].to_s.strip.gsub(/\n/, '').gsub(/\t/,'')})
    end
  end
end
  complete_data
end

#complete_data = parse_data_same_row(table_cells)
#pp complete_data
def parse_phonefax(table_cells)
  type = ["Phone\:", "Fax\:"]
  complete_data = {}
  type.each do |data|
    table_cells.each_with_index do |cell, index|
      if cell.children.to_s.match(data)
        table_cells_match = table_cells[index+1].children[1]
        if cell.children.to_s.match("Hablamos Español")
         complete_data.merge! ({ data.to_s.strip.gsub(/\n/, '').gsub(/\t/, '').to_sym => table_cells_match.children[0].to_s.gsub(/\n/, '').gsub(/\t/, '') + "Hablamos Español. Landlord can accept Spanish-language phone calls."})
        else
          complete_data.merge! ({ data.to_s.strip.gsub(/\n/, '').gsub(/\t/, '').to_sym => table_cells_match.children[0].to_s.gsub(/\n/, '').gsub(/\t/, '')})
        end
      end
    end
end
  complete_data
end
complete_data = parse_phonefax(table_cells)
#pp complete_data

 #same row info function e.g. will property, qualifiers, promotional message

def parse_web(table_cells)
end

def parse_email(table_cells)
end


#rent amount function

#Map function

#name and address function
