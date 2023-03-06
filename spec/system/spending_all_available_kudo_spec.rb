require 'rails_helper'

RSpec.describe 'No available kudos', type: :system do
  let(:employee) { create :employee }

  context 'when user has no kudos here' do
    before do
      login_as(employee, scope: :employee)
      employee.number_of_available_kudos = 0
    end

    it 'can not create kudo via button' do
      visit kudos_path
      expect(page).not_to have_button 'New Kudo'
    end

    it 'can not create kudo via url visit' do
      visit '/kudos/new'
      expect(page).to have_content 'You have no more kudos to give'
    end
  end
end
