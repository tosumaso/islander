Rails.application.routes.draw do
  devise_for :users
  root to: "maps#index"
  resources :maps, only: [:index, :show] do
    resources :posts, only: [:create]
    resources :comments, only: [:create]
  end
end
