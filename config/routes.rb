Rails.application.routes.draw do
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'services', to: 'pages#services'
  get 'events', to: 'pages#events'
  resources :events, only: [:show]

  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  namespace :api do
    namespace :v1 do
      post '/events/:event_id/process_csv', to: 'csv_processor#create'
    end
  end

  namespace :admin do
    resources :error_logs, only: [:index, :show]
    resources :events
    resources :api_keys, only: [:index, :create, :destroy]
    get 'dashboard', to: 'dashboard#index'
    root to: 'dashboard#index' # /admin
  end
  # root 'home#index' # Change to your public root path
end
