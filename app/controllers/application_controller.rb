# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?

  def pundit_user
    current_employee
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name email password current_password])
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to root_path
  end
end
