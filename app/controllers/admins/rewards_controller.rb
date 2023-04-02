module Admins
  class RewardsController < AdminsController
    def index
      @rewards = Reward.all
    end

    def new
      @reward = Reward.new
    end

    def create
      @reward = Reward.new(reward_params)
      if @reward.save
        flash[:notice] = 'Reward was successfully saved'
        redirect_to admins_rewards_path
      else
        flash[:alert] = 'Creating Reward failed'
        render 'admins/rewards/new'
      end
    end

    def edit
      @reward = Reward.find(params[:id])
    end

    def update
      @reward = Reward.find(params[:id])
      if @reward.update(reward_params)
        flash[:notice] = 'Reward was updated'
        redirect_to admins_rewards_path
      else
        flash[:alert] = 'Updating Reward failed'
        render 'admins/rewards/edit'
      end
    end

    def destroy
      @reward = Reward.find(params[:id])
      if @reward.destroy
        flash[:notice] = 'Reward was successfully deleted'
      else
        flash[:alert] = 'Deleting Reward failed'
      end
      redirect_to admins_rewards_path
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price)
    end
  end
end
