require_relative "../cli_sci_fi"

class CliSciFi::CLI
  def call 
    puts "Hello and Welcome to the Cli Sci Fi program!"
    CliSciFi::Book_scraper.scrape_books
    @books = CliSciFi::Book.all.select{|book| book.title[0] != "/"}
    @authors = CliSciFi::Author.all
    menu
    closing
  end

  def menu
    input = nil 
    while input != "exit"
      puts "Please enter the number of the menu you would like to access or 'exit':"
      puts "1. List Books"
      puts "2. List Authors"
      puts "3. List Books that won both awards."
      puts "4. Random book."
      puts "5. Random double award winning book."
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
        puts "Do you want more info on an author? If so enter the number of the author or no to go back to menu:"
        num = gets.strip.to_i 
        if num > 0 
          more_info_author(num)
        end
      when "3"
        list_dual_winners
      when "4"
        rand_book = @books.sample
        puts "Your random book is: #{rand_book.title} by #{rand_book.author.name}."
      when "5"
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

  def more_info_author(num)
    @authors.each.with_index(1) do |author, i|
      if num == i 
        if CliSciFi::Author_scraper.scrape_author(author) and author.born != ""
          puts "#{author.name} was born on #{author.born}"
        else 
          puts "Sorry no more information on this author."
        end
      end
    end
  end

  def list_authors 
    puts "The authors are:"
    @authors.each.with_index(1) do |author, i|
      puts "#{i}. #{author.name}"
    end
  end

  def list_dual_winners
    puts "Books that won both awards are:"
    CliSciFi::Book.dual_winners.each.with_index(1) do |book, i|
      puts "#{i}. #{book.title}"
    end
  end

  def closing 
    puts "Thank you for using the Cli Sci Fi program! Bye!"
  end
end