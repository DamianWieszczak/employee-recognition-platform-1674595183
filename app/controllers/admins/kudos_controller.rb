module Admins
  class KudosController < AdminsController
    before_action :set_kudo, only: [:destroy]

    def index
      @kudos = Kudo.all.order(created_at: :desc)
    end

    def destroy
      if @kudo.destroy
        flash[:notice] = 'Kudo was successfully deleted'
      else
        flash[:alert] = 'Delete Kudo failed'
      end
      redirect_to admins_kudos_path
    end

    private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end
  end
end
