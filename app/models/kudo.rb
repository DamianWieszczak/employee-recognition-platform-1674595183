class Kudo < ApplicationRecord
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :giver, class_name: 'Employee'

  validates :title, presence: true
  validates :content, presence: true
end
