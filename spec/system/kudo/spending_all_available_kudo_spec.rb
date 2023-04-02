require 'rails_helper'

RSpec.describe 'No available kudos', type: :system do
  let!(:employee) { create :employee }

  context 'when user has spending available kudo' do
    before do
      login_as(employee, scope: :employee)
      employee.number_of_available_kudos = 1
      create(:kudo)
      employee.number_of_available_kudos = 0
    end

    it 'can not create kudo via button' do
      visit employees_kudos_path
      expect(page).not_to have_link 'New Kudo'
    end

    it 'can not create kudo via url visit' do
      visit 'employees/kudos/new'
      expect(page).to have_content 'You have no more kudos to give'
    end
  end
end
