# frozen_string_literal: true

RSpec.describe Bakery::ReceiptBuilder do
  subject { build :receipt_builder }

  describe '#build_line' do
    context 'with objects of the same code' do
      let(:packs) do
        pack = build :pack
        [pack, pack]
      end

      context 'with the same pack sizes' do
        it 'returns the correct format' do
          receipt_line = subject.build_line(packs)
          expect(receipt_line).to eq [
            '10 CODE $19.98',
            '  2 x 5 $9.99'
          ]
        end
      end

      context 'with different pack sizes' do
        it 'returns the correct format' do
          other_pack = build :pack_with_different_price_and_quantity
          packs << other_pack
          receipt_line = subject.build_line(packs)
          expect(receipt_line).to eq [
            '20 CODE $36.97',
            '  2 x 5 $9.99',
            '  1 x 10 $16.99'
          ]
        end
      end
    end

    context 'with objects of different codes' do
      let(:packs) do
        pack = build :pack
        other_pack = build :pack_with_different_code
        [pack, other_pack]
      end

      it 'raises an InconsistentCode exception' do
        expect do
          subject.build_line(packs)
        end.to raise_error Bakery::InconsistentCodes
      end
    end
  end

  describe '#error_line' do
    it 'returns the correct format' do
      expect(subject.error_line)
        .to eq 'Your order could not be fulfilled.'
    end
  end
end
