Myflix::Application.routes.draw do
  get "/register", to: "users#new"
  get "/register/:token", to: "users#new_with_invite_token", as: "register_with_token"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/home", to: "categories#index"
  get "/my_queue", to: "queue_items#index"
  post "/update_queue", to: "queue_items#edit"

  get "/forgot_password", to: "forgot_passwords#new"
  resources :forgot_passwords, only: [:create]
  get "/forgot_password_confirmation", to: "forgot_passwords#confirm"
  resources :password_resets, only: [:show, :create]
  get "/expired_token", to: "password_resets#expired_token"

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :invites, only: [:new, :create]
  get "/people", to: "followings#index"
  resources :followings, only: [:create, :destroy]
  resources :queue_items, only: [:create, :destroy]
  resources :users, only: [:create, :show]
  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
       post "search", to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'
end
