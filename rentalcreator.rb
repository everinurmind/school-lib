class RentalCreator
  def initialize(library)
    @library = library
  end

  def create_rentals_from_input
    puts 'Select a book from the following list by number'
    @library.list_all_books(select: true)
    book_idx = gets.chomp.to_i
    puts "\nSelect a person from the following list by number (not id)"
    @library.list_all_people(select: true)
    person_idx = gets.chomp.to_i
    print "\nDate: "
    date = gets.chomp
    @library.create_rental(book_idx, person_idx, date)
    puts 'Rental created successfully'
  end
end