require 'rails_helper'

RSpec.describe 'Sign out process', type: :system do
  it 'enables me to sign out as employee' do
    employee = create(:employee)
    login_as(employee, scope: :employee)
    visit root_path
    click_link 'Sign Out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
