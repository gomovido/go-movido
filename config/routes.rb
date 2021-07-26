Rails.application.routes.draw do
  # Forest Admin
  mount ForestLiana::Engine => '/forest'

  # Devise
  devise_for :users, controllers: { sessions: "sessions", registrations: 'registrations'}
  devise_scope :user do
    get "/onboarding" => "registrations#new", as: "onboarding"
    post "/onboarding/:resource" => "registrations#create", as: 'registration'
  end

  # Update Passoword
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end


  #landing
  get 'homepage2', to: 'pages#homepage_2'
  get 'homepage3', to: 'pages#homepage_3'
  get 'homepage4', to: 'pages#homepage_4'
  get 'homepage5', to: 'pages#homepage_5'
  get 'homepage6', to: 'pages#homepage_6'
  get 'homepage7', to: 'pages#homepage_7'


  # Onboarding
  get 'onboarding/new-journey', to: 'houses#new', as: 'new_house'
  get 'onboarding/my-services', to: 'carts#new', as: 'new_cart'
  get 'onboarding/my-services/packs/:order_id', to: 'packs#index', as: 'packs'
  get 'onboarding/starter-pack/:order_id/shipping', to: 'shippings#new', as: 'new_shipping'
  get 'onboarding/starter-pack/:order_id/pickup', to: 'pickups#new', as: 'new_pickup'
  get 'onboarding/starter-pack/:order_id/checkout', to: 'payments#new', as: 'checkout'
  post 'payments/:order_id', to: 'payments#create', as: 'payments'
  get 'congratulations/:order_id', to: 'orders#congratulations', as: 'congratulations'

  # Dashboard
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'

  # HTTP errors
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'

  # Static pages
  root 'pages#home'
  get 'privacy', to: 'pages#privacy', as: 'privacy'
  get 'cookies', to: 'pages#cookies'
  get 'terms', to: 'pages#terms', as: 'terms'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'about', to: 'pages#about'
  get 'pricing', to: 'pages#pricing', as: "pricing"
  get 'thankyou', to: 'pages#thank_you', as: 'thankyou'

  # Lead generation
  resources :leads, only: [:create]

end
