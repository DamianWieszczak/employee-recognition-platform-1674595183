require 'rails_helper'

RSpec.describe 'Employee filtering actions', type: :system do
  let!(:employee) { create :employee }
  let!(:order) { create(:order, employee:) }

  it 'checks if the filtering works - Delivered' do
    login_as(employee, scope: :employee)
    visit employees_orders_path
    click_link 'Delivered'
    expect(page).to have_no_content order.reward.title
  end

  it 'checks if the filtering works - Not Delivered' do
    login_as(employee, scope: :employee)
    visit employees_orders_path
    click_link 'Not Delivered'
    expect(page).to have_content order.reward.title
  end

  it 'checks if you get appropriate message when you order reward with online method' do
    login_as(employee, scope: :employee)
    visit employees_rewards_path
    click_link 'Buy'
    click_link 'Online Delivery'
    expect(page).to have_text 'You have successfully purchased a reward'
  end

  it 'checks the validation of the address data' do
    login_as(employee, scope: :employee)
    visit employees_rewards_path
    click_link 'Edit'
    page.select 'post_delivery', from: 'reward_delivery_method'
    click_button 'Update Reward'
    expect(page).to have_text 'Reward was updated'
    visit employees_rewards_path
    click_link 'Buy'
    fill_in 'City', with: ''
    fill_in 'Street', with: ''
    fill_in 'Postcode', with: ''
    click_button 'Post Delivery'
    expect(page).to have_content '3 errors prohibited this object from being saved'
  end

  it 'Checks whether the post delivery order is being processed correctly' do
    login_as(employee, scope: :employee)
    visit employees_rewards_path
    click_link 'Edit'
    page.select 'post_delivery', from: 'reward_delivery_method'
    click_button 'Update Reward'
    expect(page).to have_text 'Reward was updated'
    visit employees_rewards_path
    click_link 'Buy'
    fill_in 'City', with: 'city'
    fill_in 'Street', with: 'street'
    fill_in 'Postcode', with: '123456'
    click_button 'Post Delivery'
    expect(page).to have_text 'You have successfully purchased a reward'
  end

  it 'Checks whether the post delivery order is being processed correctly and the address will be included' do
    login_as(employee, scope: :employee)
    visit employees_rewards_path
    click_link 'Edit'
    page.select 'post_delivery', from: 'reward_delivery_method'
    click_button 'Update Reward'
    expect(page).to have_text 'Reward was updated'
    visit employees_rewards_path
    click_link 'Buy'
    fill_in 'City', with: 'city'
    fill_in 'Street', with: 'street'
    fill_in 'Postcode', with: '123456'
    click_button 'Post Delivery'
    expect(page).to have_text 'You have successfully purchased a reward'
    visit employees_rewards_path
    click_link 'Buy'
    expect(page).to have_field('City', with: 'city')
    expect(page).to have_field('Street', with: 'street')
    expect(page).to have_field('Postcode', with: '123456')
  end
end
