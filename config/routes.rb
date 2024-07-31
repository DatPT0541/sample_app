Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create show edit update index destroy)

    get "/login", to:"sessions#new"
    post "/login", to:"sessions#create"
    delete "/logout", to:"sessions#destroy"

    resources :users do
      member do
        get :following, :followers
      end
    end

    resources :relationships,only: %i(create destroy)

    resources :account_activations, only: :edit

    resources :password_resets, only: %i(new create edit update)

    resources :microposts, only: %i(create destroy)

    root "static_pages#home"
  end
end
