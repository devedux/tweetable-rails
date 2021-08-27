Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  root to: 'tweets#index'

  resources :tweets, only: %i[index create show update edit] do
    resources :comments, only: %i[create update edit]
  end
end
