Airbrake.configure do |config|
  config.project_id = ENV['AIRBRAKE_PROJECT_ID'] || ''
  config.project_key = ENV['AIRBAKE_PROJECT_KEY'] || ''
  # config.development_environments = [] # enable this if you ever want to send exceptions to Airbrake in development mode
end
