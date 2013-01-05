class HomeArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"

  protected

  def end_of_association_chain
    super.published
  end

  def search
    search_params = {}
    search_params[:region_name_in] = [params[:region], 'anywhere'] if params[:region]
    search_params[:activities_name_eq] = params[:activity] if params[:activity]
    end_of_association_chain.search(search_params)
  end

  def collection
    featured = search.result.featured.limit(2)
    normal = search.result.not_featured.limit(6-featured.count)
    @articles ||= featured + normal
  end
end
