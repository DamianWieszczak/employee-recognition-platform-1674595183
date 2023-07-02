module Employees
  class KudosController < EmployeesController
    before_action :set_kudo, only: %i[show edit update destroy]
    before_action :authenticate_employee!

    def index
      @kudos = Kudo.includes(:company_value, :giver, :receiver).all.order(created_at: :desc)
    end

    def show; end

    def new
      @kudo = Kudo.new
      if current_employee.number_of_available_kudos.positive?
        render 'new'
      else
        flash[:alert] = 'You have no more kudos to give'
        redirect_to employees_kudos_path
      end
    end

    def edit
      authorize @kudo
      if current_employee == @kudo.giver
        render :edit
      else
        flash[:alert] = 'You are not authorized to perform this operation'
        redirect_to employees_kudos_path
      end
    end

    def create
      @kudo = Kudo.new(kudo_params)
      @kudo.giver_id = current_employee.id
      ActiveRecord::Base.transaction do
        @kudo.save!
        @current_employee.update!(number_of_available_kudos: @current_employee.number_of_available_kudos -= 1)
        @kudo.receiver.update!(number_of_earned_points: @kudo.receiver.number_of_earned_points += 10)
        flash[:notice] = 'Kudo was successfully created'
        redirect_to root_path
      rescue ActiveRecord::RecordInvalid
        render :new
      end
    end

    def update
      authorize @kudo
      if @kudo.update(kudo_params)
        flash[:notice] = 'Kudo was successfully updated'
        redirect_to employees_kudos_path(@kudo)
      elsif Time.current - kudo.created_at > 5.minutes
        flash[:notice] = 'The time to edit/delete kudo has passed'
        rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
        render :edit
      end
    end

    def destroy
      auhtorize @kudo
      if current_employee == @kudo.giver
        ActiveRecord::Base.transaction do
          @kudo.destroy!
          @kudo.receiver.update!(number_of_earned_points: @kudo.receiver.number_of_earned_points -= 10)
          flash[:notice] = 'Kudo was successfully deleted'
        rescue ActiveRecord::RecordInvalid
          flash[:alert] = 'Kudo deletion failed'
        end
      else
        flash[:alert] = 'You are not authorized to perform this operation'
      end
      redirect_to root_path
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
