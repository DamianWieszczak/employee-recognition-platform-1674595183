class Kudo < ApplicationRecord
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :giver, class_name: 'Employee'
  belongs_to :company_value

  validates :title, presence: true
  validates :content, presence: true
  validates :company_value, presence: true
end
