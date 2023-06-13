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

    def edit_kudos_to_all
      @employees = Employee.all
      render 'admins/employees/add_kudos_to_all'
    end

    def add_kudos_to_all
      new_amount_of_kudos = amount_params
      if new_amount_of_kudos < 21
        Employee.transaction do
          Employee.find_each do |employee|
            employee.update!(number_of_available_kudos: employee.number_of_available_kudos + new_amount_of_kudos)
          end
          flash[:notice] = 'Successfully added the specified amount of kudos for each employee'
          redirect_to admins_dashboard_path

        rescue ActiveRecord::RecordInvalid
          flash[:alert] = "It's possible to only add kudos from 1 to 20 for each employee"
          render 'add_kudos_to_all'
        end
      else
        flash[:alert] = "It's possible to only add kudos from 1 to 20 for each employee"
        render 'add_kudos_to_all'
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
      params.require(:employee).permit(:email, :password, :number_of_available_kudos)
    end

    def amount_params
      params[:amount].to_i
    end
  end
end
