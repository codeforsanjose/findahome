require './lib/social_crawler'

class SearchJob < ApplicationJob # rubocop:disable Style/Documentation
  # The search job is fairly simple.
  #
  # It will instantiate a search Mechanize agent and then
  # go out and fetch the initial search page. Then it will traverse
  # the returned pages until it has collected all the available listings.
  #
  # @author Tyler Hampton
  # @since 0.1.0
  #
  #
  queue_as :default
  Sidekiq.default_worker_options = { retry: 0 }

  def perform # rubocop:disable Metric/MethodLength
    house_links = []

    @search_agent = SocialCrawler::Search.new
    @search_agent.fetch_search_results_page

    house_links << @search_agent.collect_house_links
    until @search_agent.final_page?
      @search_agent.next_page
      house_links << @search_agent.collect_house_links
    end

    ListingJob.perform_later(house_links.flatten[0])

=begin
    house_links.flatten.each do |listing_url|
      ListingJob.perform_later(listing_url)
    end
=end
  end
end
