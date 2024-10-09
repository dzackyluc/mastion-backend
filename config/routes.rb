Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "me", to: "users#me", as: "me"
      get "users" => "users#all_users", as: "users"

      post "login" => "auth#login", as: "login"
      post "register" => "users#create", as: "register"

      put "users/:id" => "users#update", as: "update_user"

      delete "users/:id" => "users#delete", as: "delete_user"
      
      mount ActionCable.server => "/connect"
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
