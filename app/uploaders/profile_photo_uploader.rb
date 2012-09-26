# encoding: utf-8

class ProfilePhotoUploader < BaseUploader

  version :thumb do
    process resize_to_fill: [60, 60]
  end

  version :medium do
    process resize_to_fill: [150, 150]
  end

end
