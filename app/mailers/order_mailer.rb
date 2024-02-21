class OrderMailer < ApplicationMailer
  def confirmation_mail
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your order has been successfully delivered')
  end

  def mail_with_code
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your online code is below:')
  end
end
