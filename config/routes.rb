Rails.application.routes.draw do
  root :to => 'pages#landing'

  resources :tournaments

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'ligen' => "leagues#index", as: 'ligen'

  get 'pebble_settings' => 'pages#pebble_settings'

  resources :matches, only: [:show]
  get "/auth/:provider/callback" => "users#create"
  get '/auth/failure' => 'users#omniauth_failure'

  get 'imprint' => 'pages#imprint', as: 'imprint'
  get 'faq' => 'pages#faq', as: 'faq'

  get 'kpis' => 'pages#kpis', as: 'kpis'

  resources :widgets, module: 'chameleon'

  resources :leagues, except: [:index], :path => '' do
    get :badges, on: :member
    get :table, on: :member
    resources :matches do
      post :shuffle, on: :collection
      get :shuffle_select, on: :collection
    end
    resources :users
    resources :teams, only: [:index, :show]
  end

end
