require 'rails_helper'

RSpec.describe 'Company Value CRUD actions', type: :system do
  let!(:admin) { create :admin }
  let!(:company_value) { create :company_value }

  context 'when using CRUD actions' do
    before do
      login_as(admin, scope: :admin)
    end

    it 'Check listed Company Value' do
      visit admins_company_values_path
      expect(page).to have_content(company_value.title)
    end

    it 'Creates Company Values' do
      visit admins_company_values_path
      click_link 'New Company Value'
      fill_in 'Title', with: Faker::Company.industry
      click_button 'Create'
      expect(page).to have_content 'Company Value was successfully saved'
    end

    it 'Check edit function' do
      visit admins_company_values_path
      click_link 'Edit'
      fill_in 'Title', with: 'Edited Title'
      click_button 'Update'
      expect(page).to have_content 'Company Value was updated'
    end

    it 'deletes company value' do
      visit admins_company_values_path
      click_link 'Delete'
      expect(page).to have_content 'Company Value was successfully deleted'
    end
  end
end
