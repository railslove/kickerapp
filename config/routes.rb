Kickerapp::Application.routes.draw do
  resources :matches
  resources :users

  get "/auth/:provider/callback" => "users#create"
  root :to => 'matches#index'
end
