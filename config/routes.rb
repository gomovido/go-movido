Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations"}
  devise_scope :user do
    get '/users', to: 'registrations#new'
  end
  unauthenticated do
    root 'pages#home'
  end
  authenticated do
    root 'pages#dashboard_index', as: 'dashboard_index'
  end

  get 'congratulations/:subscription_id', to: 'subscriptions#congratulations', as: 'subscription_congratulations'
  get 'summary/:subscription_id', to: 'subscriptions#summary', as: 'subscription_summary'
  patch 'validate_subscription/:subscription_id', to: 'subscriptions#validate_subscription', as: 'validate_subscription'
  resources :users, only: [:show, :update]

  resources :subscriptions, only: [:show ]
  resources :products, only: [:index]
  get 'products/modal/:id', to: 'products#modal', as: 'modal_product'

  resources :categories, only: [:index] do
    resources :products, only: [:index] do
      resources :subscriptions, only: [:new, :create, :update]
    end
  end
end
