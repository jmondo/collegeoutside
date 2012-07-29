module Write
  class BaseController < ApplicationController
    before_filter :authorize_writer!
    layout 'write'

    protected

    def authorize_writer!
      raise CanCan::AccessDenied unless current_user.writer?
    end
  end
end
