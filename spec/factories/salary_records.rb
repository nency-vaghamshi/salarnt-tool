FactoryBot.define do
  factory :salary_record do
    employee
    currency
    effective_from { Date.new(2024, 4, 1) }
    effective_to { Date.new(2025, 3, 31) }
    status { "active" }
  end
end
