class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  def access_denied(message = nil)
    flash[:notice] = message || "Access Denied"
    redirect_to root_path
    return false
  end
end
