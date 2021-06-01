Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  devise_for :users, controllers: { sessions: "sessions", confirmations: 'confirmations', registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks"}
  devise_scope :user do
    get '/users', to: 'registrations#new'
  end
  unauthenticated :user do
    root 'pages#home'
  end
  # authenticated :user do
  #   root 'pages#home'
  # end

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

  resources :leads, only: [:create]
end
