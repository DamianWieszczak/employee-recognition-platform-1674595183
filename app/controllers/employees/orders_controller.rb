module Employees
  class OrdersController < EmployeesController
    def index
      orders = Order.includes(:reward, :employee).order(status: :asc)
      orders = orders.filter_by_status(params[:status]) if params[:status]

      render :index, locals: { orders: }
    end

    def new
      @reward = Reward.find(params[:reward])
      if current_employee.number_of_earned_points < @reward.price
        flash[:alert] = 'You dont have enough points to buy a reward'
        redirect_to employees_rewards_path
      else
        @order = Order.new
        @order.build_address
      end
    end

    def create
      if params[:order].nil?
        reward = Reward.find(params[:reward])
        if current_employee.number_of_earned_points < reward.price
          flash[:alert] = 'You dont have enough points to buy a reward'
        else
          order = Order.new(employee: current_employee, reward:)
          order.price = order.reward.price
          order.save!
          current_employee.update!(number_of_earned_points: current_employee.number_of_earned_points - reward.price)
          flash[:notice] = 'You have successfully purchased a reward'
        end
        redirect_to employees_rewards_path

      else
        @reward = Reward.find(params[:order][:reward_id])
        if current_employee.number_of_earned_points < @reward.price
          flash[:alert] = 'You dont have enough points to buy a reward'
          redirect_to employees_rewards_path
        else
          @order = Order.new(order_params)
          @order.price = @reward.price
          @order.employee_id = current_employee.id
          @order.reward_data
          if @order.save
            current_employee.update!(number_of_earned_points: current_employee.number_of_earned_points - @reward.price)
            flash[:notice] = 'You have successfully purchased a reward'
            redirect_to employees_rewards_path
          else
            render :new
          end
        end
      end
    end

    def order_params
      params.require(:order).permit(:employee_id, :reward_id, :reward_data,
                                    address_attributes: %i[street postcode city])
    end
  end
end
