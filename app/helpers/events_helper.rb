module EventsHelper
  def sponsor_image(file_name)
    image_tag("sponsors/#{file_name}")
  end
end
