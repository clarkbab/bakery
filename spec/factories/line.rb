# frozen_string_literal: true

FactoryGirl.define do
  factory :line, class: Bakery::Line do
    code 'CODE'
    quantity 5

    initialize_with { new(code: code, quantity: quantity) }
  end
end
