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
      puts "2. List Awards"
      puts "3. List Authors"
      puts "4. List Books that won an award in a given year."
      puts "5. List Books by a given author."
      input = gets.strip.downcase
      case input
      when "1"
        puts "Books..."
      when "2"
        puts "Awards..."
      when "3"
        puts "Authors..."
      when "4"
        puts "Books in year..."
      when "5"
        puts "Books by author..."
      end
    end
  end

  def list_books 
  end
end