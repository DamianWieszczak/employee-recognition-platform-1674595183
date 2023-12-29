class Order < ApplicationRecord
  require 'csv'

  belongs_to :employee
  belongs_to :reward

  has_one :address, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :address

  enum status: { not_delivered: 0, delivered: 1 }
  scope :filter_by_status, ->(status) { where(status:) }

  def full_address
    if address.nil?
      employee.email
    else
      "#{address.street}, #{address.postcode} #{address.city}"
    end
  end

  def self.to_csv
    CSV.generate(col_sep: ';') do |csv|
      csv << column_names
      all.find_each do |order|
        csv << order.attributes.values
      end
    end
  end
end
