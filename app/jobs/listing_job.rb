# frozen_string_literal: true
require './lib/social_crawler'
require 'sidekiq'

class ListingJob
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
      logger.debug "fetched data is #{complete_data}"
    rescue Mechanize::ResponseCodeError => error
      logger.debug "error fetching page: #{error}"
    end

    if complete_data.nil?
      msg = 'No data was fetched.'
      logger.debug msg
      raise msg
    end

    Listing.find_or_create_by(listing_id: complete_data[:listing_id]) do |listing|
      listing.update_attributes(complete_data)
    end
  end
end
