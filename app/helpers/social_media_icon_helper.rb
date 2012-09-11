module SocialMediaIconHelper
  LINKS = {
    facebook: 'http://facebook.com/collegeoutside',
    twitter: 'http://twitter.com/collegeoutside',
    linkedin: 'http://linkedin.com/company/2433460',
    vimeo: 'http://vimeo.com/collegeoutside'
  }.with_indifferent_access

  def social_media_icon(network)
    link_to image_tag("social/#{network}_32.png"), LINKS[network], class: "social-media-button"
  end
end
