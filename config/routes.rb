Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions" }
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard_index', as: 'dashboard_index'
  resources :users, only: [:show, :update]
end
