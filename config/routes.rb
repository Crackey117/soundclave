Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  get "/posts", to: "homes#index"
  
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index] 
    end 
  end
end
