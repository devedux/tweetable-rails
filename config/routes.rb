Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'

  resources :tweets, only: %i[index create show] do
    resources :comments, only: %i[create]
  end
end
