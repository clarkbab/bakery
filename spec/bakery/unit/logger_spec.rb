# frozen_string_literal: true

RSpec.describe Bakery::Logger do
  subject { build :logger }

  describe '#log' do
    it 'writes the message to the IO stream' do
      now = DateTime.now
      allow(DateTime).to receive(:now).and_return now
      expect_any_instance_of(StringIO)
        .to receive(:write).with("#{now}[ACTION]: Message\n")
      subject.log :action, 'Message'
    end
  end
end
