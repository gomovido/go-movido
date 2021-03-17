Rails.application.routes.draw do
  namespace :forest do
    post '/actions/create-mobile-features-translations' => 'mobiles#create_features_translations'
    post '/actions/create-mobile-offers-translations' => 'mobiles#create_offers_translations'
    post '/actions/create-wifi-features-translations' => 'wifis#create_features_translations'
    post '/actions/create-wifi-offers-translations' => 'wifis#create_offers_translations'
    post '/actions/activate-subscription' => 'subscriptions#activate_subscription'
    post '/actions/upload-legal-docs' => 'companies#upload_legal_docs'
  end
  mount ForestLiana::Engine => '/forest'
  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  devise_scope :user do
    get '/users', to: 'registrations#new'
    get '/users', to: 'registrations#edit'
  end
  unauthenticated :user do
    root 'pages#home'
  end
  authenticated :user do
    root 'categories#index', as: 'dashboard_index'
  end

  #Errors pages
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'

  get 'privacy', to: 'pages#privacy'
  get 'cookies', to: 'pages#cookies'
  get 'contact', to: 'pages#contact'
  get 'terms', to: 'pages#terms', as: 'terms'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'about', to: 'pages#about'
  get 'careers', to: 'pages#careers'
  get 'faq', to: 'pages#faq'
  get 'summary/:subscription_id', to: 'subscriptions#summary', as: 'subscription_summary'
  get 'payment/:subscription_id', to: 'charges#new', as: 'subscription_payment'
  patch 'validate_subscription/:subscription_id', to: 'subscriptions#validate_subscription', as: 'validate_subscription'
  get 'congratulations/:subscription_id', to: 'subscriptions#congratulations', as: 'subscription_congratulations'
  post 'abort-subscription/:subscription_id', to: 'subscriptions#abort_subscription', as: 'abort_subscription'
  get 'services/wifi', to: 'services#wifi'
  get 'services/bank', to: 'services#bank'
  get 'services/mobile', to: 'services#mobile'
  get 'services/real_estate', to: 'services#real_estate'

  resources :services, only: [:index]
  resources :users, only: [:show, :update] do
    resources :addresses, only: [:create, :new]
  end

  resources :wifis, only: [:index]
  resources :mobiles, only: [:index]
  resources :banks, only: [:index]
  get 'wifis/modal/:id', to: 'wifis#modal', as: 'modal_wifi'
  get 'mobiles/modal/:id', to: 'mobiles#modal', as: 'modal_mobile'
  get 'banks/modal/:id', to: 'banks#modal', as: 'modal_bank'


  resources :subscriptions do
    resources :people, only: [:new, :create, :update]
    resources :billings, only: [:new, :create, :update]
    resources :addresses, only: [:update, :edit]
  end

  resources :subscriptions, only: [:create]

  resources :addresses, only: [:create]

  post 'charge', to: 'charges#create'
  get 'subscriptions/modal/:id', to: 'subscriptions#modal', as: 'modal_subscription'

  get 'real-estate', to: 'flats#landing', as: 'real_estate_landing'

  post 'search-flats', to: 'flats#search', as: 'search_flats'
  get 'flats/:location/:type', to: 'flats#index', as: 'flats_index'
  get 'providers-index/:query', to: 'providers#index', as: 'providers'

end
