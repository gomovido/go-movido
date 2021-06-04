Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, controllers: { sessions: "sessions", registrations: 'registrations'}

  root 'pages#home'
  get 'simplicity', to: 'steps#simplicity', as: 'simplicity'

  #Errors pages
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'

  get 'privacy', to: 'pages#privacy'
  get 'cookies', to: 'pages#cookies'
  get 'terms', to: 'pages#terms', as: 'terms'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'about', to: 'pages#about'

  resources :leads, only: [:create]
end
