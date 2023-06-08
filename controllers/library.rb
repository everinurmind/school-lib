class Library
  attr_accessor :books, :people, :rentals

  def initialize(app)
    @app = app
    @books = []
    @people = []
    @rentals = []
  end

  def create_student(age, name, permission)
    student = Student.new(age, name, parent_permission: permission)
    @people << student
    student
  end

  def create_teacher(age, name, specialization)
    teacher = Teacher.new(specialization, name: name, age: age)
    @people << teacher
    teacher
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = @app.create_book(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rentals
    puts 'Select a book from the following list by number'
    @app.list_all_books(select: true)
    book_idx = gets.chomp.to_i
    puts "\nSelect a person from the following list by number (not id)"
    @app.list_all_people(select: true)
    person_idx = gets.chomp.to_i
    print "\nDate: "
    date = gets.chomp
    rental = @app.create_rental(book_idx, person_idx, date)
    @rentals << rental
    puts 'Rental created successfully'
    rental
  end

  def list_all_books
    @app.list_all_books
  end

  def list_all_people
    @app.list_all_people
  end

  def list_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts '========================================================================='
    @app.list_rentals_for_person(person_id)
    puts '========================================================================='
  end
end
