class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name name description])
  end
end
