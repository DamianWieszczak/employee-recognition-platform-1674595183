require 'rails_helper'

Rspec.describe Employee, type: :model do
  before do
    create(:employee)
  end

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name)}
end
