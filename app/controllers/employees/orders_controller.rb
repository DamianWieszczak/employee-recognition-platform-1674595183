module Employees
  class OrdersController < EmployeesController
    def index
      render :index, locals: { orders: Order.all }
    end
    
    def create
      reward = Reward.find(params[:reward])
      if current_employee.number_of_earned_points < reward.price
        flash[:alert] = 'You dont have enough points to buy a reward'
        redirect_to employees_rewards_path
      else
        ActiveRecord::Base.transaction do
          order = Order.new(employee: current_employee, reward: reward)
          order.save!
          current_employee.update!(number_of_earned_points: current_employee.number_of_earned_points - reward.price)
          flash[:notice] = 'You have successfully purchased a reward'
          redirect_to employees_rewards_path
        rescue ActiveRecord::RecordInvalid
          flash[:alert] = 'Something went wrong with your process'
          redirect_to employees_rewards_path
        end
      end
    end
  end
end
