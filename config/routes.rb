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
      
      get "kandang/:user_id" => "data_kandang#data_kandang_user", as: "data_kandang_user"
      post "kandang" => "data_kandang#create", as: "create_kandang"
      put "kandang/:id" => "data_kandang#update", as: "update_kandang"
      delete "kandang/:id" => "data_kandang#destroy", as: "delete_kandang"

      get "sapi/:data_kandang_id" => "data_sapi#data_sapi_kandang", as: "data_sapi_kandang"
      post "sapi" => "data_sapi#create", as: "create_sapi"
      put "sapi/:id" => "data_sapi#update", as: "update_sapi"
      delete "sapi/:id" => "data_sapi#destroy", as: "delete_sapi"

      get "pemeriksaan/:data_sapi_id" => "data_pemeriksaan#data_pemeriksaan_sapi_latest", as: "data_pemeriksaan_sapi_latest"
      get "pemeriksaan/kandang/:data_kandang_id" => "data_pemeriksaan#data_pemeriksaan_sapi_by_kandang", as: "data_pemeriksaan_sapi_by_kandang"
      get "pemeriksaan/summary/:data_sapi_id" => "data_pemeriksaan#summary_pemeriksaan", as: "summary_pemeriksaan"
      get "pemeriksaan/summary/kandang/:data_kandang_id" => "data_pemeriksaan#summary_pemeriksaan_kandang", as: "summary_pemeriksaan_kandang"
      post "pemeriksaan" => "data_pemeriksaan#create", as: "create_pemeriksaan"
      put "pemeriksaan/:id" => "data_pemeriksaan#update", as: "update_pemeriksaan"
      delete "pemeriksaan/:id" => "data_pemeriksaan#destroy", as: "delete_pemeriksaan"

      get "device/:user_id" => "devices#device_user", as: "device_user"
      get "device/identifier/:device_identifier" => "devices#device_by_identifier", as: "device_by_identifier"
      post "device" => "devices#create", as: "create_device"
      put "device/:id" => "devices#update", as: "update_device"
      delete "device/:id" => "devices#destroy", as: "delete_device"
      
      mount ActionCable.server => "/connect"
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
