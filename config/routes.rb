Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations"}
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard_index', as: 'dashboard_index'
  resources :users, only: [:show, :update, :create]

  resources :addresses, only: [:create] do
    resources :products, only: [:index] do
      resources :billings, only: [:new, :create]
      resources :subscriptions, only: [:create, :update]
    end
  end

  resources :subscriptions, only: [:show ]

  resources :categories, only: [:index] do
    resources :products, only: [:index] do
      resources :subscriptions, only: [:new]
    end
  end
end
