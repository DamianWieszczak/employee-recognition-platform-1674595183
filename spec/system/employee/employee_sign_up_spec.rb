require 'rails_helper'

RSpec.describe 'Sign up process', type: :system do
  it 'enables me to sign up an employee' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: employee.email
    fill_in 'First name', with: employee.first_name
    fill_in 'Last name', with: employee.last_name
    fill_in 'Password', with: employee.password
    click_button 'Sign up'
    expect(page).to have_content 'Signed up successfully.'
  end
end
