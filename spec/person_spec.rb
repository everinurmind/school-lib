require_relative '../helpers/nameable'
require_relative '../models/rental'
require_relative '../models/person'

RSpec.describe Person do
  let(:name) { 'John Doe' }
  let(:age) { 25 }
  let(:parent_permission) { true }
  let(:book) { double('Book') }
  let(:date) { double('Date') }
  let(:rental) { double('Rental') }

  subject { described_class.new(name: name, age: age, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the name, age, and parent_permission attributes' do
      expect(subject.name).to eq(name)
      expect(subject.age).to eq(age)
      expect(subject.instance_variable_get(:@parent_permission)).to eq(parent_permission)
    end

    it 'initializes rentals as an empty array' do
      expect(subject.rentals).to be_an_instance_of(Array)
      expect(subject.rentals).to be_empty
    end

    it 'generates a random ID between 1 and 255' do
      expect(subject.id).to be_between(1, 255)
    end
  end

  describe '#to_json' do
    it 'returns the person as a JSON string' do
      expected_json = {
        'id' => subject.id,
        'name' => name,
        'age' => age,
        'rentals' => subject.rentals
      }.to_json

      expect(subject.to_json).to eq(expected_json)
    end
  end

  describe '#add_rental' do
    before do
      allow(Rental).to receive(:new).and_return(rental)
    end

    it 'creates a new rental with the given book and date' do
      expect(Rental).to receive(:new).with(date, book, subject)
      subject.add_rental(book, date)
    end

    it 'adds the rental to the rentals array' do
      subject.add_rental(book, date)
      expect(subject.rentals).to include(rental)
    end
  end

  describe '#correct_name' do
    it 'returns the name of the person' do
      expect(subject.correct_name).to eq(name)
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      let(:age) { 20 }

      it 'returns true' do
        expect(subject.can_use_services?).to be true
      end
    end

    context 'when the person is underage but has parent permission' do
      let(:age) { 15 }

      it 'returns true' do
        expect(subject.can_use_services?).to be true
      end
    end

    context 'when the person is underage and has no parent permission' do
      let(:age) { 15 }
      let(:parent_permission) { false }

      it 'returns false' do
        expect(subject.can_use_services?).to be false
      end
    end
  end
end
