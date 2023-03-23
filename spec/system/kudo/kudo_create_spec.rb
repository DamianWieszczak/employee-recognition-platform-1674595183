require 'rails_helper'

RSpec.describe 'Create Kudo test' do
  let!(:employee) { create :employee }
  let!(:company_value) { create :company_value }

  it 'Creating Kudo' do
    login_as(employee, scope: :employee)
    visit root_path
    click_link 'New Kudo'
    fill_in 'Title', with: Faker::Company.industry
    fill_in 'Content', with: Faker::Quote.famous_last_words
    page.select company_value.title
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created'
  end
end
