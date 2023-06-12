class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[first_name last_name]
  end
end
