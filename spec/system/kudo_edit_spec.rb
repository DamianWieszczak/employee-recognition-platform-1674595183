require 'rails_helper'

RSpec.describe 'Delete Kudo test' do
  let!(:employee) { create :employee }
  let!(:kudo) { create :kudo, giver: employee }

  it 'Editing Kudo' do
    login_as(employee, scope: :employee)
    visit root_path
    click_link 'Edit'
    fill_in 'Title', with: 'Kudo Edited Title'
    fill_in 'Content', with: 'Kudo Edited Content'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated'
  end
end
