class ArticlesController < ApplicationController
  inherit_resources
  helper_method :featured_article, :sponsored_article
  helper_method :activity_sponsors, :recent_articles_by_user, :recent_articles_by_school, :recent_articles_by_activity

  protected

  # collection stuff

  def collection
    @articles ||= end_of_association_chain.no_school.published_no_flags.page(params[:page]).per(28)
  end

  def featured_article
    @featured_articles ||= end_of_association_chain.no_school.featured.page(params[:page]).per(1).first
  end

  def sponsored_article
    @sponsored_articles ||= end_of_association_chain.no_school.sponsored.page(params[:page]).per(1).first
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
