Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  unauthenticated do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end
  resources :posts
end
