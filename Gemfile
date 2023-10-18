# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.9'

# wellknown
gem 'breakpoint'
gem 'carrierwave'
gem 'coffee-rails'
gem 'compass-rails'
gem 'fog', '1.41.0' # 1.42. depends on a newer version of json which breaks mandrill-mailer
gem 'graphql'
gem 'gravatar_image_tag'
gem 'haml-rails'
gem 'i18n-js'
gem 'jbuilder'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'mobile-fu'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'pg', '~> 0.18'
gem 'puma'
gem 'rack-cors', require: 'rack/cors'
gem 'rack-tracker'
gem 'rails', '~> 5.1', '>= 5.1.4'
gem 'rails-i18n'
gem 'rails_admin'
gem 'react-rails'
gem 'redcarpet'
gem 'sass-rails'
gem 'sprockets', '>= 3.7.2'
gem 'uglifier'
gem 'webpacker', '~> 3.0'

gem 'sentry-raven'
# gem 'quiet_assets' Doesn't work anymore
gem 'mandrill_mailer'
gem 'pebble_timeline'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'faker', '~> 1.8', '>= 1.8.7'
  gem 'fontello_rails_converter'
  gem 'graphiql-rails'
  gem 'listen'
  gem 'rubocop'
  gem 'smurfville'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'jazz_fingers'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
end
