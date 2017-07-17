# frozen_string_literal: true

FactoryGirl.define do
  factory :catalogue, class: Bakery::Catalogue do
    association :pack, strategy: :build
    association :pack_with_different_code, strategy: :build

    initialize_with { new(items: [pack, pack, pack_with_different_code]) }
  end

  factory :complex_catalogue, class: Bakery::Catalogue do
    association :pack, strategy: :build
    association :pack_with_different_price_and_quantity, strategy: :build
    association :pack_with_quantity_3, strategy: :build

    initialize_with do
      new(
        items: [
          pack, pack_with_different_price_and_quantity, pack_with_quantity_3
        ]
      )
    end
  end
end
