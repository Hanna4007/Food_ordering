# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'restaurants#index'
  resource :user, only: %i[edit update]
  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :restaurants, only: %i[index] do
    resources :products, only: %i[index]
  end
  resource :carts, only: %i[edit update]
  resources :order_items
  resources :personal_orders
  resources :favorite_products, only: %i[index create destroy]

  namespace :admin do
    resources :restaurants, only: %i[new create edit update destroy] do
      resources :products, only: %i[new create edit update destroy]
    end

    resources :users

    resources :personal_orders do
      resources :order_items, only: %i[update destroy]
    end

    resources :company_orders
    resource :carts, only: %i[edit update]
  end
end
