require_relative '../helpers/nameable'

RSpec.describe Nameable do
  describe '#correct_name' do
    it 'raises NotImplementedError' do
      expect { subject.correct_name }.to raise_error(NotImplementedError, 'Subclasses must implement the correct_name method')
    end
  end
end
