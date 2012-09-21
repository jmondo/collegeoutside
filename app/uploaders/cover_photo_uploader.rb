# encoding: utf-8

class CoverPhotoUploader < BaseUploader

  version :small_cover do
    process resize_to_fill: [270, 192]
  end

  version :medium_cover do
    process resize_to_fill: [370, 263]
  end

  version :wide_cover do
    process resize_to_fill: [770, 263]
  end

  version :large_cover do
    process resize_to_fill: [870, 263]
  end

end
