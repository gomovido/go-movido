Rails.application.routes.draw do
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
  get 'terms', to: 'pages#terms'
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

  resources :subscriptions, only: [:show ] do
    resources :people, only: [:new, :create, :update]
    resources :billings, only: [:new, :create, :update]
    resources :addresses, only: [:update, :edit]
  end

  resources :products, only: [:index]
  resources :addresses, only: [:create]

  post 'charge', to: 'charges#create'
  get 'subscriptions/modal/:id', to: 'subscriptions#modal', as: 'modal_subscription'
  post 'send-confirmed-email/:subscription_id', to: 'subscriptions#send_confirmed_email'
  get 'banks/modal/:id', to: 'banks#modal', as: 'modal_bank'

  resources :categories, only: [:index] do
    resources :banks, only: [:index]
    resources :products, only: [:index] do
      resources :subscriptions, only: [:create]
    end
  end

  resources :wifis, only: [:index]
  resources :mobiles, only: [:index]
  resources :banks, only: [:index]
  get 'wifis/modal/:id', to: 'wifis#modal', as: 'modal_wifi'
  get 'mobiles/modal/:id', to: 'mobiles#modal', as: 'modal_mobile'





















end
