# frozen_string_literal: true
require_relative '../../../lib/social_crawler'

RSpec.describe SocialCrawler::Listing do # rubocop:disable Metrics/BlockLength
  before(:all) do
    VCR.use_cassette('listing_page') do
      @listing = SocialCrawler::Listing.new(
        listing_url: 'http://www.socialserve.com/dbh/ViewUnit/852428'
      )
      @listing.fetch_listing_page
    end
  end

  it 'should parse one to one matches within the tables on a listing page' do
    complete_data = @listing.parse_one_to_one

    expect(complete_data).to be_a(Hash)
  end

  it 'should parse all data elements that are in a \'row => subsequent row\' format' do # rubocop:disable Metrics/LineLength
    complete_data = @listing.parse_row_links

    expect(complete_data).to be_a(Hash)
  end

  it 'should parse out the address for the site' do
    address = @listing.parse_address

    expect(address).to be_a(Hash)
  end

  it 'should spit out all the metadata for a listing' do
    VCR.use_cassette('listing_page') do
      metadata = @listing.fetch_listing_metadata
      expect(metadata).to be_a(Hash)
      expect(metadata.key?(:pets)).to be(true)
      expect(metadata.key?(:property_type)).to be(true)
    end
  end
end
