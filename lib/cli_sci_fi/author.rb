class CliSciFi::Author 
  attr_accessor :name, :born, :died, :nationality, :spouse, :books, :url 

  @@all = [] 

  def initialize(url)
    @books = []
    @url = "https://en.wikipedia.org/" + url
    @@all << self
  end 

  def add_book(book)
    @books << book 
  end

end