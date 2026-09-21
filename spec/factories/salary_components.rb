FactoryBot.define do
  factory :salary_component do
    name { "Basic Salary" }
    sequence(:code) { |n| "BASIC#{n}" }
    component_type { "earning" }
    calculation_type { "fixed" }
    is_taxable { true }
    is_active { true }
  end
end
