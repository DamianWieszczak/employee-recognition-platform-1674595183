module Admins
  class RewardsController < AdminsController
    def index
      @pagy, @rewards = pagy(Reward.all, items: 3)
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

    def import_view; end

    def import
      return redirect_to request.referer, notice: 'No file added' if params[:file].nil?

      unless params[:file].content_type == 'text/csv'
        return redirect_to request.referer,
                           alert: 'Only CSV files allowed'
      end

      ImportCsvService.new.call(params[:file])
      redirect_to request.referer, notice: 'Import completed'
    rescue StandardError => e
      flash[:alert] = e.message
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :category_id, :image, :delivery_method)
    end
  end
end
