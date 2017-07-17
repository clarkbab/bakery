# frozen_string_literal: true

RSpec.describe Bakery::Catalogue do
  subject { build :catalogue }

  describe '#search_by_code' do
    context 'with a valid code' do
      it 'returns 2 items' do
        items = subject.search_by_code('CODE')
        expect(items.count).to eq 2
      end
    end

    context 'with a invalid code' do
      it 'returns 0 items' do
        items = subject.search_by_code('INVALID')
        expect(items.count).to eq 0
      end
    end
  end
end
