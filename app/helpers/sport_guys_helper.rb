module SportGuysHelper
  def sport_guy_link(activity_name)
    new_params = params.merge({activity: activity_name})
    link_to(sport_guy(activity_name), new_params)
  end

  def sport_guy(activity_name)
    active = (params[:activity] == activity_name)
    activity_name = activity_name.capitalize
    content_tag(:div, class: "sport-guy") do
      image_tag("sport-icons/#{activity_name}-Badge_Small.png", alt: "#{activity_name} Sport Badge") +
        (active ? "" : content_tag(:div, "", class: "sport-guy-opacity"))
    end
  end

  def mini_sport_guy(activity_name)
    activity_name_cap = activity_name.capitalize
    content_tag(:div, class: "sport-guy sport-guy-mini") do
      link_to image_tag("sport-icons/#{activity_name_cap}-Badge_Small.png", alt: "#{activity_name_cap} Sport Badge"), activity_articles_path(activity_name)
    end
  end
end
