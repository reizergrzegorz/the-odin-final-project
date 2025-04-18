Rails.application.routes.draw do
  get "users/index"

  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  resources :users, only: [:index]

  resources :posts, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create]
  end 
  resources :posts do
    resource :like, only: [:create, :destroy]
  end 
  resources :profiles, only: [:show, :edit, :update]
  resources :follow_requests, only: [:create, :update, :destroy]
end
