Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  resources :users
  resources :posts, only: [:new, :create, :show] do
    resources :comments, only: [:new, :create]
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
