require 'rails_helper'

RSpec.describe 'management of employees by admin', type: :system do
  let!(:admin) { create :admin}
  let!(:employee) { create :employee }

  context 'admin listing, updating and deleting employees' do

    it 'checks employees listing page' do
      visit admins_employees_path
      expect(page).to have_content(employee.email)
    end

    it 'updating employee' do
      visit admins_employees_path
      click_link 'Edit'
      fill_in 'Email', with: 'edited@example.com'
      fill_in 'Number of available kudos', with: 2
      click_link 'Update Employee'
      expect(page).to have_content 'Employee account was successfully updated'
    end

    it 'deleting employee account' do
      visit admins_employees_path
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'Employee acoount was successfully deleted'
    end
  end
end
