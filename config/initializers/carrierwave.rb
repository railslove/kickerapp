CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      
    }
    config.fog_directory = "kicker-app-development"
    config.fog_public = true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{(60 * 60 * 24 * 30 * 6)}" } # ~6 months
  else
    #config.storage = :file
    config.storage = :fog
    config.fog_credentials = {
      
    }
    config.fog_directory = "kicker-app-development"
    config.fog_public = true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{(60 * 60 * 24 * 30 * 6)}" } # ~6 months
  end
end
