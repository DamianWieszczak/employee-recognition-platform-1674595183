class Reward < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :image, content_type: ['image/png', 'image/jpeg']
  has_many :orders, dependent: :destroy, inverse_of: :reward
  belongs_to :category
end
