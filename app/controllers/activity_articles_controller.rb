class ActivityArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"
  belongs_to :activity

  helper_method :thumbnail_articles

  protected

  def thumbnail_articles
    unless @thumbnail_articles
      # first featured, first sponsored article, second featured article,
      # fill others with regular articles, max 18
      feature = end_of_association_chain.featured.limit(1)
      sponsor = end_of_association_chain.sponsored.limit(1)
      feature2 = end_of_association_chain.featured.offset(1).first
      special_articles = [feature, sponsor, feature2].flatten.compact
      qty_normal = 18 - special_articles.count
      normal_articles = end_of_association_chain.published.limit(qty_normal)
      @thumbnail_articles ||= special_articles + normal_articles
    end
    @thumbnail_articles
  end

  def collection
    @articles ||= end_of_association_chain.published_no_flags
  end

end
