require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'validations' do
    before do
      create(:reward)
      create(:category)
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price), is_greater_than_or_equal_to: 1 }
    it { is_expected.to validate_numericality_of(:price), lesser_than: 1 }
    it { is_expected.to have_one_attached(:image) }
  end
end
