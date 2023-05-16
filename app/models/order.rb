class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward
  enum status: { not_delivered: 0, delivered: 1 }
end
