# frozen_string_literal: true

unless Rails.env.test?
  Dir[Rails.root.join('app', 'notifications', 'subscriptions', '*.rb')].each do |path|
    subscription_classname = File.basename(path, '.rb').camelize
    "Subscriptions::#{subscription_classname}".constantize.new.subscribe!
  end
end
