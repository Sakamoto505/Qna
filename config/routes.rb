# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  get 'rewards/index'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  root to: 'questions#index'
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
  end
  resources :attachments, only: [:destroy]
  resources :links, only: [:destroy]
  resources :rewards, only: :index

  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resource 'profiles', only: [] do
        get :me, on: :collection
      end
    end
  end
end
