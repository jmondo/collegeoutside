# encoding: utf-8

class CoverPhotoUploader < BaseUploader

  process resize_to_fill: [270, 192]

end
