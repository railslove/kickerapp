RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'kicker' && password == 'loveisallaround'
    end
  end

  # config.included_models = %w{
  #   Match User Team League
  # }

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
