module Admins
  class OrdersController < AdminsController
    def index
      @employee = Employee.find(params[:employee_id])
      @orders = Order.all.includes(:employee, :address).order(status: :asc)
    end

    def update
      @order = Order.find(params[:id])
      if @order.update(status: 1)
        flash[:notice] = 'Order was successfully delivered to employee'
      else
        flash[:alert] = 'Delivery order failed!'
      end
      redirect_to admins_employee_orders_path
    end
  end
end
