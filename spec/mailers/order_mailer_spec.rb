require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe 'sending confirmation email' do
    let(:order) { create(:order) }
    let(:mail) { described_class.with(order:).confirmation_mail.deliver_now }

    it 'checks title' do
      expect(mail.subject).to eq 'Your order has been successfully delivered'
    end

    it 'checks receiver email' do
      expect(mail.to).to have_content order.employee.email
    end

    it 'checks sender mail' do
      expect(mail.from).to eq(['damian632@vp.pl'])
    end
  end
end
