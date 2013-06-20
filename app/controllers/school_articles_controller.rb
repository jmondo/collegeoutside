class SchoolArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"
  belongs_to :school

  helper_method :map_json

  protected

  def collection
    @articles ||= end_of_association_chain.published.page(params[:page]).per(32)
  end

  def map_json
    @json ||= end_of_association_chain.to_gmaps4rails do |article, marker|
      marker.infowindow render_to_string(:partial => "/articles/gmaps_article", :locals => { :article => article })
    end
  end

end
