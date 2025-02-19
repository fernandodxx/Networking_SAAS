Rails.application.routes.draw do
  # Root and home routes
  root "home#index"
  get "home/index"

  # Authentication routes
  devise_for :users

  # User related routes
  resources :users
  get "/profile", to: "users#profile"
  get "/dashboard", to: "users#dashboard"
  get '/users/by_interest/:name', to: 'users#by_interest' # rubocop:disable Style/StringLiterals

  # Interest related routes
  resources :interests, only: [ :index, :create, :destroy ]
  resources :user_interests, only: [ :index, :create ]
  delete '/user_interests', to: 'user_interests#destroy' # rubocop:disable Style/StringLiterals

  # Connection related routes
  resources :connections, only: [ :index, :create ]
  get "/users/:user_id/connections", to: "connections#user_connections"

  # Connection requests routes
  resources :connection_requests, only: [ :create ]
  get "/connection_requests/pending", to: "connection_requests#pending_requests"
  patch "/connection_requests/:id/accept", to: "connection_requests#accept"
  patch "/connection_requests/:id/decline", to: "connection_requests#decline"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes (commented)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
