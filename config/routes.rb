Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        resources :tests
        resources :users
        resources :accounts
        resources :articles
        post '/login', to: 'sessions#create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
