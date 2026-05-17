Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :comments, only: %i[create update destroy]

  resources :notifications, only: %i[index] do
    patch :mark_as_read, on: :member
    patch :mark_all_as_read, on: :collection
  end
end
