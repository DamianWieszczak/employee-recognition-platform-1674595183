require 'rails_helper'

RSpec.describe 'management of employees by admin', type: :system do
  let!(:admin) { create :admin }
  let!(:employee) { create :employee }

  context 'when admin listing, updating and deleting employees' do
    before do
      login_as(admin, scope: :admin)
    end

    it 'checks employees listing page' do
      visit admins_employees_path
      expect(page).to have_content(employee.email)
    end

    it 'updating employee' do
      visit admins_employees_path
      click_link 'Edit'
      fill_in 'Email', with: employee.email
      fill_in 'First name', with: employee.first_name
      fill_in 'Last name', with: employee.last_name
      fill_in 'Number of available kudos', with: 2
      click_button 'Update Employee'
      expect(page).to have_content 'Employee account was successfully updated'
    end

    it 'deleting employee account' do
      visit admins_employees_path
      click_link 'Delete Employee'
      expect(page).to have_content 'Employee acount was successfully deleted'
    end
  end
end
