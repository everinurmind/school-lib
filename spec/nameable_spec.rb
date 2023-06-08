require_relative '../helpers/nameable'

RSpec.describe Nameable do
  describe '#correct_name' do
    it 'raises NotImplementedError' do
      expect do
        subject.correct_name
      end.to raise_error(NotImplementedError, 'Subclasses must implement the correct_name method')
    end
  end
end
