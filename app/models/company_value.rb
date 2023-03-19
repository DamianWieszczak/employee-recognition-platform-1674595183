class CompanyValue < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :kudos, dependent: :destroy, inverse_of: :company_value
end
