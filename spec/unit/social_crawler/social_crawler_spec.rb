require_relative '../../../lib/social_crawler'

RSpec.describe SocialCrawler do
  before(:all) do
    @crawler = SocialCrawler.new
  end

  it 'should initialize with the base url set to social serves site' do
    expect(@crawler.base_url).to match('http://www.socialserve.com')
  end
end
