require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  describe 'validations' do
    before { create :company_value}

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
  end
end
