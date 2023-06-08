require_relative './app'
require_relative './library'
require_relative './personcreator'
require 'json'

class Appcreator
  DATA_PATH = './data/'.freeze

  def initialize
    @app = App.new
    @library = Library.new(@app)
    @person_creator = PersonCreator.new(@app)
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
    data_types = {
      people: extract_people_data,
      books: @library.books,
      rentals: @library.rentals
    }

    data_types.each do |type, data|
      save_data(data, "#{type}.json")
    end
  end

  def load_all_data
    load_people_data
    load_books_data
    load_rentals_data
  end

  def handle_option(option)
    option_handlers = {
      '1' => :handle_list_all_books,
      '2' => :handle_list_all_people,
      '3' => :handle_create_person,
      '4' => :handle_create_book,
      '5' => :handle_create_rentals,
      '6' => :handle_list_rentals,
      '7' => :save_all_data
    }

    handler = option_handlers[option]
    send(handler) if handler
  end

  private

  def extract_people_data
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
      if person_data.key?('classroom')
        student = Student.new(person_data['age'], person_data['name'], parent_permission: true)
        student.id = person_data['id']
        @app.people << student
      elsif person_data.key?('specialization')
        teacher = Teacher.new(person_data['specialization'], name: person_data['name'], age: person_data['age'])
        teacher.id = person_data['id']
        @app.people << teacher
      else
        puts "Invalid person data: #{person_data}"
      end
    end
  end

  def load_books_data
    book_data = load_data('books.json') || []
    @app.books = book_data.map do |book_hash|
      Book.new(book_hash['title'], book_hash['author'])
    end
    @library.books = @app.books
  end

  def load_rentals_data
    rental_data = load_data('rentals.json') || []
    rental_data.each do |rental_hash|
      book = find_book(rental_hash['book']['title'], rental_hash['book']['author'])
      person = find_person(rental_hash['person']['id'])
      date = rental_hash['date']

      rental = Rental.new(date, book, person)
      @library.rentals << rental
    end
  end

  def find_book(title, author)
    @library.books.find { |book| book.title == title && book.author == author }
  end

  def find_person(id)
    @app.people.find { |person| person.id == id }
  end

  def handle_list_all_books
    @app.list_all_books
  end

  def handle_list_all_people
    @app.list_all_people
  end

  def handle_create_person
    @person_creator.create_person
  end

  def handle_create_book
    @library.create_book
  end

  def handle_create_rentals
    @library.create_rentals
  end

  def handle_list_rentals
    @library.list_rentals
  end
end
