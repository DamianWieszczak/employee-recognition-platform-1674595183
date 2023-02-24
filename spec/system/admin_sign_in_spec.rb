require 'rails_helper'

RSpec.describe 'Admin Sign in process', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables me to sign in as admin' do
    admin = create(:admin)
    visit root_path
    click_link 'Admin'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
