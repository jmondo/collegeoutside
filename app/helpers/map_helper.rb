module MapHelper
  def map_thumbnail(article)
    link_to image_tag(article.cover_photo.small_cover, :align => :left, :class => "map_thumbnail_image"), article
  end
end
