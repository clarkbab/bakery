# frozen_string_literal: true

RSpec.describe Bakery::Configuration do
  subject { build :configuration }

  describe '#logging' do
    context 'with default setting' do
      it 'has no logging' do
        expect(subject.logging).to eq false
      end
    end

    context 'with overidden setting' do
      it 'has logging' do
        subject.logging = true
        expect(subject.logging).to eq true
      end
    end
  end

  describe '#logging_method' do
    context 'with default setting' do
      it 'logs to a file' do
        expect(subject.logging_method).to eq :file
      end
    end

    context 'with overidden setting' do
      it 'logs to stdout' do
        subject.logging_method = :stdout
        expect(subject.logging_method).to eq :stdout
      end
    end
  end

  describe '#logpath' do
    context 'with default setting' do
      it 'logs to log/bakery.log' do
        expect(subject.logpath).to eq 'log/bakery.log'
      end
    end

    context 'with overidden setting' do
      it 'logs to temp/testing.log' do
        subject.logpath = 'temp/testing.log'
        expect(subject.logpath).to eq 'temp/testing.log'
      end
    end
  end
end
