require 'open-uri'
require 'nokogiri'


require_relative "./cli_sci_fi/version"
require_relative "./cli_sci_fi/cli"
require_relative "./cli_sci_fi/book"
require_relative "./cli_sci_fi/author"
require_relative "./cli_sci_fi/book_scraper"
require_relative "./cli_sci_fi/author_scraper"

module CliSciFi
  class Error < StandardError; end
  # Your code goes here...
end
