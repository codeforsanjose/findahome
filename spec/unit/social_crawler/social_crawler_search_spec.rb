require_relative '../../../lib/social_crawler'

RSpec.describe SocialCrawler::Search do # rubocop:disable Metric/BlockLength
  before(:all) do
    VCR.use_cassette('search_page') do
      @search_agent = SocialCrawler::Search.new
      @search_agent.fetch_search_results_page
    end
  end

  it 'should initialize with the correct search url value' do
    url = @search_agent.search_url

    expect(url).to match(
      'http://www.socialserve.com/tenant/CA/Search.html?type=rental&region_id=32090'
    )
  end

  it 'should return a Mechanize results page' do
    expect(@search_agent.search_results_page).to be_a(Mechanize::Page)
  end

  it 'should return a list of house links' do
    house_links = @search_agent.collect_house_links
    house_links.each do |uri|
      expect(uri).to match(/ViewUnit/)
    end
  end

  it 'should detect if the current page is the last page' do
    expect(@search_agent.final_page?).to be(false)
  end

  it 'should transition to the next page' do
    VCR.use_cassette('next_search_page') do
      expect(@search_agent.next_page).to be_a(Mechanize::Page)
    end
  end
end
