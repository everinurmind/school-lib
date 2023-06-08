require_relative '../models/book'
require_relative '../models/student'
require_relative '../models/teacher'
require_relative '../models/rental'

class App
  attr_accessor :people, :books

  def initialize
    @people = []
    @books = []
  end

  def list_items(items, select: false, &block)
    puts '========================================================================='
    items.each_with_index do |item, idx|
      puts "#{select ? "#{idx}) " : ''}#{yield(item)}"
    end
    puts '========================================================================='
  end

  def list_all_books(select: false)
    list_items(@books, select: select) { |book| "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_all_people(select: false)
    list_items(@people, select: select) do |person|
      role = person.is_a?(Teacher) ? 'Teacher' : 'Student'
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
    person.add_rental(book, date)
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
