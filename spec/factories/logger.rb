# frozen_string_literal: true

FactoryGirl.define do
  factory :logger, class: Bakery::Logger do
    initialize_with { new(stream: StringIO.new) }
  end
end
