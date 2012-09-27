# encoding: utf-8

class ProfilePhotoUploader < BaseUploader

  version :thumb do
    process resize_to_fill: [60, 60]
  end

  version :medium do
    process resize_to_fill: [170, 170]
  end

end

# User.all.each do |u|
#   u.photo.recreate_versions! if u.photo.present?
# end
