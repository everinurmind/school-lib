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
    save_data(extract_persons_data, 'people.json')
    save_data(@library.books, 'books.json')
    save_data(@library.rentals, 'rentals.json')
  end

  def load_all_data
    load_people_data
    books_data = load_data('books.json') || []
    @app.books = books_data.map { |book_data| Book.new(book_data['title'], book_data['author']) }
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
    @app.list_all_people
  end

  def list_all_books
    @app.list_all_books
  end

  def list_rentals
    @library.list_rentals
  end

  private

  def extract_persons_data
    @app.people.map do |person|
      if person.is_a?(Student)
        {
          'id' => person.id,
          'name' => person.name,
          'age' => person.age,
          'classroom' => person.classroom
        }
      elsif person.is_a?(Teacher)
        {
          'id' => person.id,
          'name' => person.name,
          'age' => person.age,
          'specialization' => person.specialization
        }
      else
        {}
      end
    end
  end

  def load_people_data
    people_data = load_data('people.json') || []
    @app.people = []
  
    people_data.each do |person_data|
      person = if person_data['classroom'].nil?
                 Student.new(person_data['age'], person_data['name'], parent_permission: true)
               else
                 Teacher.new(person_data['specialization'], name: person_data['name'], age: person_data['age'])
               end
  
      person.id = person_data['id']
      person.classroom = person_data['classroom'] if person.is_a?(Student)
      person.rentals = person_data['rentals']
      @app.people << person
    end
  end
end


