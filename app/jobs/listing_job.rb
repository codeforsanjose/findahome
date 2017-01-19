require './lib/social_crawler'

class ListingJob < ApplicationJob # rubocop:disable Style/Documentation
  # The listing job takes in a url and uses that to fetch
  # metadata for a listing and then store that metadata into
  # a database.
  #
  # @author Tyler Hampton
  # @since 0.1.0
  #
  #
  queue_as :default
  Sidekiq.default_worker_options = { retry: 0 }

  def perform(listing_url) # rubocop:disable Metrics/MethodLength
    @listing_agent = SocialCrawler::Listing.new(listing_url)

    complete_data = @listing_agent.fetch_listing_metadata.merge(
      social_url: listing_url
    )

    begin
      listing = Listing.new(complete_data)
      listing.save
    rescue Mechanize::ResponseCodeError => error
      puts "error fetching page: #{error}"
      return
    end
  end
end
