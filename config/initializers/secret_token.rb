# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Kickerapp::Application.config.secret_key_base = 'c0e09f03a12789a1636521f3b2e2ad877d83001d6d339e97c8902189ae910ba440e17857d4adf6fd18289fd3981a386efc20e7e16de73c3c4416f016a6108e57'
