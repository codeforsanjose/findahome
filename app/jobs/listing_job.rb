require './lib/social_crawler'
require 'sidekiq'

class ListingJob # rubocop:disable Style/Documentation
  # The listing job takes in a url and uses that to fetch
  # metadata for a listing and then store that metadata into
  # the database.
  #
  # A retry value of two is specified to ward off dead proxy
  # related errors.
  #
  # @author Tyler Hampton
  # @since 0.1.0
  #
  #
  include Sidekiq::Worker
  sidekiq_options retry: 2
  sidekiq_retry_in { yield 2000 }

  def perform(listing_url, proxy)
    @listing_agent = SocialCrawler::Listing.new(
      listing_url: listing_url, proxy: proxy
    )

    begin
      complete_data = @listing_agent.fetch_listing_metadata
    rescue Mechanize::ResponseCodeError => error
      logger.debug "error fetching page: #{error}"
    end

    listing = Listing.new(complete_data)
    listing.save
  end
end
