require_relative "../cli_sci_fi"

class CliSciFi::CLI
  def call 
    puts "Hello and Welcome to the Cli Sci Fi program!"
    CliSciFi::Book.scrape_books
    @books = CliSciFi::Book.all
    menu
  end

  def menu
    input = nil 
    while input != "exit"
      puts "Please enter the number of the menu you would like to access:"
      puts "1. List Books"
      puts "2. List Authors"
      puts "3. List Books that won both awards."
      puts "4. List Books by a given author."
      puts "5. Random book."
      puts "6. Random double award winning book."
      input = gets.strip.downcase
      puts ""
      case input
      when "1"
        list_books
        puts "Do you want more info on a book? If so enter the number of the book or no to go back to menu:"
        num = gets.strip.to_i 
        if num > 0 
          more_info(num)
        end
      when "2"
        list_authors
      when "3"
        list_dual_winners
      when "4"
        puts "Please enter an author first or last name"
        name = gets.strip.downcase
        puts "Books by given author:"
        list_books_by_author(name)
      when "5"
        rand_book = @books.sample
        puts "Your random book is: #{rand_book.title} by #{rand_book.author.name}."
      when "6"
        rand_book = CliSciFi::Book.dual_winners.sample
        puts "Your random double award winning book is: #{rand_book.title} by #{rand_book.author.name}."
      end
    end
  end

  def list_books 
    puts "The Books are:"
    @books.each.with_index(1) do |book, i|
      puts "#{i}. #{book.title}"
    end
  end

  def more_info(num)
    @books.each.with_index(1) do |book, i|
      if num == i 
        puts "Title - #{book.title}, Author - #{book.author.name}, Publisher - #{book.publisher}"
        print "This book won the "
        book.awards.each.with_index(1) do |award, i|
          print award
          if book.awards.size == 1
            print " "
          elsif book.awards.size == 2 and i == 1
            print " and "
          else 
            print " "
          end
        end
        puts "award(s)."
      end
    end
  end

  def list_authors 
    puts "The authors are:"
    @books.each.with_index(1) do |book, i|
      puts "#{i}. #{book.author.name}"
    end
  end

  def list_dual_winners
    puts "Books that won both awards are:"
    CliSciFi::Book.dual_winners.each.with_index(1) do |book, i|
      puts "#{i}. #{book.title}"
    end
  end

  def list_books_by_author(name)
    @books.select{|book| book.author.name.downcase.split(" ").include?(name)}.each.with_index(1) do |book, i|
      puts "#{i}. #{book.title}"
    end
  end
end