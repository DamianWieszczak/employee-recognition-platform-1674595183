class OrderMailer < ApplicationMailer
  def confirmation_mail
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your order has been successfully delivered')
  end

  def mail_with_code
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your online code is below:')
  end

  def mail_pick_up_delivery
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your order will be processed using pick-up delivery')
  end
end
