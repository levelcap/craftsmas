Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "join/:invite_code" => "gift_exchanges#join", :as => "join"

  root :to => "users#new"
  resources :users
  resources :sessions
  resources :gift_exchanges do
    member do
      get "join"
      post "add_user"
    end
  end
end
