# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'WoAV7LzkMU724xNt2k1jQ', '2gKDkeQDsRd0XO0VOMdhGhC1TWAyWfwB8smjcEF8'
  provider :facebook, '454715457990828', 'fdb9aab3f085ff7593ced74ae41c1002', client_options: {
    site: 'https://graph.facebook.com/v2.8',
    authorize_url: 'https://www.facebook.com/v2.8/dialog/oauth'
  }
end
