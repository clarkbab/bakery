# frozen_string_literal: true

RSpec.describe Bakery do
  subject { Bakery.configuration }

  describe 'overwriting configuration settings' do
    before do
      Bakery.configure do |config|
        config.logging = true
        config.logging_method = :stdout
        config.logpath = 'temp/testing.log'
      end
    end

    it 'has logging' do
      expect(subject.logging).to eq true
    end

    it 'logs to stdout' do
      expect(subject.logging_method).to eq :stdout
    end

    it 'logs to temp/testing.log' do
      expect(subject.logpath).to eq 'temp/testing.log'
    end
  end
end
