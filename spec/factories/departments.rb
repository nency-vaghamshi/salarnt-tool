FactoryBot.define do
  factory :department do
    name { "Engineering" }
    sequence(:code) { |n| "ENG#{n}" }
  end
end
