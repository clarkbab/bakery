# frozen_string_literal: true

FactoryGirl.define do
  factory :line_solver, class: Bakery::LineSolver do
    association :catalogue, strategy: :build

    initialize_with { new(catalogue: catalogue) }
  end

  factory :line_solver_with_complex_catalogue, class: Bakery::LineSolver do
    association :complex_catalogue, strategy: :build

    initialize_with { new(catalogue: complex_catalogue) }
  end
end
