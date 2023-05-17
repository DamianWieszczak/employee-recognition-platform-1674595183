require 'rails_helper'

RSpec.describe 'Admin order actions', type: :system do
  let!(:admin) { create :admin }
  let!(:employee) { create :employee }
  let!(:order) { create :order }

  it 'checks if the order is delivered' do
    login_as(admin, scope: :admin)
    visit admins_employees_orders_path
    click_link 'Deliver'
    expect(page).to have_text 'Order was successfully delivered to employee'
  end
end
