module Employees
class RewardsController < EmployeesController
  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end

  private

  def set_reward
    params.require(:reward).permit(:title, :description, :price)
  end
end
end
