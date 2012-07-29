module Write
  class BaseController < ApplicationController
    inherit_resources
    load_and_authorize_resource
    before_filter :authorize_writer!
    layout 'write'

    protected

    def authorize_writer!
      authorize! :show, :writer_dashboard
    end

    def role_given?
      true
    end

    def as_role
      { as: (self.resources_configuration[:self][:role] || current_user.role.to_sym) }
    end
  end
end
