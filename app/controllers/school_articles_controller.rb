class SchoolArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"
  belongs_to :school

  helper_method :featured_article

  protected

  def featured_article
    @featured_article ||= @school.articles.featured.first || @school.articles.published.first
  end
end
