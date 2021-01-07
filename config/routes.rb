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
    root 'pages#dashboard_index', as: 'dashboard_index'
  end

  get 'privacy', to: 'pages#privacy'
  get 'cookies', to: 'pages#cookies'
  get 'terms', to: 'pages#terms'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'careers', to: 'pages#careers'
  get 'faq', to: 'pages#faq'
  get 'summary/:subscription_id', to: 'subscriptions#summary', as: 'subscription_summary'
  get 'payment/:subscription_id', to: 'charges#new', as: 'subscription_payment'
  patch 'validate_subscription/:subscription_id', to: 'subscriptions#validate_subscription', as: 'validate_subscription'
  get 'congratulations/:subscription_id', to: 'subscriptions#congratulations', as: 'subscription_congratulations'

  get 'services/wifi', to: 'services#wifi'
  get 'services/bank', to: 'services#bank'
  get 'services/mobile', to: 'services#mobile'
  get 'services/real_estate', to: 'services#real_estate'
  resources :users, only: [:show, :update] do
    resources :addresses, only: [:create, :new]
  end

  resources :subscriptions, only: [:show ] do
    get 'complete-profil', to: 'users#complete_profil'
    resources :billings, only: [:new, :create]
    resources :addresses, only: [:update, :edit]
  end

  resources :products, only: [:index]
  resources :addresses, only: [:create]

  post 'charge', to: 'charges#create'
  get 'products/modal/:id', to: 'products#modal', as: 'modal_product'
  get 'subscriptions/modal/:id', to: 'subscriptions#modal', as: 'modal_subscription'

  post 'create-products', to: 'products#create_from_forest_admin'

  resources :categories, only: [:index] do
    resources :banks, only: [:index]
    resources :products, only: [:index] do
      resources :subscriptions, only: [:create]
    end
  end
end
