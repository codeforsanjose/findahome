require_relative '../../../lib/social_crawler'

RSpec.describe SocialCrawler::Listing do # rubocop:disable Metric/BlockLength
  before(:all) do
    VCR.use_cassette('listing_page') do
      @search_agent = SocialCrawler::Search.new
      @search_agent.fetch_search_results_page
      listing_url = @search_agent.collect_house_links.first

      @listing_agent = SocialCrawler::Listing.new(listing_url)
      @listing_agent.fetch_listing_page
    end
  end

  it 'should parse one to one matches within the tables on a listing page' do
    complete_data = @listing_agent.parse_one_to_one

    expect(complete_data).to be_a(Hash)
  end

  it 'should parse row data that has a question mark in one of its cells' do
    complete_data = @listing_agent.parse_question_marks

    expect(complete_data).to be_a(Hash)
  end

  it 'should parse all data elements that are in a \'row => subsequent row\' format' do # rubocop:disable Metric/LineLength
    complete_data = @listing_agent.parse_row_links

    expect(complete_data).to be_a(Hash)
  end

  it 'should parse out the address for the site' do
    address = @listing_agent.parse_address

    expect(address).to be_a(Hash)
  end

  it 'should spit out all the metadata for a listing' do
    VCR.use_cassette('listing_page') do
      metadata = @listing_agent.fetch_listing_metadata

      pp metadata
      expect(metadata).to be_a(Hash)
    end
  end
end
