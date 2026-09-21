FactoryBot.define do
  factory :job_title do
    name { "Software Engineer" }
    sequence(:code) { |n| "SWE#{n}" }
  end
end
