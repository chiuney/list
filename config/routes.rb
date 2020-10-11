Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }

  delete '/users/:id', to: 'users#destroy', as: 'destroy_user_account'
  resources :users

  post "/lists/:id", to:"lists#create", as:"create_lists"
  post "/lists/new", to:"lists#new", as:"new_lists"
  patch "/lists/:id", to:"lists#update", as:"update_lists"
  resources :lists

  delete "/lists/:id", to: "lists#destroy", as:"destroy_lists"
  resources :shops
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
