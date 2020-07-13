Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  resources :users
  resources :posts, only: [:new, :create, :show] do
    resources :comments, only: [:new, :create]
    collection do
      get 'search'
    end
  end
  # devise_scope :user do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
end
