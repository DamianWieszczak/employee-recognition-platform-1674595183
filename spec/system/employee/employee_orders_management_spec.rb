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
end
