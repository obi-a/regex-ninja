class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action {
    @current_page = if params[:controller] == "devise/registrations"
      :signup
    elsif params[:controller] == "devise/sessions"
      :signin
    end
  }
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  private

  def configure_devise_permitted_parameters
    registration_params = [:email, :display_name, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end
end
