class CliSciFi::Author 
  attr_accessor :name, :born, :died, :nationality, :spouse, :books, :url 

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

  def self.all 
    @@all 
  end

end