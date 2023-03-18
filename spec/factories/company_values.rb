FactoryBot.define do
  factory :company_value do
    title { Faker::Company.industry }
  end
end
