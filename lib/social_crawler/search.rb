class SocialCrawler
  # A class for crawling the Social Serve website.
  #
  # @authors ['Tyler Hampton', 'Yan Yin Choy']
  # @since 0.1.0
  #
  # @attr_reader [Mechanize] search_results_page The current search page.
  #
  # rubocop:disable Metric/LineLength
  #
  # @attr_reader [String] search_url The URL for the Santa Clara County search form.
  #
  # rubocop:enable Metric/LineLength
  #
  class Search < SocialCrawler
    attr_reader :agent
    attr_reader :search_results_page
    attr_reader :search_url

    def initialize(proxy: nil)
      super
      @agent = Mechanize.new
      @agent.set_proxy(proxy[:ip], proxy[:port]) if proxy
      @search_url = "#{@base_url}" \
        '/tenant/CA/Search.html?type=rental&region_id=32090'
    end

    # Fills out the search page's search form and executes a search.
    #
    # @param
    # @return [Mechanize] A search results page returned as a Mechanize object.
    #
    #
    def fetch_search_results_page
      search_page = @agent.get(@search_url)
      search_form = search_page.forms[0]

      maximized_search_form = mark_search_form_with_max_values(search_form)

      search_results_page = @agent.submit(
        maximized_search_form, maximized_search_form.buttons.first
      )

      @search_results_page = search_results_page
    end

    # Will collect all the house listing links on a search page.
    #
    # @param
    # @return [Array<String>] A list of URLs.
    #
    #
    def collect_house_links
      house_links = []

      @search_results_page.links.each do |link|
        house_links << link.uri.to_s if link.uri.to_s =~ %r{\/ViewUnit\/}
      end

      house_links.uniq!.map { |uri| "#{@base_url}#{uri}" }
    end

    # Determines if the current search page is the last page.
    #
    # @param
    # @return [Boolean]
    #
    #
    def final_page?
      collect_house_links.length < 100 ? true : false
    end

    # Flips to the next search page if there is one.
    #
    # @param
    # @return [Mechanize::Page] The next page as a Mechanize object.
    #
    #
    def next_page
      return false if final_page?
      next_button = @search_results_page.links_with(text: 'next')[0]
      @search_results_page = next_button.click
    end

    private

    # Marks all the form values for the search form as maximized values.
    #
    # @param
    # @return [Mechanize::Form] search form with max values
    #
    #
    def mark_search_form_with_max_values(search_form) # rubocop:disable Metrics/AbcSize, Metrics/LineLength
      search_form.radiobuttons_with(name: 's8')[0].check
      search_form.radiobuttons_with(name: 'rental_voucher_programs_5')[0].check
      search_form.fields_with(name: 'high_rent')[0].options[-1].select
      search_form.fields_with(name: 'showmax')[0].options[-1].select

      search_form
    end
  end
end
