require_relative('./app')
require_relative('./library')
require_relative('./personcreator')

class Appcreator
  def initialize
    @app = App.new
    @library = Library.new(@app)
    @person = PersonCreator.new(@app)
  end

  def list_all_books
    @library.list_all_books
  end

  def list_all_people
    @library.list_all_people
  end

  def create_book
    @library.create_book
  end

  def create_rentals
    @library.create_rentals
  end

  def list_rentals
    @library.list_rentals
  end

  def create_person
    @person.create_person
  end
end
