module SportGuysHelper
  def sport_guy(activity_name)
    activity_name = activity_name.titleize
    content_tag(:div, class: "sport-guy") do
      image_tag("sport-icons/#{activity_name}-Badge_Small.png", alt: "#{activity_name} Sport Badge") +
        content_tag(:div, "", class: "sport-guy-opacity")
    end
  end

  def mini_sport_guy(activity_name)
    activity_name = activity_name.titleize
    content_tag(:div, class: "sport-guy sport-guy-mini") do
      image_tag("sport-icons/#{activity_name}-Badge_Small.png", alt: "#{activity_name} Sport Badge")
    end
  end
end
