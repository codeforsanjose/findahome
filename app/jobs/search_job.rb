# frozen_string_literal: true
require './lib/social_crawler'
require 'sidekiq'
require 'json'

class SearchJob
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
  include Sidekiq::Worker
  sidekiq_options retry: 3
  sidekiq_retry_in { yield 1600 }

  def perform
    house_links = []

    proxy = ENV['FINDAHOME_USE_PROXIES'] =~ /true/ ? generate_proxy : nil
    @search_agent = SocialCrawler::Search.new(proxy: proxy)
    @search_agent.fetch_search_results_page

    house_links.concat(@search_agent.collect_house_links)

    until @search_agent.final_page?
      @search_agent.next_page
      house_links.concat(@search_agent.collect_house_links)
    end

    enqueue_listing_jobs(house_links)

    SearchJob.perform_in(12.hours)
  end

  # enqueue_listing_jobs will stagger each job by a minute so we don't
  # flood social serve with too many requests. The first batch of ten requests
  # will go through a proxy and a new proxy will be generated for every
  # increment of twenty.
  #
  # @param [Array] house_links An array of URLs from the social serve website.
  # @return [Boolean]
  #
  #
  def enqueue_listing_jobs(house_links)
    counter = 0

    proxy = ENV['FINDAHOME_USE_PROXIES'] =~ /true/ ? generate_proxy : nil
    house_links.each do |listing_url|
      counter += 1
      proxy = generate_proxy if (counter % 20).zero? && !proxy.nil?

      ListingJob.perform_in(
        counter.minutes, listing_url, proxy
      )
    end

    true
  end

  # So crawling and scraping is hard. Gimme Proxy is an API service that will
  # allow you to generate verified proxies via an API call.
  #
  # This function will make that API call and return the proxy's relevant
  # properties.
  #
  # @param
  # @return [Hash] The IP address and port of the proxy to use.
  #
  #
  def generate_proxy
    proxy_api_response = Mechanize.new.get(
      "http://gimmeproxy.com/api/getProxy?api_key=#{ENV['FINDAHOME_GIMMEPROXY_KEY']}?protocol=http"
    ).content

    proxy = JSON.parse(proxy_api_response)

    { ip: proxy['ip'], port: proxy['port'] }
  end
end
