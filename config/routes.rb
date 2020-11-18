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

  get 'summary/:subscription_id', to: 'subscriptions#summary', as: 'subscription_summary'
  get 'payment/:subscription_id', to: 'subscriptions#payment', as: 'subscription_payment'
  patch 'validate_subscription/:subscription_id', to: 'subscriptions#validate_subscription', as: 'validate_subscription'
  get 'congratulations/:subscription_id', to: 'subscriptions#congratulations', as: 'subscription_congratulations'

  resources :users, only: [:show, :update]
  resources :subscriptions, only: [:show ]
  resources :products, only: [:index]
  resources :addresses, only: [:create]

  get 'products/modal/:id', to: 'products#modal', as: 'modal_product'

  resources :categories, only: [:index] do
    resources :products, only: [:index] do
      resources :subscriptions, only: [:new, :create, :update]
    end
  end
end
