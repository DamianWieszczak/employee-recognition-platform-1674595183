require 'rails_helper'

RSpec.describe 'Category CRUD actions', type: :system do
  let!(:admin) { create :admin }
  let!(:employee) { create :employee }
  let!(:reward) { create :reward }

  context 'when using CRUD actions' do
    before do
      login_as(admin, scope: :admin)
    end

    it 'Check if category existed?' do
      category = create(:category)
      visit admins_categories_path
      expect(page).to have_text(category.title)
    end

    it 'checks #new option for category' do
      visit admins_categories_path
      click_link 'New Category'
      fill_in 'Title', with: 'New Category'
      click_button 'Create'
      visit admins_categories_path
      expect(page).to have_text 'New Category'
    end

    it 'checks #edit option for category' do
      visit admins_categories_path
      click_link 'Edit'
      fill_in 'Title', with: 'Edited Category'
      click_button 'Update'
      visit admins_categories_path
      expect(page).to have_text 'Edited Category'
    end

    it '#Destroy category when reward existing its not possible' do
      visit admins_rewards_path
      click_link 'New Reward'
      fill_in 'Title', with: Faker::Movies::StarWars.planet
      fill_in 'Description', with: Faker::Movies::StarWars.quote
      fill_in 'Price', with: rand(1..999)
      page.select reward.category.title, from: 'reward_category_id'
      click_button 'Create'
      visit admins_categories_path
      click_link 'Delete'
      expect(page).to have_content 'Deleting Category failed'
    end
  end
end
