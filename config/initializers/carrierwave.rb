CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => ENV["aws_access_key"],
      :aws_secret_access_key  => ENV["aws_secret_key"]
    }
    config.fog_directory  = "collegeoutside-#{Rails.env}"
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
