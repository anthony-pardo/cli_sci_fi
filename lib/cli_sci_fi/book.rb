require "pry"
class CliSciFi::Book
  attr_accessor :won, :title, :author, :publisher, :awards, :year

  @@all = [] 

  def initialize 
    @awards = []
    @won = false
    @year = ""
  end

  def add_award(award)
    @awards << award
  end

  def self.all
    @@all
  end

  def self.dual_winners 
    dual_winners = []
    @@all.each do |book|
      dual_winners << book if book.awards.size == 2 and book.won == true
    end
    dual_winners
  end

  def self.scrape_books 
    self.scrape_books_hugo
    self.scrape_books_nebula
  end

  def self.scrape_books_nebula
    doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Nebula_Award_for_Best_Novel"))
    arr = []
    table = doc.css('table.sortable').first
    rows = table.search('tr')
    column_names = rows.shift.search('th').map(&:text)
    text_all_rows = rows.map do |row|
      row_name = row.css('th').text
      row_values = row.css('td').map(&:text)
      [row_name, *row_values]
    end
    text_all_rows.each do |row_as_text|
      arr << column_names.zip(row_as_text).to_h
    end
    arr.each.with_index do |hash, i|
      begin
        new_author = CliSciFi::Author.new(doc.css('span.vcard a')[i].attribute('href').value)
      rescue
        new_author = CliSciFi::Author.new('nil')
      else 
        new_author = CliSciFi::Author.new(doc.css('span.vcard a')[i].attribute('href').value)
      end
      book = self.new 
      hash.each do |key, value|
        book.title = hash[key] if key == "Novel\n" 
        #book.author = hash[key] if key == "Author\n"
        new_author.name = hash[key] if key == "Author\n"
        book.publisher = hash[key] if key == "Publisher or publication\n"
        book.won = true if key == "Year\n" and hash[key] != ""
        book.year = hash[key] if key == "Year\n" and hash[key] != ""
      end
      if @@all.find{|b| b.title == book.title }
        @@all.find{|b| b.title == book.title }.add_award("Nebula")
      else
        book.add_award("Nebula")
        book.author = new_author
        new_author.add_book(book)
        @@all << book
      end
    end
  end

  def self.scrape_books_hugo
    doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novel"))
    arr = []
    table = doc.css('table.sortable').first
    rows = table.search('tr')
    column_names = rows.shift.search('th').map(&:text)
    text_all_rows = rows.map do |row|
      row_name = row.css('th').text
      row_values = row.css('td').map(&:text)
      [row_name, *row_values]
    end
    text_all_rows.each do |row_as_text|
      arr << column_names.zip(row_as_text).to_h
    end
    arr.each.with_index do |hash, i|
      new_author = CliSciFi::Author.new(doc.css('span.vcard a')[i].attribute('href').value)
      book = self.new 
      hash.each do |key, value|
        book.title = hash[key] if key == "Novel\n" 
        #book.author = hash[key] if key == "Author(s)\n"
        new_author.name = hash[key] if key == "Author(s)\n"
        book.publisher = hash[key] if key == "Publisher or publication\n"
        book.won = true if key == "Year\n" and hash[key] != ""
        book.year = hash[key] if key == "Year\n" and hash[key] != ""
      end
      book.add_award("Hugo")
      book.author = new_author
      new_author.add_book(book)
      @@all << book
    end
  end
end