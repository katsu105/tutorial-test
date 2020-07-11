Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  resources :users do
    resources :posts, only: [:new, :create, :show]
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
