require 'rails_helper'

RSpec.describe 'Delete Kudo test' do
  let!(:employee) { FactoryBot.create :employee }
  let!(:kudo) { FactoryBot.create :kudo, giver: employee }

  before do
    login_as(employee)
    driven_by(:rack_test)
  end

  it 'Editing Kudo' do
    visit root_path
    click_link 'Edit'
    fill_in 'Title', with: 'Kudo Edited Title'
    fill_in 'Content', with: 'Kudo Edited Content'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated'
  end
end
