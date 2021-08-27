Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'

  resources :tweets, only: %i[index create show update edit] do
    resources :comments, only: %i[create update edit]
  end
end
