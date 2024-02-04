module Admins
  class OnlineCodesController < AdminsController
    def index
      online_codes = OnlineCode.all
      render :index, locals: { online_codes: }
    end

    def new
      online_code = OnlineCode.new
      render :new, locals: { online_code: }
    end
    
    def create
      online_code = OnlineCode.new(online_code_params)
      if online_code.save
        redirect_to admins_online_codes_path, notice: 'Online code created'
      else
        render new:, locals: { online_code: }
        flash[:alert] = 'Something went wrong with creating Online Code. Try again later'
      end
    end

    def update
      if online_code.update(online_code_params)
        redirect_to admin_rewards_path, nitce: 'Reward was successfully update'
      else
        render :edit, locals: { reward: online_code }
      end
    end

    def destroy
      if online_code.destroy
        flash[:notice] = 'Online Code was succesfully destroyed'
      else
        flash[:alert] = 'Delete Online Code failed'
      end
      redirect_to admin_rewards_path, notice: 'Rewards code was succesfully destroyed'
    end

    def import_online_codes; end

    def import
      return redirect_to request.referer, notice: 'No file added' if params[:file].nil?

      unless params[:file].content_type == 'text/csv'
        return redirect_to request.referer,
                           notice: 'Only CSV files allowed'
      end

      ImportOnlineCodesService.new.call(params[:file])
      redirect_to request.referer, notice: 'Import completed'
    rescue StandardError => e
      redirect_to request.referer, notice: e.message
    end

    private

    def online_code_params
      params.require(:online_code).permit(:code, :reward_id, :used)
    end
  end
end
