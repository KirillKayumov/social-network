Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show, :edit, :update]

  resources :friendships, only: [:create, :destroy] do
    member do
      patch 'accept', to: 'friendships#accept', as: :accept
      patch 'reject', to: 'friendships#reject', as: :reject
    end
  end

  get 'users/:user_id/friends', to: 'friendships#index', as: :user_friends
end
