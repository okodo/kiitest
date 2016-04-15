class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    render 'layouts/application'
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
  end

end
