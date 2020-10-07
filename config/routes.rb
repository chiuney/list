Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  delete '/users/:id', to: 'users#destroy', as: 'destroy_user_account'
  resources :users

  # PATCH "/lists/:id", to: "lists#update", as "update_lists"
  resource :lists
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
