# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout'

    resources :users, only: %i[new]
    resource :profile, only: %i[show]

    resources :bulletins, only: %i[new create destroy edit update show index] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
      root 'home#index'
      resources :categories
      resources :bulletins do
        member do
          patch :publish
          patch :archive
          patch :reject
        end
      end
    end
  end
end
