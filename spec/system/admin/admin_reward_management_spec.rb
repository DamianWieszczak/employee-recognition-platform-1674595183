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

    it 'Creates Reward with valid attachment' do
      visit admins_rewards_path
      click_link 'New Reward'
      fill_in 'Title', with: Faker::Movies::StarWars.planet
      fill_in 'Description', with: Faker::Movies::StarWars.quote
      fill_in 'Price', with: rand(1..999)
      attach_file 'Image', Rails.root.join('public/rails.png')
      click_button 'Create'
      expect(page).to have_content 'Reward was successfully saved'
      expect(page).to have_content reward.category.title
      reward = Reward.last
      expect(reward.image).to be_attached
    end

    it 'Creates Reward with invalid attachment' do
      visit admins_rewards_path
      click_link 'New Reward'
      fill_in 'Title', with: Faker::Movies::StarWars.planet
      fill_in 'Description', with: Faker::Movies::StarWars.quote
      fill_in 'Price', with: rand(1..999)
      attach_file 'Image', Rails.root.join('public/gem.gif')
      click_button 'Create'
      expect(page).to have_content 'Image has an invalid content type'
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

    it 'import a csv file' do
      visit '/admins/rewards/import_view'
      attach_file('file', Rails.root.join('spec/fixtures/rewards.csv'))
      click_button 'Import'
      expect(page).to have_content 'Import completed'
    end

    it 'import a wrong type file' do
      visit '/admins/rewards/import_view'
      attach_file('file', Rails.root.join('spec/fixtures/rewards.txt'))
      click_button 'Import'
      expect(page).to have_content 'Only CSV files allowed'
    end
  end
end
