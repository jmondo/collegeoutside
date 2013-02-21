module EventsHelper
  def sponsor_link(sponsor_name, file_name, url)
    link_to image_tag("sponsors/#{file_name}", :class => "sponsor_link_image #{sponsor_name}", :alt => "#{sponsor_name} logo"), url
  end
end
