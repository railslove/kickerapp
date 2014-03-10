Kickerapp::Application.routes.draw do
  resources :leagues, :path => '' do
    get :badges, on: :member
    resources :matches do
      post :shuffle, on: :collection
      get :shuffle_select, on: :collection
    end
    resources :users
    resources :teams, only: [:index]
  end

  resources :matches, only: [:show]
  get "/auth/:provider/callback" => "users#create"
  root :to => 'leagues#index'
end
