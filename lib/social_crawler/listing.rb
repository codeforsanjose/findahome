class SocialCrawler
  # A class for parsing a listing's metadata.
  #
  # A housing listing page may contain several tables with unidentified
  # elements. This class contains all the disparate ways to parse through
  # those tables, collecting and presenting the housing data in a succinct
  # and easily storable way.
  #
  # @authors [Tyler Hampton, Yan Yin Choy]
  # @since 0.1.0
  #
  # rubocop:disable Metrics/LineLength
  #
  # @param [Mechanize] table_cells A Mechanize search against all table cells in a page.
  #
  # rubocop:enable Metrics/LineLength
  #
  #
  class Listing < SocialCrawler # rubocop:disable Metrics/ClassLength, Metrics/LineLength
    attr_reader :attributes
    attr_reader :listing_url
    attr_reader :table_cells
    attr_reader :address_div

    def initialize(listing_url)
      @listing_url = listing_url
      @listing_agent = Mechanize.new
    end

    # This is a top-level orchestrator method that will return
    # the results of all the other methods so that we have a big chunk
    # of data on a listing.
    #
    # @param
    # @return [Hash] A big ol' honkin hash.
    #
    #
    def fetch_listing_metadata
      fetch_listing_page

      data_hashes = [
        parse_one_to_one,
        parse_address,
        parse_question_marks,
        parse_row_links
      ]

      data_hashes.inject(&:merge)
    end

    # Fetches everything from a listing page.
    #
    # The general idea is that there is a single HTTP request and it
    # occurs *here*.
    #
    # @param
    # @return [Mechanize::Page]
    #
    #
    def fetch_listing_page
      page = @listing_agent.get(@listing_url)
      collect_table_cells(page)
      collect_address_div(page)
      page
    end

    # Collects all the table cells from a listing page.
    #
    # @param
    # @return [Mechanize]
    #
    #
    def collect_table_cells(page)
      @table_cells = page.search('td')
    end

    # Collects the address div from a listing page. There
    # is only a single element of this type on the page
    # so it's easy enough to grab the first result from the
    # search.
    #
    # @param
    # @return [Mechanize]
    #
    #
    def collect_address_div(page)
      @address_div = page.search('div.h2')[0]
    end

    # A large amount of data can be returned by cycling
    # through all table elements and matching against a known
    # key.
    #
    # Once that key is detected, the *next value* in the table row
    # is grabbed as the value to that key.
    #
    # The key is then purged of tab and newline characters - which
    # were used by the developers of the Social Serve website to
    # create spacing within the table.
    #
    # The final result is merged into the complete_data hash.
    #
    # Ex key/value: { bedrooms: '2' }
    #
    # @param
    # @return [Hash] A collection of housing metadata.
    #
    #
    def parse_one_to_one # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      complete_data = {}

      @table_cells.each_with_index do |cell, index|
        cell_first_content = cell.children[0].to_s.strip.chop
        cell_next_content = @table_cells[index + 1]

        match_datums = one_to_one_match_datums
        next_cell_match_content = determine_child_placements(
          cell_first_content,
          cell_next_content,
          match_datums
        )

        next if next_cell_match_content.nil?

        cleansed_cell_content = cleanse(
          next_cell_match_content.children[0].to_s
        )

        metadata_key = keyify(cell_first_content)
        complete_data.merge!(
          metadata_key => cleansed_cell_content
        )
      end

      complete_data
    end

    # Some table cells have [?] entries in them.
    #
    # The two brackets and an href linked question mark
    # disrupt the previous parse methods logic so this
    # function handles those discrepancies.
    #
    # @param
    # @return [Hash] A collection of housing metadata.
    #
    #
    def parse_question_marks # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/LineLength
      match_datums = question_match_datums

      complete_data = {}
      @table_cells.each_with_index do |cell, index|
        match_datums.each do |datum|
          cell_content = cell.children[2].to_s
          cleansed_cell_content = cleanse(cell_content.to_s)
          cleansed_cell_content[0] = ''

          next unless cell_content.match(datum)

          next_cell_match_content = cleanse(
            @table_cells[index + 1].children[1].children[0].to_s
          )

          metadata_key = keyify(cleansed_cell_content)
          complete_data.merge!(
            metadata_key => next_cell_match_content
          )
        end
      end

      complete_data
    end

    # Some cells contain key data with the value of that key
    # on the next row. This function will match data in a row
    # and then grab the next row and use it as the value for the
    # match.
    #
    # @param
    # @return [Hash] A collection of housing metadata.
    #
    #
    def parse_row_links # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/LineLength
      match_datums = [
        'Flooring Materials',
        'Additional Property Options',
        'Other Appliances Included'
      ]

      complete_data = {}
      @table_cells.each_with_index do |cell, index|
        match_datums.each do |datum|
          next unless cell.to_s.match(datum)

          next_row_match_content = table_cells[index + 1]

          cleansed_cell_key = cleanse(cell.content.to_s)

          cleansed_next_row_match_content = cleanse(
            next_row_match_content.children[0].to_s
          )

          metadata_key = keyify(cleansed_cell_key)
          complete_data.merge!(
            metadata_key => cleansed_next_row_match_content
          )
        end
      end

      complete_data
    end

    # Every metadata row that contains an accessibility obtion
    # may have a small wheel chair image with some hover text
    # next to the cell containing a match datum. This interferes with
    # parsing so this function will determine whether or not to skip
    # the first cell after a matched datum.
    #
    # rubocop:disable Metric/LineLength
    #
    # @param [Nokogiri::XML::Element] table_cell_match_content The matched content within a cell.
    # @return [Boolean] Indication of accessibility icon presence.
    #
    # rubocop:enable Metric/LineLength
    #
    #
    def element_concerns_accessibility?(table_cell_match_content)
      return false if table_cell_match_content.nil?

      second_child = table_cell_match_content.children[1]

      return false if second_child.nil?

      src_attribute = second_child.attributes['src']
      image_value = src_attribute.value unless src_attribute.nil?

      return true if image_value =~ /access/
    end

    # Nokogiri objects return DOM sub-elements as a list of children.
    #
    # EX: <td><b></b></td> with the <b> element being a child of the <td>
    # element.
    #
    # The cells following a match datum can have different formats and this
    # function helps find the placement of the content we find valuable.
    #
    # The initial selection of an element occurs if it matches against a known
    # word or phrase. Then the subsequent selection of the child of the element
    # that is *next to* the matched element is determined by the login inside
    # this function.
    #
    # So the element <td><p>bedrooms<td><p> is matched because the
    # 'bedrooms' string exists inside that Nokogiri object. Then the element
    # next to that table cell (<td><p>2<td><p>) is parsed out.
    #
    # rubocop:disable Metric/LineLength
    #
    # @param [Nokogiri::XML::Element] cell_first_content The first cell match
    # @param [Nokogiri::XML::Element] cell_next_content The cell next to the first cell
    # @param [Array<String>] match_datums A list of phrases/words to match against
    # @return [Nokogiri::XML::Element] A child element that has valuable data
    #
    # rubocop:disbale Metric/LineLength
    #
    def determine_child_placements(cell_first_content, cell_next_content, match_datums)
      if match_datums.include?(cell_first_content)
        table_cell_match_content = cell_next_content.children[1]

        if table_cell_match_content.nil?
          table_cell_match_content = cell_next_content.children[0]
        end

        if element_concerns_accessibility?(cell_next_content)
          table_cell_match_content = cell_next_content.children[3]
        end
      end

      table_cell_match_content
    end

    # There is only a single div element on every listing page
    # that has the h2 CSS class applied to it and, you guessed it,
    # that's the address portion of the page.
    #
    # @param
    # @return [String] The address of the listing.
    #
    #
    def parse_address
      {
        name: cleanse(@address_div.children[0].to_s),
        address: cleanse(@address_div.children[2].to_s)
      }
    end

    def parse_data_same_row; end

    def parse_phone_fax; end

    def parse_web; end

    def parse_email; end

    private

    # A generic function to return the mangled metadata strings as
    # proper looking keys.
    #
    # @param [String] string String to format
    # @return [Symbol] A nice looking symbol!
    #
    #
    def keyify(string)
      string
        .downcase
        .tr(' ', '_')
        .gsub('/', 'and')
        .gsub('(approx)', 'approx')
        .tr('-', '_')
        .strip
        .to_sym
    end

    # A function that 'cleanses' extra characters from strings.
    #
    # There are particular cases where the strip method does not
    # delete \t and \n characters. Leave it.
    #
    # @param [String] string The string for it to cleanse
    # @return [String] A cleansed string!
    #
    #
    def cleanse(string)
      string
        .delete("\]")
        .delete(':')
        .delete("\n")
        .delete("\t")
        .delete('\"')
        .strip
    end

    # One to one values that are matched via Regex.
    #
    # @return [Array] Datums to use for matching.
    #
    #
    def one_to_one_match_datums # rubocop:disable Metrics/MethodLength
      datums = [
        'Property Type',
        'Bedrooms',
        'Bathrooms',
        'Lease Length',
        'Year Built (approx)',
        'Square Feet (approx)',
        'Maxinum # Occupants',
        'Furnished',
        'Trash Service',
        'Lawn Care',
        'Basement',
        'Parking Type',
        'Allotted Parking Spaces',
        'Parking in Front of Property Entrance',
        'Lease Extra Spaces',
        'Lever Style Door Handles',
        'Door Knock / Bell Signaller',
        'Standard Peephole',
        'Entry Door Intercom',
        'Deadbolt on Entry Door',
        'Secured Entry to Building',
        'Automatic Entry Door',
        'Accessible Elevators',
        'Unit Entry',
        'Unit on First Floor',
        'Multi Story Unit',
        'Bus Stop',
        'Light Rail Station',
        'Playground',
        'Shopping Venues',
        'Utilities included in Rent',
        'Stove',
        'Refrigerator / Freezer',
        'Air Conditioner',
        'Clothes Washer',
        'Clothes Dryer',
        'Laundry Room / Facility',
        'Smoke Detector',
        'Carbon Monoxide Detector',
        'Heating Type',
        'Water Heater',
        'Counter Height',
        'Non-digital Kitchen Appliances',
        'Front Controls on Stove/Cook-top',
        'Vanity Height',
        'Grab Bars',
        'Reinforced for Grab Bar',
        'Roll-in Shower',
        '\'T\' Turn or 60\' Turning Circle in Bathrooms',
        'Lowered Toilet',
        'Raised Toilet',
        'Gated Facility',
        'Carded Entry for Gate',
        'Sidewalks',
        'Emergency Exits',
        'Dumpsters',
        'Pool',
        'Work-out Room',
        'Theater',
        'Clubhouses',
        'Community Shuttle',
        'Within Paratransit Route',
        'Sign Language Friendly',
        'Playground',
        'Recreational Facilities',
        'Parking in Front of Property Entrance'
      ]

      datums
    end

    def question_match_datums # rubocop:disable Metrics/MethodLength
      datums = [
        'Criminal Check\:',
        'Pets\:',
        'Credit Check\:',
        'Accepts Section 8\:',
        'Tax Credit Property\:',
        'Subsidized Rent OK\:',
        'Seniors only\:',
        'Pets\:',
        'Smoking\:',
        'Security Deposit\:',
        'Application Fee\:',
        'Date Available\:'
      ]

      datums
    end
  end
end
