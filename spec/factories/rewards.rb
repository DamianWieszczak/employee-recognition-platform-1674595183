FactoryBot.define do
  factory :reward do
    title { Faker::Movies::StarWars.planet }
    description { Faker::Movies::StarWars.quote }
    price { rand(1..50) }
    category
  end
end
