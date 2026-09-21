FactoryBot.define do
  factory :employee do
    sequence(:employee_number) { |n| "EMP#{n}" }
    first_name { "Ada" }
    last_name { "Lovelace" }
    sequence(:email) { |n| "ada.lovelace#{n}@acme.test" }
    department
    job_title
    country
    employment_status { "active" }
    joined_on { Date.new(2024, 4, 1) }
  end
end
