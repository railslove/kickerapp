source 'https://rubygems.org'

ruby '1.9.3'

gem 'airbrake'
gem 'coffee-rails'
gem 'compass-rails', github: 'milgner/compass-rails', branch: 'rails4'
gem 'jquery-rails'
gem 'pg'
gem 'rails', '>= 4.0.0'
gem 'quiet_assets'
gem 'sass-rails'
gem 'newrelic_rpm'
gem 'haml-rails'
gem 'uglifier'
gem 'kaminari'

gem "omniauth"
gem "omniauth-twitter"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'smurfville'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '>= 2.14'
end

group :test do
  gem 'capybara-webkit', '>= 1.0.0'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'timecop'
end

group :deploy do
  gem "capistrano"
  gem "capistrano-ext"
end
