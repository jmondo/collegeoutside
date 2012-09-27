class HomeArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"

  protected

  def end_of_association_chain
    super.published_no_flags
  end

  def search
    end_of_association_chain.search(params)
  end

  def collection
    @articles ||= search.result.page(params[:page]).per(6)
  end
end
