require "pry"
class CliSciFi::Book
  attr_accessor :title, :author, :publisher, :award

  @@all = [] 

  def self.all
    @@all
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
    arr.each do |hash|
      book = self.new 
      hash.each do |key, value|
        book.title = hash[key] if key == "Novel\n" 
        book.author = hash[key] if key == "Author\n"
        book.publisher = hash[key] if key == "Publisher or publication\n"
        book.award = "Nebula"
      end
      @@all << book
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
    arr.each do |hash|
      book = self.new 
      hash.each do |key, value|
        book.title = hash[key] if key == "Novel\n" 
        book.author = hash[key] if key == "Author(s)\n"
        book.publisher = hash[key] if key == "Publisher or publication\n"
        book.award = "Hugo"
      end
      @@all << book
    end
  end
end