# frozen_string_literal: true

RSpec.describe Bakery::PackFactory do
  subject { build :pack_factory }

  describe '#build' do
    context 'with valid pack config' do
      let(:pack_config) do
        [
          { code: 'CODE', price: 9.99, quantity: 5 },
          { code: 'CODE', price: 9.99, quantity: 5 },
          { code: 'CODE', price: 9.99, quantity: 5 }
        ]
      end

      it 'returns 3 objects' do
        objects = subject.build(pack_config)
        expect(objects.length).to eq 3
      end

      it 'returns objects that have the correct code' do
        object = subject.build(pack_config).first
        expect(object.code).to eq 'CODE'
      end

      it 'returns objects that have the correct price' do
        object = subject.build(pack_config).first
        expect(object.price).to eq 9.99
      end

      it 'returns objects that have the correct quantity' do
        object = subject.build(pack_config).first
        expect(object.quantity).to eq 5
      end
    end

    context 'with invalid pack config' do
      let(:pack_config) do
        [
          { invalid_config: 'INVALID' }
        ]
      end

      it 'raises an exception' do
        expect do
          subject.build(pack_config)
        end.to raise_error Bakery::InvalidPackConfig
      end
    end
  end
end
