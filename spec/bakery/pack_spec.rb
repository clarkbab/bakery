# frozen_string_literal: true

RSpec.describe Bakery::Pack do
  subject { build :pack }

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

  describe '#price' do
    it 'returns the price' do
      expect(subject.price).to eq 9.99
    end
  end
end
