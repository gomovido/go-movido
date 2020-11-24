Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations"}
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
  get 'summary/:subscription_id', to: 'subscriptions#summary', as: 'subscription_summary'
  get 'payment/:subscription_id', to: 'subscriptions#payment', as: 'subscription_payment'
  patch 'validate_subscription/:subscription_id', to: 'subscriptions#validate_subscription', as: 'validate_subscription'
  get 'congratulations/:subscription_id', to: 'subscriptions#congratulations', as: 'subscription_congratulations'

  resources :users, only: [:show, :update]
  resources :subscriptions, only: [:show ] do
    resources :billings, only: [:new, :create]
  end
  resources :products, only: [:index]
  resources :addresses, only: [:create]

  post 'charge', to: 'charges#create'

  get 'products/modal/:id', to: 'products#modal', as: 'modal_product'

  resources :categories, only: [:index] do
    resources :products, only: [:index] do
      post 'subscriptions/wifi', to: 'subscriptions#create_wifi_subcription', as: 'create_wifi_subscription'
      get 'subscriptions/wifi/new', to: 'subscriptions#new_wifi', as: 'new_subscription_wifi'
      resources :subscriptions, only: [:create]
    end
  end
end
