source 'https://rubygems.org'

ruby '2.6.5'

# wellknown
gem 'breakpoint'
gem 'carrierwave'
gem 'coffee-rails'
gem 'fog', '1.41.0' # 1.42. depends on a newer version of json which breaks mandrill-mailer
gem 'gravatar_image_tag'
gem 'haml-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'mobile-fu'
gem 'newrelic_rpm'
gem 'pg', '~> 1'
gem 'puma'
gem 'rack-tracker'
gem 'rails_admin', '~> 2'
gem 'rails-i18n'
gem 'rails', '~> 6'
gem 'redcarpet'
gem 'sass-rails', '~> 6'
gem 'uglifier'
gem "compass-rails"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem 'tzinfo-data'

gem "omniauth"
gem "react-rails"
gem 'webpacker', '~> 4.0'
gem 'i18n-js'
gem 'graphql'
gem 'rack-cors', require: 'rack/cors'
gem "sprockets", "~> 4.0"

gem 'sentry-raven'
# gem 'quiet_assets' Doesn't work anymore
gem 'pebble_timeline'
gem 'mandrill_mailer'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'smurfville'
  gem 'fontello_rails_converter'
  gem 'listen'
  gem 'graphiql-rails'
  gem 'faker', '~> 1.8', '>= 1.8.7'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'jazz_fingers'
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'rails-controller-testing'
end

group :production do
  gem 'rails_12factor'
end
