require_relative '../models/rental'
require_relative '../models/book'
require_relative '../models/person'

describe Rental do
  let(:book) { Book.new("Title", "Author") }
  let(:person) { Person.new(name: "John Doe", age: 25) }
  let(:rental) { Rental.new("2023-06-08", book, person) }

  describe '#initialize' do
    it 'creates a new rental with the given date, book, and person' do
      expect(rental.date).to eq("2023-06-08")
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the rental' do
      json = rental.to_json
      expect(json).to be_a(String)

      data = JSON.parse(json)
      expect(data['id']).to be_nil
      expect(data['date']).to eq("2023-06-08")
      expect(data['book']).to eq({ 'title' => 'Title', 'author' => 'Author' })
      expect(data['person']).to eq({ 'name' => 'John Doe', 'id' => person.id, 'age' => 25 })
    end
  end
end
