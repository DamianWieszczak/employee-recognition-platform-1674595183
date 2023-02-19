require 'rails_helper'

RSpec.describe "Sign in process", type: :system do
  before do 
    driven_by(:rack_test)
  end

  it 'enables me to sign in, sign out an employee acount' do
    employee = create(:employee)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')

    visit root_path
    click_link 'Sign Out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
