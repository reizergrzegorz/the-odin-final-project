Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  
  resources :posts, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create]
  end  
end
