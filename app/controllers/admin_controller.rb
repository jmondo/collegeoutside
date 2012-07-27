class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_editor_in_chief_access!

  protected

  def verify_editor_in_chief_access!
    unless current_user.chief?
      access_denied
    end
  end
end
