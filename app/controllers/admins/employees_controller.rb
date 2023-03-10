module Admins
  class EmployeesController < AdminsController
    def index
      @employees = Employee.all.order(created_at: :desc)
    end

    def edit
      @employee = Employee.find(params[:id])
    end

    def update
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash[:notice] = 'Employee account was successfully updated'
        redirect_to admins_employees_path
      else
        render 'admins/employees/edit'
      end
    end

    def destroy
      @employee = Employee.find(params[:id])
      if @employee.destroy
        flash[:notice] = 'Employee acoount was successfully deleted'
      else
        flash[:alert] = 'Delete Employee account failed'
      end
      redirect_to admins_employees_path
    end

    private

    def employee_params
      params.require(:employee).permit(:email, :number_of_available_kudos)
    end
  end
end
