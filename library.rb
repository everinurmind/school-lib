require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './book'

class Library
  def initialize
    @people = []
    @books = []
  end

  def list_all_books(select: false)
    @books.each_with_index do |book, idx|
      puts "#{select ? "#{idx}) " : ''}Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_all_people(select: false)
    @people.each_with_index do |person, idx|
      role = person.is_a?(Teacher) ? 'Teacher' : 'Student'
      puts "#{select ? "#{idx}) " : ''}[#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_student(age, name, parent_permission)
    @people << Student.new(age, name, parent_permission:)
  end

  def create_teacher(age, name, specialization)
    @people << Teacher.new(specialization, name:, age:)
  end

  def create_book(title, author)
    @books << Book.new(title, author)
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
