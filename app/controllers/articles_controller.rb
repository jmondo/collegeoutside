class ArticlesController < ApplicationController
  inherit_resources
  helper_method :featured_articles, :sponsored_articles
  helper_method :activity_sponsors, :recent_articles_by_user, :recent_articles_by_school, :recent_articles_by_activity

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
    @activity_sponsors ||= resource.activity_sponsors.limit(2)
  end

  def recent_articles_by_user
    @recent_articles_by_user ||= Article.recent_by_user(resource.user).limit(10)
  end

  def recent_articles_by_school
    @recent_articles_by_school ||= Article.recent_by_school(resource.school).limit(10)
  end

  def recent_articles_by_activity
    @recent_articles_by_activity ||= Article.recent_by_activities(resource.activities).limit(10)
  end
end
