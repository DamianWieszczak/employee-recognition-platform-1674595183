module Admins
  module Employees
    class OrdersController < AdminsController
      def index
        
        @orders = Order.all.includes(:employee).order(status: :asc)
      end
    end
  end
end
