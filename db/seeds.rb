# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 5.times do |i|
#   Employee.create(email: "user#{i+1}@example.com", password: "password")
# end

5.times do |i| 
  Kudo.create!(
    title: Faker::Adjective.positive,
    content: Faker::Quote.famous_last_words,
    receiver: Employee.create!(email: Faker::Internet.email(domain: "example#{i}.com"), password: "password"),
    giver: Employee.create!(email: Faker::Internet.email(domain: "example#{i+1}.com"), password: "password")
  )
end

Admin.create!(email: Faker::Internet.email(domain: "admin.com"), password: "password")

CompanyValue.create!([{title: 'Honesty'}, {title: 'Ownership'}, {title: 'Accountability'}, {title: 'Passion'}])
