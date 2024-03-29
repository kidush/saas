class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_mailer_host

  # helper ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def authenticate_inviter!
     unless current_user.has_role? :app_manager
       redirect_to root_url,  :alert => "Accesso non consentito"
     end
  end

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :subdomain
    devise_parameter_sanitizer.for(:invite) << :subdomain
  end

end
