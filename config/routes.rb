Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    devise_for :users, skip: :omniauth_callbacks
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registrations#new"
    end
    resources :categories, only: %i(show)
    resources :requests, except: %i(edit destroy show)
    resources :users, only: %i(show)
    resources :account_activations, only: %i(edit)
    resources :password_resets, except: %i(index show destroy)
    resources :comments, only: %i(create)
    resources :books, only: %i(index show)
    resources :likes, only: %i(create destroy)
    resources :authors, only: %i(show)
    get "author/search", to: "authors#search"
    namespace :admin do
      root "admin#index"
      resources :authors
      resources :publishers
      resources :categories
      resources :requests, only: %i(index show update)
    end
  end
end
