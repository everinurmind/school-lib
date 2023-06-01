require_relative './app'

def show_options
  puts "\nPlease choose an option by entering a number:"
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def list_rentals(app)
  print 'ID of person: '
  person_id = gets.chomp.to_i
  app.list_rentals_for_person(person_id)
end

def main
  app = App.new
  exit = false
  puts "Welcome to School Library App! \n\n"

  until exit
    show_options
    option = gets.chomp
    options = {
      '1' => app.method(:list_all_books),
      '2' => app.method(:list_all_people),
      '3' => app.method(:create_person),
      '4' => app.method(:create_book_from_input),
      '5' => app.method(:create_rentals_from_input),
      '6' => -> { list_rentals(app) },
      '7' => lambda {
               puts 'Thank you for using this app!'
               exit = true
             }
    }
    options[option].call
  end
end

main
