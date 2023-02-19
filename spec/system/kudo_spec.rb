require 'rails_helper'

RSpec.describe 'Kudo test' do
  before do
    driven_by(:rack_test)
  end

  it 'Creates, update and destroy kudo' do
    employee = create(:employee)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    click_link 'New Kudo'
    fill_in 'Title', with: 'Kudo Test Title'
    fill_in 'Content', with: 'Kudo Test Content'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created'
    expect(page).to have_content 'Kudo Test Content'

    click_link 'Edit'
    fill_in 'Title', with: 'Kudo Edited Title'
    fill_in 'Content', with: 'Kudo Edited Content'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated'

    click_link 'Delete'
    expect(page).to have_content 'Kudo was successfully deleted'
    expect(page).not_to have_content 'Kudo Edited Content'
  end
end
