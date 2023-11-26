FactoryBot.define do
  factory :employee do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'password' }
    number_of_available_kudos { 10 }
    number_of_earned_points { 60 }
  end
end
