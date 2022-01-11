Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :categories, only: %i(show)
    resources :requests, except: %i(edit destroy show)
    resources :users, only: %i(show)
    namespace :admin do
      root "admin#index"
      resources :authors
      resources :publishers
      resources :categories
      resources :requests, only: %i(index show update)
    end
  end
end
