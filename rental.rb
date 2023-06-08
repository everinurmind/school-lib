class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end

  def to_json(*args)
    {
      'book' => @book,
      'person' => @person,
      'date' => @date
    }.to_json(*args)
  end
end
