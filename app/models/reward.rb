class Reward < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  has_many :orders, dependent: :destroy, inverse_of: :reward
  has_many :category_rewards
  has_many :categories, through: :category_rewards
end
