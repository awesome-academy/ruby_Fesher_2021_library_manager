Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :requests, only: %i(new create)
    namespace :admin do
      root "admin#index"
      resources :authors
      resources :publishers
      resources :categories
      resources :requests, only: %i(index show update)
    end
  end
end
