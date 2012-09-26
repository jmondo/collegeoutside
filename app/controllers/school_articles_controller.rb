class SchoolArticlesController < ApplicationController
  inherit_resources
  actions :index
  defaults class_name: "Article",
    collection_name: "articles",
    instance_name: "article"
  belongs_to :school

  helper_method :thumbnail_articles

  protected

  def thumbnail_articles
    # first featured, first sponsored article, second featured article,
    # fill others with regular articles, max 6
    @thumbnail_articles ||= [
      end_of_association_chain.featured.first,
      end_of_association_chain.sponsored.first,
      end_of_association_chain.featured.offset(1).first,
      end_of_association_chain.published_no_flags.limit(6)
    ].flatten.compact[0..5]
  end

  def collection
    @articles ||= end_of_association_chain.published
  end

end
