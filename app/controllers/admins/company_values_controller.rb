module Admins
  class CompanyValuesController < AdminsController
    
    def index
      @company_values = CompanyValue.all
    end

    def new
      @company_value = CompanyValue.new
    end

    def create
      @company_value = CompanyValue.new(company_value_params)
      if @company_value.save
        flash[:notice] = 'Company Value was successfully saved'
        redirect_to admins_company_values_path
      else
        flash[:alert] = 'Creating Company Value failed'
        render 'admins/company_values/new'
      end
    end

    def edit
      @company_value = CompanyValue.find(params[:id])
    end

    def update
      @company_value = CompanyValue.find(params[:id])
      if @company_value.update(company_value_params)
        flash[:notice] = 'Company Value was updated'
        redirect_to admins_company_values_path
      else
        flash[:alert] = 'Updating Company Value failed'
        render 'admins/company_value/edit'
      end
    end

    def destroy
      @company_value = CompanyValue.find(params[:id])
      if @company_value.destroy
        flash[:notice] = 'Company Value was successfully deleted'
        redirect_to admins_company_values_path
      else
        flash[:alert] = 'Deleting Company Value failed'
        redirect_to admins_company_values_path
      end
    end

    private

    def company_value_params
      params.require(:company_value).permit(:title)
    end

  end
end
