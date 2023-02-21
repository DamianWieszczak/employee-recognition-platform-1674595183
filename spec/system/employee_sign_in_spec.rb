require 'rails_helper'

RSpec.describe 'Sign in process', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables me to sign in as employee' do
    employee = create(:employee)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
