require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

# Creating a Classroom
classroom = Classroom.new('Class A')

# Creating students and assigning them to the classroom
Student.new(1, classroom, name: 'John', age: 16)
Student.new(2, classroom, name: 'Jane', age: 17)

puts "Classroom: #{classroom.label}"
puts "Students in Classroom: #{classroom.students.map(&:name).join(', ')}"
puts '---'

# Creating a Book
book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')

# Creating a Person (Teacher)
teacher = Teacher.new(100, 'English', name: 'Mr. Smith', age: 35)

# Creating a Rental
rental = Rental.new(Time.now, book, teacher)

puts "Book Title: #{book.title}"
puts "Book Author: #{book.author}"
puts "Rented by: #{rental.person.name}"
puts '---'

# Checking rentals for a person
puts "Rentals for #{teacher.name}:"
teacher.rentals.each do |rental_item|
  puts "Book: #{rental_item.book.title}, Date: #{rental_item.date}"
end
