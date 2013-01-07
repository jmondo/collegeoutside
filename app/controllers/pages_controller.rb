class PagesController < ApplicationController

  def index
  end

  def map
    @json = Article.published.to_gmaps4rails do |article, marker|
      marker.infowindow render_to_string(:partial => "/articles/gmaps_article", :locals => { :article => article })
    end
  end

end
