require 'rails_helper'

RSpec.describe 'Importing online codes', type: :system do
  let!(:admin) { create(:admin) }
  let!(:reward1) { create(:reward, id: 30) }
  let!(:reward2) { create(:reward, id: 45) }

  before do
    login_as(admin, scope: :admin)
  end

  it 'imports online codes and displays messages' do
    visit import_online_codes_admins_online_codes_path
    attach_file('file', Rails.root.join('spec/fixtures/online_codes_valid.csv'))
    click_button('Import')
    expect(page).to have_content('Import completed')
  end
end
