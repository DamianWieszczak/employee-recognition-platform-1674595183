require 'rails_helper'

RSpec.describe 'Delete Kudo test' do
  let!(:employee) { create :employee }
  let!(:kudo) { create :kudo, giver: employee }

  it 'Deleting Kudo' do
    login_as(employee, scope: :employee)
    employee.number_of_earned_points = 10
    visit root_path
    click_link 'Destroy'
    employee.number_of_earned_points = 0
    expect(page).to have_content 'Kudo was successfully deleted'
    expect(page).to have_content 'Your Earned Points: {0}'
  end
end
