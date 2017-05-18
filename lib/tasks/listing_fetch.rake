# frozen_string_literal: true
require_relative '../social_crawler'
require 'pp'

# Usage:
#
# rails listing:fetch[listing_url]
#
#
namespace :listing do
  desc 'Fetch and parse a listing page.'
  task :fetch, [:listing_url] => [:environment] do |_, args|
    agent = SocialCrawler::Listing.new(listing_url: args[:listing_url])
    pp agent.fetch_listing_metadata
  end
end
