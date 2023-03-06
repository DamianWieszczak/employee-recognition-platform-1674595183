class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!

  def index
    @kudos = Kudo.all.order(created_at: :desc)
  end

  def show; end

  def new
    @kudo = Kudo.new
    if current_employee.number_of_available_kudos > 0
      render 'new'
    else
      flash[:alert] = 'You have no more kudos to give'
      redirect_to kudos_path
    end
  end

  def edit
    if current_employee == @kudo.giver
      render :edit
    else
      flash[:alert] = 'You are not authorized to perform this operation'
      redirect_to kudos_path
    end
  end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.giver_id = current_employee.id
    if @kudo.save
      @current_employee.number_of_available_kudos -= 1
      @current_employee.save!
      flash[:notice] = 'Kudo was successfully created'
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @kudo.update(kudo_params)
      flash[:notice] = 'Kudo was successfully updated'
      redirect_to @kudo
    else
      render :edit
    end
  end

  def destroy
    if current_employee == @kudo.giver
      @kudo.destroy
      if @kudo.destroy
        flash[:notice] = 'Kudo was successfully deleted'
      else
        flash[:alert] = 'Delete Kudo failed'
      end
    else
      flash[:alert] = 'You are not authorized to perform this operation'
    end
    redirect_to root_path
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
  end
end
