require 'rails_helper'

RSpec.describe 'index?', type: :system do
  let!(:admin) { create :admin }
  let!(:employee) { create :employee }
  let!(:kudo) { create :kudo, giver: employee }

  it 'Admin Listing Kudos' do
    login_as(admin, scope: :admin)
    visit admins_kudos_path
    expect(page).to have_content kudo.title
  end
end
