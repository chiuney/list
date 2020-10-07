Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  delete '/users/:id', to: 'users#destroy', as: 'destroy_user_account'
  resources :users

  post "/lists/new", to:"lists#new", as:"new_lists"
  resources :lists
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
