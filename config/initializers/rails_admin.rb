RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'kicker' && password == (ENV['ADMIN_PASS'] || 'secret_password')
    end
  end

  config.model League do
    field :name
    field :slug
    field :created_at
    field :users
    field :contact_email
    field :matches_count
    field :updated_at
    field :header_image, :carrierwave
  end

  config.model Match do
    field :date
    field :winner_team
    field :loser_team
    field :league
    field :score
    field :difference
    field :crawling
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
