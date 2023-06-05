require_relative './library'
require_relative './personcreator'
require_relative './bookcreator'
require_relative './rentalcreator'

class App
  def initialize
    @library = Library.new
    @person_creator = PersonCreator.new(@library)
    @book_creator = BookCreator.new(@library)
    @rental_creator = RentalCreator.new(@library)
  end

  def list_all_books(select: false)
    @library.list_all_books(select: select)
  end

  def list_all_people(select: false)
    @library.list_all_people(select: select)
  end

  def create_person
    @person_creator.create_person
  end

  def create_book_from_input
    @book_creator.create_book_from_input
  end

  def create_rentals_from_input
    @rental_creator.create_rentals_from_input
  end

  def list_rentals_for_person(person_id)
    @library.list_rentals_for_person(person_id)
  end
end
