require_relative '../helpers/classroom'
require_relative '../models/student'

describe Classroom do
  let(:classroom) { Classroom.new('A') }
  let(:student) { Student.new(18, 'John Doe') }

  describe '#initialize' do
    it 'creates a new classroom with the given label' do
      expect(classroom.label).to eq('A')
      expect(classroom.students).to be_an(Array)
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      expect do
        classroom.add_student(student)
      end.to change { classroom.students.length }.by(1)

      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
