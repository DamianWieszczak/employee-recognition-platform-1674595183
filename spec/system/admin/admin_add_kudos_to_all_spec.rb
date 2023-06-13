require 'rails_helper'

RSpec.describe 'add kudos to every employee', type: :system do
  let!(:admin) { create :admin }
  let!(:employee1) { create :employee }
  let!(:employee2) { create :employee }

  it 'checks if the add kudo to all feature is working' do
    login_as(admin, scope: :admin)
    visit admins_dashboard_path
    click_link 'Add Kudos'
    fill_in 'amount',	with: 3
    click_button 'Add'
    employee1.reload
    employee2.reload
    expect(page).to have_text 'Successfully added the specified amount of kudos for each employee'
    expect(employee1.number_of_available_kudos).to eq(13)
    expect(employee2.number_of_available_kudos).to eq(13)
  end

  it 'checks if the constrains on the number of available kudos field work' do
    login_as(admin, scope: :admin)
    visit admins_dashboard_path
    click_link 'Add Kudos'
    fill_in 'amount',	with: 30
    click_button 'Add'
    expect(page).to have_text "It's possible to only add kudos from 1 to 20 for each employee"
  end
end
