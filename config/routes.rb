# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  get 'rewards/index'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  root to: 'questions#index'
  get 'results', to: 'results#index_search', as: 'results'

  concern :voted do
    member do
      patch :like
      patch :dislike
      delete :cancel
    end
  end

  concern :commented do
    member do
      post :comment
    end
  end

  resources :questions, concerns: %i[voted commented] do
    resources :answers, concerns: %i[voted commented], shallow: true do
      patch :set_best, on: :member
    end
    resources :subscriptions, only: %i[create destroy], shallow: true

  end
  resources :attachments, only: [:destroy]
  resources :links, only: [:destroy]
  resources :rewards, only: :index

  namespace :api do
    namespace :v1 do
      resource 'profiles', only: [] do
        get :me, on: :collection
        get :index, on: :collection
      end

      resources :questions, only: %i[index show create update destroy] do
          resources :answers, only: %i[index show create update destroy]
        end
    end
  end

  mount ActionCable.server => '/cable'
end
