class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.staging? || Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "system/redactor_assets/pictures/#{model.id}"
  end

  def extension_white_list
    RedactorRails.image_file_types
  end
end
