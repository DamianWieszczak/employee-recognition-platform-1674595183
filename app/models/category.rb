class Category < ApplicationRecord
  has_many :category_rewards
  has_many :rewards, through: :category_rewards
end
