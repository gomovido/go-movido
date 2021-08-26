Rails.application.routes.draw do
  get 'user_marketings/unsubscribe'
  # Forest Admin
  mount ForestLiana::Engine => '/forest'

  # Devise
  devise_for :users, controllers: { sessions: "sessions", registrations: 'registrations'}
  devise_scope :user do
    get "/onboarding/starter-pack" => "registrations#new_starter", as: "onboarding_starter_pack"
    get "/onboarding/settle-in-pack" => "registrations#new_settle_in", as: "onboarding_settle_in"
    post "/onboarding/:resource" => "registrations#create", as: 'registration'
  end

  # Update Password
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end


  #Unsubscribe email
  get 'unsubscribe/confimation/:user_id', to: 'user_marketings#unsubscribe_confimation', as: 'unsubscribe_confirmation'
  put 'unsubscribe/:user_id', to: 'user_marketings#unsubscribe', as: 'unsubscribe'


  # Onboarding
  get 'onboarding/new-journey/:pack', to: 'houses#new', as: 'new_house'
  get 'onboarding/my-services/:pack', to: 'carts#new', as: 'new_cart'
  get 'onboarding/my-services/packs/:order_id', to: 'packs#index', as: 'packs'
  get 'onboarding/starter-pack/:order_id/shipping', to: 'shippings#new', as: 'new_shipping'
  get 'onboarding/starter-pack/:order_id/pickup', to: 'pickups#new', as: 'new_pickup'
  get 'onboarding/:order_id/checkout', to: 'payments#new', as: 'checkout'
  post 'payments/:order_id', to: 'payments#create', as: 'payments'
  get 'congratulations/:order_id', to: 'orders#congratulations', as: 'congratulations'
  get 'congratulations/starter/:order_id', to: 'orders#starter', as: 'starter_congratulations'
  get 'congratulations/settle-in/:order_id', to: 'orders#settle_in', as: 'settle_in_congratulations'
  get 'onboarding/legal/subscriptions/:order_id', to: 'subscriptions#new', as: 'new_subscription'


  put 'cancel-subscription/:order_id', to: 'subscriptions#cancel', as: 'cancel_subscription'

  # Dashboard
  get 'dashboard', to: 'dashboards#index', as: 'dashboard'
  get 'dashboard/profile', to: 'users#profile', as: 'update_profile'
  put 'dashboard/profile/update', to: 'users#update', as: 'dashboard_update_profile'
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
  get 'pricing/starter-pack', to: 'pages#starter_pack', as: "pricing_starter_pack"
  get 'pricing/settle-in-pack', to: 'pages#settle_in', as: "pricing_settle_in"
  get 'thankyou', to: 'pages#thank_you', as: 'thank_you'
  get 'home', to:"pages#home"

  # Generate invoice
  get 'dashboard/invoice/:order_id', to: 'orders#invoice', as: 'invoice'

 # Temporary route for dashboard new components integration
 get 'new_dashboard', to: 'pages#new_dashboard'

  # Lead generation
  resources :leads, only: [:create]

end
