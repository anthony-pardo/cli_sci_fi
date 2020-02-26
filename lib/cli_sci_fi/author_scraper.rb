class CliSciFi::Author_scraper 
  def self.scrape_author(author)
    if author.url != "#"
      doc = Nokogiri::HTML(open(author.url))
      begin
        author.born = doc.css('table.infobox span.bday').text
      rescue 
        author.born = nil 
      else 
        author.born = doc.css('table.infobox span.bday').text
      end
    else 
      puts "Sorry, no information on this author"
      return false
    end
    true
  end
end