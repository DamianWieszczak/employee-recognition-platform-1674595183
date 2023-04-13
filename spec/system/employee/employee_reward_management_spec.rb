require 'rails_helper'

RSpec.describe 'Reward management actions for employee', type: :system do
  let!(:employee) { create :employee }
  let!(:reward) { create :reward }

  context 'when employee checking rewards' do
    before do
      login_as(employee, scope: :employee)
    end

    it 'Checks if there are any rewards on the list?' do
      visit employees_rewards_path
      expect(page).to have_content(reward.title)
    end

    it 'Checks show action for reward' do
      visit employees_rewards_path
      click_link 'Show'
      expect(page).to have_content(reward.description)
    end

    it 'Checks the buy action and if the number of points decreases after the purchase' do
      visit employees_rewards_path
      click_link 'Buy'
      expect(page).to have_content 'You have successfully purchased a reward'
      expect(page).to have_content(employee.number_of_earned_points - reward.price.to_i)
    end
  end
end
