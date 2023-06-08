require_relative '../models/book'
require_relative '../models/student'
require_relative '../models/teacher'
require_relative '../models/rental'
require_relative './library'

class App
  attr_accessor :people, :books

  def initialize
    @people = []
    @books = []
    @library = Library.new(self)
  end

  def list_items(items, select: false)
    puts '========================================================================='
    items.each_with_index do |item, idx|
      puts "#{select ? "#{idx}) " : ''}#{yield(item)}"
    end
    puts '========================================================================='
  end

  def list_all_books(select: false)
    list_items(@books, select:) { |book| "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_all_people(select: false)
    list_items(@people, select:) do |person|
      role = if person.class.name == 'Teacher'
               'Teacher'
             elsif person.class.name == 'Student'
               'Student'
             else
               'Unknown'
             end
      "[#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_student(age, name, parent_permission)
    @people << Student.new(age, name, parent_permission: parent_permission)
  end

  def create_teacher(age, name, specialization)
    @people << Teacher.new(specialization, name: name, age: age)
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    book
  end

  def create_rental(book_id, person_id, date)
    book = @books[book_id]
    person = @people[person_id]
    rental = Rental.new(date, book, person)
    @library.rentals << rental
    rental
  end

  def list_rentals_for_person(person_id)
    person = @people.find { |p| p.id == person_id }
    return unless person

    puts 'Rentals'
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end
