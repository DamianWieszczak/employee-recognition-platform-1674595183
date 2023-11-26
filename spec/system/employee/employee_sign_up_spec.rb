require 'rails_helper'

RSpec.describe 'Sign up process', type: :system do
  it 'enables me to sign up an employee' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'example@email.com'
    fill_in 'First name', with: 'Name'
    fill_in 'Last name', with: 'Surname'
    fill_in 'Password', with: 'password'
    fill_in 'employee_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully. '
  end
end
