class BookCreator
  def initialize(library)
    @library = library
  end

  def create_book_from_input
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @library.create_book(title, author)
    puts 'Book created successfully'
  end
end