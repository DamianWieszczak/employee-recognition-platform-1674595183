FactoryBot.define do
  factory :order do
    employee
    reward
    price { 0 }
    status { 0 }
  end
end
