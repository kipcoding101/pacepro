Rails.application.routes.draw do
  get 'home', to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'services', to: 'static_pages#services'
  get 'events', to: 'static_pages#events'
  root 'static_pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  namespace :api do
    namespace :v1 do
      post '/csv-processor', to: 'csv_processor#create'
    end
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    root to: 'dashboard#index' # /admin
  end
  # root 'home#index' # Change to your public root path
end
