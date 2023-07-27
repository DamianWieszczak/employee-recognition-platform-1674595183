require 'rails_helper'

RSpec.describe 'Reward CRUD actions', type: :system do
  let!(:admin) { create :admin }
  let!(:employee) { create :employee }
  let!(:reward) { create :reward }

  context 'when using CRUD actions' do
    before do
      login_as(admin, scope: :admin)
    end

    it 'Check if reward existed?' do
      visit admins_rewards_path
      expect(page).to have_content(reward.title)
    end

    it 'Creates Reward' do
      visit admins_rewards_path
      click_link 'New Reward'
      fill_in 'Title', with: Faker::Movies::StarWars.planet
      fill_in 'Description', with: Faker::Movies::StarWars.quote
      fill_in 'Price', with: rand(1..999)
      click_button 'Create'
      expect(page).to have_content 'Reward was successfully saved'
      expect(page).to have_content reward.category.title
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

    it 'Checks price in the employees order will not change after the admin change reward price' do
      login_as(employee, scope: :employee)
      visit employees_rewards_path
      click_link 'Buy'
      employee_order_price = reward.price
      login_as(admin, scope: :admin)
      visit admins_rewards_path
      click_link 'Edit'
      fill_in 'Price', with: '15'
      click_button 'Update'
      login_as(employee, scope: :employee)
      visit employees_orders_path
      expect(page).to have_content employee_order_price
    end
  end
end
