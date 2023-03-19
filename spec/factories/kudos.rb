FactoryBot.define do
  factory :kudo do
    title { Faker::Company.industry }
    content { Faker::Quote.famous_last_words }
    company_value factory: :company_value
    association :giver, factory: :employee
    association :receiver, factory: :employee
  end
end
