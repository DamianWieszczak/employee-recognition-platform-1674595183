module Employees
  class RewardsController < EmployeesController
    def index
      @pagy, @rewards = pagy(Reward.includes(:category).all, items: 3)
    end

    def show
      @reward = Reward.find(params[:id])
    end
    
    def edit
      @reward = Reward.find(params[:id])
    end

    def update
      @reward = Reward.find(params[:id])
      if @reward.update(reward_params)
        flash[:notice] = 'Reward was updated'
        redirect_to employees_rewards_path
      else
        flash[:alert] = 'Updating Reward failed'
        render :edit
      end
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :category_id, :image, :delivery_method)
    end
  end
end
