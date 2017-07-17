# frozen_string_literal: true

FactoryGirl.define do
  factory :pack, class: Bakery::Pack do
    code 'CODE'
    price 9.99
    quantity 5

    initialize_with { new(code: code, price: price, quantity: quantity) }
  end

  factory :pack_with_different_code, parent: :pack do
    code 'CODE2'
  end

  factory :pack_with_different_price_and_quantity, parent: :pack do
    price 16.99
    quantity 10
  end

  factory :pack_with_quantity_3, parent: :pack do
    quantity 3
  end
end
