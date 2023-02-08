class KudosController < ApplicationController
  before_action :set_kudo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  def index
    @kudos = Kudo.all
  end

  def show
  end

  def new
    @kudo = Kudo.new
  end

  def edit; end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.giver_id = current_employee.id
    if @kudo.save
      flash[:notice] = 'Kudo was successfully created'
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @kudo.update(kudo_params)
      flash[:notice] = "Kudo was successfully updated"
      redirect_to @kudo
    else
      render :edit
    end
  end

  def destroy
    @kudo.destroy
    if @kudo.destroy
      flash[:notice] = "Kudo was successfully deleted"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong delete operation, please try again"
      redirect_to root_path
    end
  end

  private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
    end
end
