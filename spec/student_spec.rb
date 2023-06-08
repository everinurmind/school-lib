require_relative '../models/person'
require_relative '../models/student'

RSpec.describe Student do
    let(:age) { 16 }
    let(:name) { 'John Doe' }
    let(:parent_permission) { true }
    let(:classroom) { 'Mathematics' }
    let(:book) { double('Book') }
    let(:date) { double('Date') }
    let(:rental) { double('Rental') }
  
    subject do
      described_class.new(age, name, parent_permission: parent_permission)
    end
  
    describe '#initialize' do
      before do
        subject
      end
  
      it 'sets the age, name, and parent_permission attributes' do
        expect(subject.age).to eq(age)
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
      before do
        subject
      end
  
      it 'returns the student as a JSON string' do
        expected_json = {
          'id' => subject.id,
          'name' => name,
          'age' => age,
          'rentals' => subject.rentals,
          'classroom' => nil
        }.to_json
  
        expect(subject.to_json).to eq(expected_json)
      end
    end
  
    describe '#classroom' do
      it 'returns nil by default' do
        expect(subject.classroom).to be_nil
      end
  
      it 'can be set to a value' do
        subject.classroom = classroom
        expect(subject.classroom).to eq(classroom)
      end
    end
  end
