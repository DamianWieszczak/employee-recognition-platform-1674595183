module Admins
  module Employees
    class OrdersController < AdminsController
      def index
        @orders = Order.all.includes(:employee).order(status: :asc)
      end

      def update
        @order = Order.find(params[:id])
        if @order.update(status: 1)
          OrderMailer.with(order: @order).confirmation_mail.deliver_later
          flash[:notice] = 'Order was successfully delivered to employee'
        else
          flash[:alert] = 'Delivery order failed!'
        end
        redirect_to admins_employees_orders_path
      end
    end
  end
end
