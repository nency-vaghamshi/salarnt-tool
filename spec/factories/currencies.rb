FactoryBot.define do
  factory :currency do
    sequence(:code) { |n| "C#{n}" }
    name { "Indian Rupee" }
    symbol { "₹" }
  end
end
