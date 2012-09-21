class ArticlesController < ApplicationController
  inherit_resources
  helper_method :featured_articles, :sponsored_articles, :activity_sponsors
  protected

  # collection stuff
  def collection
    @articles ||= end_of_association_chain.published_no_flags.page(params[:page]).per(8)
  end

  def featured_articles
    @featured_articles ||= end_of_association_chain.featured.page(params[:page]).per(1)
  end

  def sponsored_articles
    @sponsored_articles ||= end_of_association_chain.sponsored.page(params[:page]).per(1)
  end

  # resource stuff
  def activity_sponsors
    @activity_sponsors ||= resource.activity_sponsors
  end
end
