# frozen_string_literal: true

RSpec.describe Bakery::Line do
  subject { build :line }

  describe '#code' do
    it 'returns the code' do
      expect(subject.code).to eq 'CODE'
    end
  end

  describe '#quantity' do
    it 'returns the quantity' do
      expect(subject.quantity).to eq 5
    end
  end
end
