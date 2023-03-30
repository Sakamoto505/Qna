# frozen_string_literal: true

Rails.application.routes.draw do
  get 'rewards/index'
  devise_for :users
  root to: 'questions#index'
  concern :voted do
    member do
      patch :like
      patch :dislike
      delete :cancel
    end
  end

  resources :questions, concerns: :voted  do
    resources :answers, concerns: :voted, shallow: true do
      patch :set_best, on: :member
    end
  end
  resources :attachments, only: [:destroy]
  resources :links, only: [:destroy]
  resources :rewards, only: :index
end
