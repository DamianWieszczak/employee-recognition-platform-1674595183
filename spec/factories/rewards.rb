FactoryBot.define do
  factory :reward do
    title { Faker::Movies::StarWars.planet }
    description { Faker::Movies::StarWars.quote }
    price { rand(1..50) }
    category
    delivery_method { 0 }
    available_rewards { 10 }
    trait :online_code do
      delivery_method { 'online' }
      after(:create) do |reward|
        create_list(:online_code, 1, reward:)
      end
    end
  end
end
