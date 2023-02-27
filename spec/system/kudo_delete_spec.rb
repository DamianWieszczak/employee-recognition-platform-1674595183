require 'rails_helper'

RSpec.describe 'Delete Kudo test' do
  let!(:employee) { create :employee }
  let!(:kudo) { create :kudo, giver: employee }

  it 'Deleting Kudo' do
    login_as(employee, scope: :employee)
    visit root_path
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully deleted'
  end
end
