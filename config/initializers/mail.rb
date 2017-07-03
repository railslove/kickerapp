ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :user_name => 'railslove',
    :password  => Rails.application.secrets.mandrill_key,
    :domain    => 'railslove.com'
  }
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = ENV['MANDRILL_KEY'] || Rails.application.secrets.mandrill_key
  config.deliver_later_queue_name = :default
end
