module Admins
  class KudosController < AdminsController
    def index
      @kudos = Kudo.all.order(created_at: :desc)
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      if @kudo.destroy
        flash[:notice] = 'Kudo was successfully deleted'
      else
        flash[:alert] = 'Delete Kudo failed'
      end
      redirect_to admins_kudos_path
    end
  end
end
