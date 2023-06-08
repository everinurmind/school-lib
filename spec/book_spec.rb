require 'json'
require_relative '../models/book'

RSpec.describe Book do
  let(:title) { 'Sample Book' }
  let(:author) { 'John Doe' }
  let(:person) { double('Person', rentals: []) }
  let(:date) { double('Date') }
  let(:rental) { double('Rental') }

  subject { described_class.new(title, author) }

  describe '#initialize' do
    it 'sets the title and author' do
      expect(subject.title).to eq(title)
      expect(subject.author).to eq(author)
    end

    it 'initializes rentals as an empty array' do
      expect(subject.rentals).to be_an_instance_of(Array)
      expect(subject.rentals).to be_empty
    end
  end

  describe '#to_json' do
    it 'returns the book as a JSON string' do
      expected_json = { title: subject.title, author: subject.author }.to_json
      expect(subject.to_json).to eq(expected_json)
    end
  end

  describe '#add_rental' do
    before do
      allow(Rental).to receive(:new).and_return(rental)
    end

    it 'creates a new rental with the given person and date' do
      expect(Rental).to receive(:new).with(date, subject, person)
      subject.add_rental(person, date)
    end
  end

  describe 'rentals array' do
    it 'adds the rental to the rentals array' do
      subject.add_rental(person, date)
      expect(subject.rentals).to include(an_object_having_attributes(
                                           date: date,
                                           book: subject,
                                           person: person
                                         ))
    end
  end
end
