require 'rails_helper'

RSpec.describe 'Delete Kudo test' do
  let!(:employee) { create :employee }
  let!(:kudo) { create :kudo, giver: employee }

  before do
    login_as(employee, scope: :employee)
    driven_by(:rack_test)
  end

  it 'Deleting Kudo' do
    visit root_path
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully deleted'
  end
end
