class OnlineCode < ApplicationRecord
  before_create :generate_online_code
  attr_accessor :generated_code

  belongs_to :reward

  private

  def generate_online_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
