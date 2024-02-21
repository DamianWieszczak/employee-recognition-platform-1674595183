class Reward < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :image, content_type: ['image/png', 'image/jpeg']
  has_many :orders, dependent: :destroy, inverse_of: :reward
  belongs_to :category
  has_many :online_codes, dependent: :destroy, inverse_of: :reward
  accepts_nested_attributes_for :online_codes, allow_destroy: true
  enum delivery_method: { online: 0, post_delivery: 1 }

  def build_online_codes(available_rewards)
    available_rewards.times { online_codes.build }
  end

  def online_delivery?
    delivery_method == 'online'
  end

  def available_rewards_index
    if online_delivery?
      online_codes.where(used: false).count
    else
      available_rewards
    end
  end
end
