require_relative '../helpers/nameable'
require_relative '../decorators/decorator'
RSpec.describe Decorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { described_class.new(nameable) }
  describe '#initialize' do
    it 'sets the nameable attribute' do
      expect(decorator.nameable).to eq(nameable)
    end
  end
  describe '#correct_name' do
    it 'calls the correct_name method on the nameable object' do
      expect(nameable).to receive(:correct_name)
      decorator.correct_name
    end
  end
end
