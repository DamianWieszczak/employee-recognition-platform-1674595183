require 'rails_helper'

RSpec.describe '#delete?', type: :system do
  let!(:admin) { create :admin }
  let!(:kudo) { create :kudo }

  it 'Deleting kudos by admin' do
    login_as(admin, scope: :admin)
    visit admins_kudos_path
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully deleted'
  end
end
