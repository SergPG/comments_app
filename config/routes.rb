Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :comments, only: %i[create update destroy]

  resources :notifications, only: %i[index] do
    member do
      patch :mark_as_read
    end
  end
end
