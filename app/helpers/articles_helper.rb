module ArticlesHelper
  def additional_article_header(article)
    things = [link_to(@article.user.name, writer_articles_path(@article.user), class: 'link-incognito')]
    if @article.school
      things << link_to(@article.school.try(:name), school_articles_path(@article.school), class: 'link-incognito')
    end
    things << @article.published_at.stamp("January 23, 2011")
    things.compact.join(', ').html_safe
  end
end
