# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  # mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  post '/graphql', to: 'graphql#execute'
  root to: 'pages#landing'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'ligen' => 'leagues#index', as: 'ligen'

  get 'pebble_settings' => 'settings#pebble'
  get 'freckle_settings' => 'settings#freckle'
  resources :matches, only: [:show]
  get '/auth/:provider/callback' => 'users#create'
  get '/auth/failure' => 'users#omniauth_failure'

  get 'imprint' => 'pages#imprint', as: 'imprint'
  get 'faq' => 'pages#faq', as: 'faq'
  get 'privacy_policy' => 'pages#privacy_policy', as: 'privacy_policy'

  get 'kpis' => 'pages#kpis', as: 'kpis'

  resources :leagues, except: [:index], path: '' do
    get :badges, on: :member
    get :table, on: :member
    resources :matches do
      post :shuffle, on: :collection
      get :shuffle_select, on: :collection
    end
    resources :users
    resources :teams, only: %i[index show]
  end
end
