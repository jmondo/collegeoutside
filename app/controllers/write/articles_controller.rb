module Write
  class ArticlesController < BaseController

    def show
      flash.keep
      redirect_to edit_resource_path
    end

    protected

    def build_resource
      article = super
      article.user = current_user
      article
    end
  end
end
