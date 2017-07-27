# frozen_string_literal: true

RSpec.describe Bakery::OrderParser do
  subject { build :order_parser }

  describe '#parse' do
    context 'with a valid filepath' do
      context 'with a valid order' do
        it 'returns 3 lines' do
          lines = subject.parse('spec/support/order.txt')
          expect(lines.count).to eq 3
        end

        it 'returns objects that have the correct code' do
          line = subject.parse('spec/support/order.txt').first
          expect(line.code).to eq 'CODE'
        end

        it 'returns objects that have the correct quantity' do
          line = subject.parse('spec/support/order.txt').first
          expect(line.quantity).to eq 5
        end
      end

      context 'with an invalid order' do
        it 'raises an InvalidOrderFormat exception' do
          expect do
            subject.parse('spec/support/invalid_order.txt')
          end.to raise_error Bakery::InvalidOrderFormat
        end
      end
    end

    context 'with an invalid filepath' do
      it 'raises an InvalidFilepath exception' do
        expect do
          subject.parse('invalid')
        end.to raise_error Bakery::InvalidFilepath
      end
    end
  end
end
