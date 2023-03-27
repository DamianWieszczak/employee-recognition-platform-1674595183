FactoryBot.define do
  factory :reward do
    title { Faker::Movies::StarWars.planet }
    description { Faker::Movies::StarWars.quotes }
    price { rand(1..999) }
  end
end
