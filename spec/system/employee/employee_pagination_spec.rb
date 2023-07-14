require 'rails_helper'

RSpec.describe 'Employee filtering actions', type: :system do
  let!(:employee) { create :employee }
  let!(:rewards) { create_list(:reward, 4) }

  it 'displays 1 reward on the second page' do
    login_as(employee, scope: :employee)
    visit employees_rewards_path
    click_link 'Next'
    expect(page).to have_current_path("#{employees_rewards_path}?page=2")
    expect(page).to have_content(Reward.last.title, count: 1)
  end
end
