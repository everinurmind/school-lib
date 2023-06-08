require_relative './app'
require_relative './library'
require_relative './personcreator'
require 'json'

class Appcreator
  DATA_PATH = './data/'.freeze

  def initialize
    @app = App.new
    @library = Library.new(@app)
    @person = PersonCreator.new(@app)
  end

  def save_data(data, filename)
    File.write(File.join(DATA_PATH, filename), JSON.generate(data))
  end

  def load_data(filename)
    file_path = File.join(DATA_PATH, filename)
    return unless File.exist?(file_path)

    JSON.parse(File.read(file_path))
  end

  def save_all_data
    save_data(@library.books, 'books.json')
    save_data(@library.people, 'people.json')
    save_data(@library.rentals, 'rentals.json')
  end

  def load_all_data
    @library.books = load_data('books.json') || []
    @library.people = load_data('people.json') || []
    @library.rentals = load_data('rentals.json') || []
  end
  
  def create_person
    person = @person.create_person
    save_all_data
    person
  end

  def create_book
    book = @library.create_book
    save_all_data
    book
  end

  def create_rentals
    rentals = @library.create_rentals
    save_all_data
    rentals
  end

  def list_all_people
    @library.list_all_people
  end

  def list_all_books
    @library.list_all_books
  end

  def list_rentals
    @library.list_rentals
  end
end
