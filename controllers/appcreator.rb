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
    @library.books = load_data('books.json') || []
    @library.rentals = load_data('rentals.json') || []
  end

  def handle_option(option)
    case option
    when '1'
      @app.list_all_books
    when '2'
      @app.list_all_people
    when '3'
      @person_creator.create_person
    when '4'
      @library.create_book
    when '5'
      @library.create_rentals
    when '6'
      @library.list_rentals
    end

    save_all_data if option == '7'
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
