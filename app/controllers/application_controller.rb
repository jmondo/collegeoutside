class ApplicationController < ActionController::Base
  protect_from_forgery

  def access_denied(message = nil)
    flash[:notice] = message || "Access Denied"
    redirect_to root_path
    return false
  end

end
