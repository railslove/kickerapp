CarrierWave.configure do |config|
  if Rails.env.production? && ENV["AWS_ACCESS_KEY"].present?
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      region: ENV["AWS_REGION"],
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_ACCESS_KEY"]
      }
    config.fog_directory = ENV['AWS_BUCKET']
    config.fog_public = true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{(60 * 60 * 24 * 30 * 6)}" } # ~6 months
  else
    config.storage = :file
  end
end
