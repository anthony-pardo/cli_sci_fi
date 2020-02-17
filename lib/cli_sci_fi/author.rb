class CliSciFi::Author 
  attr_accessor :name, :born, :nationality, :books, :url 

  @@all = [] 

  def initialize
    @books = []
    @@all << self
  end 

  def add_book(book)
    @books << book 
  end

  def add_href(href)
    begin
      @url = "https://en.wikipedia.org/" + href
    rescue 
      @url = "#"
    else 
      @url = "https://en.wikipedia.org/" + href
    end
  end

  def scrape_author 
    if self.url != "#"
      doc = Nokogiri::HTML(open(self.url))
      begin
        self.born = doc.css('table.infobox span.bday').text
      rescue 
        self.born = nil 
      else 
        self.born = doc.css('table.infobox span.bday').text
      end
    else 
      puts "Sorry, no information on this author"
      return false
    end
    true
  end

  def self.all 
    @@all 
  end

end