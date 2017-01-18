require 'mechanize'

# Parent class for crawling the Social Serve website.
#
# @author 'Tyler Hampton'
# @since 0.1.0
#
# @attr_reader [String] base_url The base social serve url.
#
#
class SocialCrawler
  attr_reader :base_url

  def initialize
    @base_url = 'http://www.socialserve.com'
  end
end
