Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: %i(show index) do
    resources :friends, only: %i(index create destroy) do
      member do
        post 'accept', to: 'friends#accept', as: 'accept'
        delete 'reject', to: 'friends#reject', as: 'reject'
      end
    end
    resources :photos, only: %i(create index destroy)
  end

  resources :messages, only: %i(index show new create destroy)

  # resources :friendships, only: %i(create destroy) do
  #   member do
  #     patch 'accept', to: 'friendships#accept', as: :accept
  #     delete 'reject', to: 'friendships#reject', as: :reject
  #   end
  # end

  resources :posts, only: %i(create destroy) do
    post 'like', to: 'likes#create', as: :create_like
    delete 'like', to: 'likes#destroy', as: :destroy_like
  end
end
