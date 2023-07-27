FactoryBot.define do
  factory :category do
    title { Faker::Games::Witcher.sign }
  end
end
