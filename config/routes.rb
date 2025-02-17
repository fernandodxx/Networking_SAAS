Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [ :index, :show ]
  get "/profile", to: "users#profile"
  get "/dashboard", to: "users#dashboard"

  resources :interests, only: [ :index, :create ]
  resources :connections, only: [ :index, :create ]
  get '/users/by_interest/:name', to: 'users#by_interest' # rubocop:disable Style/StringLiterals
  get "/users/:user_id/connections", to: "connections#user_connections"
  resources :user_interests, only: [ :index, :create ]
  delete '/user_interests', to: 'user_interests#destroy' # rubocop:disable Style/StringLiterals
  resources :connection_requests, only: [ :create ]
  patch "/connection_requests/:id/accept", to: "connection_requests#accept"
  patch "/connection_requests/:id/decline", to: "connection_requests#decline"
  get "/connection_requests/pending", to: "connection_requests#pending_requests"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
