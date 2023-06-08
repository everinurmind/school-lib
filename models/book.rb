require_relative './rental'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def to_json(*args)
    {
      'title' => @title,
      'author' => @author
    }.to_json(*args)
  end

  def add_rental(person, date)
    rental = Rental.new(date, self, person)
    @rentals << rental
  end
end
