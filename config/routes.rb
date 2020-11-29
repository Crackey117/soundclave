Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  get "/posts", to: "homes#index"
  get "/posts/new", to: "homes#authenticated"
  
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :create] 
    end 
  end
end
