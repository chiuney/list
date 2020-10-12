Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }

  delete '/users/:id', to: 'users#destroy', as: 'destroy_user_account'
  resources :users

  delete "/users/:user_id/lists/:id", to: "lists#destroy", as: "destroy_lists"

  resources :users do
    resources :lists, only: [:create, :new, :show ,:edit, :update]
  end

  resources :lists do
    resources :shops, only: [:create, :destroy, :show, :index, :new]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
