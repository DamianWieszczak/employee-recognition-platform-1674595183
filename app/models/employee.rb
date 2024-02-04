class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :receiver
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id', dependent: :destroy, inverse_of: :giver
  has_many :orders, dependent: :destroy, inverse_of: :employee

  validates :first_name, presence: true
  validates :last_name, presence: true

  def post_delivery?
    reward.delivery_method == 'post_delivery'
  end

  def online_delivery?
    reward.delivery_method == 'online'
  end

  private

  def password_required?
    new_record? ? super : false
  end
end
