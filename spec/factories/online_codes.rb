FactoryBot.define do
  factory :online_code do
    code { SecureRandom.alphanumeric(8) }
    used { false }
    reward
  end
end
