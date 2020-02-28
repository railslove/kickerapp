# frozen_string_literal: true

def set_omniauth(opts = {})
  default = {
    provider: :facebook,
    uuid: '1234',
    facebook: {
      name: 'Karl Facebook',
      email: 'karl.facebook@example.com',
      image: 'http://example.com/facebook/....'
    },
    twitter: {
      name: 'Karl Twitter',
      email: 'karl.twitter@example.com',
      image: 'http://example.com/twitter....'
    }
  }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(provider: credentials[:provider],
                                                               uid: credentials[:uuid],
                                                               info: {
                                                                 name: user_hash[:name],
                                                                 email: user_hash[:email],
                                                                 image: user_hash[:image]
                                                               })
end

def set_invalid_omniauth(opts = {})
  credentials = { provider: :facebook,
                  invalid: :invalid_crendentials }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
end
