require_relative './book'
require_relative './student'
require_relative './teacher'
require_relative './rental'

class App
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

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp
    if choice == '1'
      create_student_from_input
    elsif choice == '2'
      create_teacher_from_input
    else
      puts 'Invalid choice'
    end
  end

  def create_student_from_input
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase == 'y'
    create_student(age, name, permission)
    puts 'Person created successfully'
  end

  def create_teacher_from_input
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    create_teacher(age, name, specialization)
    puts 'Person created successfully'
  end

  def create_book_from_input
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    create_book(title, author)
    puts 'Book created successfully'
  end

  def create_rentals_from_input
    puts 'Select a book from the following list by number'
    list_all_books(select: true)
    book_idx = gets.chomp.to_i
    puts "\nSelect a person from the following list by number (not id)"
    list_all_people(select: true)
    person_idx = gets.chomp.to_i
    print "\nDate: "
    date = gets.chomp
    create_rental(book_idx, person_idx, date)
    puts 'Rental created successfully'
  end
end
