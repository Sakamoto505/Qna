# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions do
    resources :answers, only: %i[create update destroy], shallow: true do
      patch :set_best, on: :member
    end
  end
  resources :attachments, only: [:destroy]
end
