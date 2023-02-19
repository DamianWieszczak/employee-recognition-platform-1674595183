FactoryBot.define do
  factory :kudo do
    title { 'Kudo Title' }
    content { 'Kudo Content' }
    association :giver, factory: :Employee
    association :receiver, factory: :Employee
  end
end
