Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations"}
  devise_scope :user do
    get '/users', to: 'registrations#new'
  end
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard_index', as: 'dashboard_index'
  get 'congratulations/:subscription_id', to: 'subscriptions#congratulations', as: 'subscription_congratulations'
  get 'summary/:subscription_id', to: 'subscriptions#summary', as: 'subscription_summary'
  patch 'validate_subscription/:subscription_id', to: 'subscriptions#validate_subscription', as: 'validate_subscription'
  resources :users, only: [:show, :update]

  resources :subscriptions, only: [:show ]
  resources :products, only: [:index]

  resources :categories, only: [:index] do
    resources :products, only: [:index] do
      resources :subscriptions, only: [:new, :create, :update]
    end
  end
end
