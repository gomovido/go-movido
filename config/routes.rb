Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, controllers: { sessions: "sessions", registrations: 'registrations'}

  devise_scope :user do
    get "/onboarding" => "registrations#new", as: "onboarding"
    post "/onboarding/:resource" => "registrations#create", as: 'registration'
  end

  root 'pages#home'


  get 'onboarding/simplicity/new-journey', to: 'user_preferences#new', as: 'new_user_preference'
  get 'onboarding/simplicity/my-services', to: 'carts#new', as: 'new_cart'
  get 'onboarding/simplicity/my-services/packs', to: 'packs#index', as: 'packs'
  get 'onboarding/starter-pack/:order_id/shipping', to: 'shippings#new', as: 'new_shipping'
  get 'onboarding/starter-pack/:order_id/pickup', to: 'pickups#new', as: 'new_pickup'

  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'

  get 'privacy', to: 'pages#privacy'
  get 'cookies', to: 'pages#cookies'
  get 'terms', to: 'pages#terms', as: 'terms'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'about', to: 'pages#about'


  get 'onboarding/starter-pack/:order_id/checkout', to: 'payments#new', as: 'checkout'
  post 'payments/:order_id', to: 'payments#create', as: 'payments'

  resources :leads, only: [:create]

  resources :orders do
    resources :payments, only: [:create, :new]
  end

  get 'congratulations/:order_id', to: 'orders#congratulations', as: 'congratulations'

end
