# frozen_string_literal: true

RSpec.describe Bakery::LineSolver do
  describe '#solve' do
    context 'with simple catalogue' do
      subject { build :line_solver }

      context 'with solvable line' do
        let(:line) { build :line, quantity: 15 }

        it 'returns the correct number of packs' do
          packs = subject.solve(line)
          expect(packs.length).to eq 3
        end

        it 'returns the correct packs' do
          pack = subject.solve(line).first
          expect(pack.code).to eq 'CODE'
        end
      end

      context 'with unsolvable line' do
        let(:line) { build :line, quantity: 12 }

        it 'raises a CantSatisfyOrder exception' do
          expect do
            subject.solve(line)
          end.to raise_error Bakery::CantSatisfyOrder
        end
      end
    end

    context 'with complex catalogue' do
      subject { build :line_solver_with_complex_catalogue }

      context 'with solvable line' do
        let(:line) { build :line, quantity: 8 }

        it 'returns the correct number of packs' do
          packs = subject.solve(line)
          expect(packs.length).to eq 2
        end

        it 'returns the correct packs' do
          pack = subject.solve(line).first
          expect(pack.code).to eq 'CODE'
        end
      end

      context 'with unsolvable line' do
        let(:line) { build :line, quantity: 7 }

        it 'raises a CantSatisfyOrder exception' do
          expect do
            subject.solve(line)
          end.to raise_error Bakery::CantSatisfyOrder
        end
      end
    end
  end
end
