FactoryBot.define do
  factory :country do
    name { "India" }
    sequence(:code) { |n| "IN#{n}" }
    currency
  end
end
