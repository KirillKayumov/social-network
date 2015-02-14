Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :profiles, only: [:show, :edit, :update] do
    get 'friends', to: 'friendships#index', as: :friendships
  end
  resources :friendships, only: [:create, :destroy] do
    member do
      patch 'accept', to: 'friendships#accept', as: :accept
      patch 'reject', to: 'friendships#reject', as: :reject
    end
  end
end
