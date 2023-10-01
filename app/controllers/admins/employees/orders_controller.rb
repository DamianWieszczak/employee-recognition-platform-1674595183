module Admins
  module Employees
    class OrdersController < AdminsController
      def index
        @orders = Order.all.includes(:employee).order(status: :asc)
        respond_to do |format|
          format.html
          format.csv do
            filename = ['Orders - ', Time.zone.today.to_s].join(' ')
            send_data Order.to_csv, filename:, content_type: 'text/csv'
          end
        end
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
