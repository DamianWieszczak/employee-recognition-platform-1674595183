require 'rails_helper'

RSpec.describe 'Category CRUD actions', type: :system do
  let!(:employee) { create :employee }
  let!(:reward) { create :reward }

  before do
    login_as(employee, scope: :employee)
  end

  it 'checks #show action for employee' do
    visit employees_rewards_path
    click_link reward.category.title
    expect(page).to have_text 'Rewards for the category'
  end

  it 'checks back link in show page of category' do
    visit employees_rewards_path
    click_link reward.category.title
    expect(page).to have_text 'Rewards for the category'
    click_link 'Back to rewards'
    expect(page).to have_link 'New Reward'
  end
end
