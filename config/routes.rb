Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: %i(show edit update) do
    resources :photos, only: %i(create index destroy)
  end

  resources :friendships, only: %i(create destroy) do
    member do
      patch 'accept', to: 'friendships#accept', as: :accept
      delete 'reject', to: 'friendships#reject', as: :reject
    end
  end

  get 'users/:user_id/friends', to: 'friendships#index', as: :user_friends

  resources :posts, only: %i(create destroy) do
    post 'like', to: 'likes#create', as: :create_like
    delete 'like', to: 'likes#destroy', as: :destroy_like
  end
end
