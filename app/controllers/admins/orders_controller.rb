module Admins
  class OrdersController < AdminsController
    def index
      @employee = Employee.find(params[:employee_id])
      @orders = Order.all.includes(:employee)
    end

    private

    def employee_params
      params.require(:employe).permit(:email)
    end
  end
end
