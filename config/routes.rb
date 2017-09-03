Rails.application.routes.draw do

  devise_for :restaurant_owners, :controllers => { registrations: 'restaurant_owners/registrations', sessions: 'restaurant_owners/sessions', passwords: 'restaurant_owners/passwords', unlocks: 'restaurant_owners/unlocks', confirmations: 'restaurant_owners/confirmations'}
  devise_for :restaurant_managers, :controllers => { registrations: 'restaurant_managers/registrations', sessions: 'restaurant_managers/sessions', passwords: 'restaurant_managers/passwords'}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # root "welcome#about"
  root to: 'home#index'

  
  # get '/signup', to: "registrations#new"
  # post '/signup', to: "registrations#create"

  # get 'login', to: "sessions#new"
  # post '/login', to: "sessions#create" 
  # delete '/logout', to: "sessions#destroy"

  # get 'users/:id', to: "users#show", as: "profile"

  # resources :chatrooms, param: :slug
  resources :messages
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  get 'contact', to: 'email_messages#new', as: 'new_email_message'
  post 'contact', to: 'email_messages#create', as: 'create_email_message'
  get 'policy', to: 'home#policy', as: 'policy'
  get 'eula', to: 'home#eula', as: 'eula'

  get 'restaurant_managers' => 'restaurant_managers/dashboard#index', :as => "restaurant_managers_index"
  patch 'restaurant_managers/order_preparing/:order_id' => 'restaurant_managers/dashboard#order_preparing', :as => 'restaurant_managers_preparing' 
  patch 'restaurant_managers/order_serving/:order_id' => 'restaurant_managers/dashboard#order_serving', :as => 'restaurant_managers_serving' 
  patch 'restaurant_managers/order_checkout/:order_id' => 'restaurant_managers/dashboard#order_checkout', :as => 'restaurant_managers_checkout' 
  patch 'restaurant_managers/receive_waiter_call/:waiter_call_id' => 'restaurant_managers/dashboard#receive_waiter_call', :as => 'restaurant_managers_receive_waiter_call' 

  get 'restaurant_owner', to: 'restaurant_owners/dashboard#index', :as => 'restaurant_owners_index' 

  namespace :api, defaults: { format: :json } do
    namespace :v1 do


      resources :sessions, only: [:create]
      post "log_out" => "sessions#destroy", :as => "log_out"
      resources :clients, only: [:show, :create]
      post "menu" => "menus#menu", :as => "get_menu"
      resources :orders, only: [:create]
      post "facebook_login" => "facebook#create", :as => "facebook_login"
      post "set_gcm" => "clients#set_gcm", :as => "set_gcm"
      post "waiter_call" => "orders#waiter_call_action", :as => "waiter_call_action"      
      post "set_manager_gcm" => "orders#set_manager_gcm", :as => "set_manager_gcm"


    end
  end


end
