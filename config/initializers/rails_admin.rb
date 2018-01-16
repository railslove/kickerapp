RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'kicker' && password == (ENV['ADMIN_PASS'] || 'secret_password')
    end
  end

  config.model League do
    field :name
    field :slug
    field :contact_email
    field :created_at do
      pretty_value do
        I18n.l(bindings[:object].created_at, format: '%Y/%m/%d')
      end
    end

    field :updated_at do
      pretty_value do
        date = bindings[:object].matches.try(:first).try(:date) || bindings[:object].updated_at
        I18n.l(date, format: '%Y/%m/%d')
      end
    end
    field :header_image, :carrierwave
    list do
      field :name
      field :slug
      field :contact_email do
        pretty_value do
          bindings[:object].contact_email.split('@').last
        end
      end
      field :matches_count
      field :users do
        pretty_value do
          bindings[:object].users.count
        end
      end
    end
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
