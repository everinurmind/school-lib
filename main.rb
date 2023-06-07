require_relative './appcreator'

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

def handle_option(option, operations)
  options = {
    '1' => operations.method(:list_all_books),
    '2' => operations.method(:list_all_people),
    '3' => operations.method(:create_person),
    '4' => operations.method(:create_book),
    '5' => operations.method(:create_rentals),
    '6' => operations.method(:list_rentals)
  }
  options[option]&.call
end

def main
  puts "Welcome to School Library App! \n\n"
  exit = false
  operations = Appcreator.new

  operations.load_all_data

  until exit
    show_options
    option = gets.chomp
    handle_option(option, operations) if option.to_i.between?(1, 6)
    operations.save_all_data if option == '7'
    exit = true if option == '7'
  end

  operations.save_all_data

  puts 'Thank you for using this app!'
end

main
