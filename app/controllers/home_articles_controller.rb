class HomeArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"

  protected

  def end_of_association_chain
    super.published.page(params[:page]).per(6)
  end
end
