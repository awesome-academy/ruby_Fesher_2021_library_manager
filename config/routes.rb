Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    delete "/logout", to: "sessions#destroy"
    resources :categories, only: %i(show)
    resources :requests, except: %i(edit destroy show)
    resources :users, except: %i(index destroy)
    resources :account_activations, only: %i(edit)
    resources :password_resets, except: %i(index show destroy)
    resources :comments, only: %i(create)
    resources :books, only: %i(show)
    resources :likes, only: %i(create destroy)
    resources :authors, only: %i(show)
    namespace :admin do
      root "admin#index"
      resources :authors
      resources :publishers
      resources :categories
      resources :requests, only: %i(index show update)
    end
  end
end
