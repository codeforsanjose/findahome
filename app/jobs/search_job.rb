require './lib/social_crawler'
require 'sidekiq'

class SearchJob # rubocop:disable Style/Documentation
  # The search job is fairly simple.
  #
  # It will instantiate a search Mechanize agent and then
  # go out and fetch the initial search page. Then it will traverse
  # the returned pages until it has collected all the available listings.
  #
  # The ListingJobs are spaced out on a range of 0..N minutes in order
  # to respect the Social Serve website and not over burden it with
  # traffic.
  #
  # @author Tyler Hampton
  # @since 0.1.0
  #
  #
  include Sidekiq::Worker
  sidekiq_options retry: 1
  sidekiq_retry_in { yield 1600 }

  def perform
    house_links = []

    @search_agent = SocialCrawler::Search.new
    @search_agent.fetch_search_results_page

    house_links.concat(@search_agent.collect_house_links)
    until @search_agent.final_page?
      @search_agent.next_page
      house_links.concat(@search_agent.collect_house_links)
    end

    enqueue_listing_jobs(house_links)

    SearchJob.perform_in(12.hours)
  end

  # This function will take an array of house links
  # and then stagger the HTTP requests made to parse
  # those links into groups off three staggered by,
  # a minimum, of five minutes plus a random minute value.
  #
  # @param [Array] house_links An array of URLs from the social serve website.
  # @return [Boolean]
  #
  #
  def enqueue_listing_jobs(house_links)
    minute_count = 1
    counter = 0
    house_links.each do |listing_url|
      counter += 1
      minute_count += 5 if (counter % 3).zero?
      ListingJob.perform_in(
        (rand(1..5) + minute_count).minutes, listing_url
      )
    end
    true
  end
end
