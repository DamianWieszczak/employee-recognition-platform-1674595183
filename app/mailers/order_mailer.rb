class OrderMailer < ApplicationMailer
  def confirmation_mail
    @order = params[:order]
    mail(to: @order.employee.email, subject: "Your order has been successfully delivered")
  end
end
