module SportGuysHelper
  def sport_guy(activity_name)
    content_tag(:div, class: "sport-guy") do
      image_tag("sport-icons/#{activity_name}-Badge_Small.png", alt: "#{activity_name} Sport Badge") +
        content_tag(:div, "", class: "sport-guy-opacity")
    end
  end
end
