Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :profiles, only: [:show, :edit, :update]
end
