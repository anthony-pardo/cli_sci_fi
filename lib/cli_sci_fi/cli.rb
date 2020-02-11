require_relative "../cli_sci_fi"

class CliSciFi::CLI
  def call 
    puts "Hello and Welcome to the Cli Sci Fi program!"
    menu
  end

  def menu
    input = nil 
    while input != "exit"
      puts "Please enter the number of the menu you would like to access:"
      puts "1. List Books"
      puts "2. List Authors"
      puts "3. List Books that won an award in a given year."
      puts "4. List Books by a given author."
      input = gets.strip.downcase
      case input
      when "1"
        list_books
      when "2"
        list_authors
      when "3"
        puts "Books in year..."
      when "4"
        puts "Books by author..."
      end
    end
  end

  def list_books 
    puts "The Books are:"
    CliSciFi::Book.scrape_books
    @books = CliSciFi::Book.all
    @books.each.with_index(1) do |book, i|
      puts "#{i}. #{book.title}"
    end
  end

  def list_authors 
    puts "The authors are:"
    CliSciFi::Book.scrape_books
    @books = CliSciFi::Book.all 
    @books.each.with_index(1) do |book, i|
      puts "#{i}. #{book.author}"
    end
  end
end