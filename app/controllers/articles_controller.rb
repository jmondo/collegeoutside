class ArticlesController < ApplicationController
  inherit_resources
  helper_method :featured_articles, :sponsored_articles
  protected

  def collection
    @articles ||= end_of_association_chain.published_no_flags.page(params[:page]).per(8)
  end

  def featured_articles
    @featured_articles ||= end_of_association_chain.featured.page(params[:page]).per(1)
  end

  def sponsored_articles
    @sponsored_articles ||= end_of_association_chain.sponsored.page(params[:page]).per(1)
  end
end
