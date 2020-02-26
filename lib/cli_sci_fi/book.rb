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
end