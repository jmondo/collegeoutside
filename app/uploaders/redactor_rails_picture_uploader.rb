# encoding: utf-8
class RedactorRailsPictureUploader < BaseUploader
  include RedactorRails::Backend::CarrierWave

  process :read_dimensions
  process resize_to_limit: [640, 480]

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [270, 192]
  end

  version :content do
    process resize_to_limit: [340,340]
  end
end
