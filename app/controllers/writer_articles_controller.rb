class WriterArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"

  belongs_to :user,
    param: 'writer_id'

  protected

  def collection
    @articles ||= end_of_association_chain.published.no_school.page(params[:page]).per(6)
  end

end
