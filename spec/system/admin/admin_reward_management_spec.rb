require 'rails_helper'

RSpec.describe 'Company Value CRUD actions', type: :system do
  let!(:admin) { create :admin }
  let!(:reward) { create :reward }

  context 'when using CRUD actions' do
    before do
      login_as(admin, scope: :admin)
    end

    it 'Check if rewards existed?' do
      visit admins_rewards_path
      expect(page).to have_content(reward.title)
      expect(page).to have_button 'Delete'
    end

    it 'Creates Reward' do
      visit admins_rewards_path
      click_link 'New Reward'
      fill_in 'Title', with: Faker::Movies::StarWars.planet
      fill_in 'Description', with: Faker::Movies::StarWars.quotes
      fill_in 'Price', with: rand(1..999)
      click_button 'Create'
      expect(page).to have_content 'Reward was successfully saved'
    end

    it 'Check edit function' do
      visit admins_rewards_path
      click_link 'Edit'
      fill_in 'Title', with: 'Edited Title'
      fill_in 'Description', with: 'Edited Title'
      fill_in 'Price', with: rand(1..999)
      click_button 'Update'
      expect(page).to have_content 'Reward was updated'
    end

    it 'deletes reward' do
      visit admins_rewards_path
      click_link 'Delete'
      expect(page).to have_content 'Reward was successfully deleted'
    end
  end
end