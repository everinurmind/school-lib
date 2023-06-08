require_relative '../models/person'
require_relative '../models/teacher'

RSpec.describe Teacher do
  let(:specialization) { 'Mathematics' }
  let(:name) { 'John Doe' }
  let(:age) { 35 }
  let(:parent_permission) { true }
  let(:book) { double('Book') }
  let(:date) { double('Date') }
  let(:rental) { double('Rental') }

  subject { described_class.new(specialization, name: name, age: age, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the specialization, name, and parent_permission attributes' do
      expect(subject.specialization).to eq(specialization)
      expect(subject.name).to eq(name)
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
    it 'returns the teacher as a JSON string' do
      expected_json = {
        'id' => subject.id,
        'name' => name,
        'age' => age,
        'rentals' => subject.rentals,
        'specialization' => specialization
      }.to_json

      expect(subject.to_json).to eq(expected_json)
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(subject.can_use_services?).to be true
    end
  end
end
