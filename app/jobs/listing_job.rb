require './lib/social_crawler'
require 'sidekiq'

class ListingJob # rubocop:disable Style/Documentation
  # The listing job takes in a url and uses that to fetch
  # metadata for a listing and then store that metadata into
  # a database.
  #
  # The whole job running system tries its best to avoid rate limiting
  # buuuuut it will requeue a listing job if it fails.
  #
  # @author Tyler Hampton
  # @since 0.1.0
  #
  #
  include Sidekiq::Worker
  sidekiq_options retry: 1
  sidekiq_retry_in { yield 2000 }

  def perform(listing_url)
    @listing_agent = SocialCrawler::Listing.new(listing_url)

    complete_data = @listing_agent.fetch_listing_metadata.merge(
      social_url: listing_url
    )

    begin
      listing = Listing.new(complete_data)
      listing.save
    rescue Mechanize::ResponseCodeError => error
      logger.debug "error fetching page: #{error}"
    end
  end
end
