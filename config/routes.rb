# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :categories
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'categories#index'
  get 'cart', to: 'cart#index'
  get 'show/:id', to: 'products#show', as: 'show'
  post 'add_quantity/:id', to: 'cart#add_quantity', as: 'add_quantity'
  post 'subtract_quantity/:id', to: 'cart#subtract_quantity', as: 'subtract_quantity'
  post 'add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
  post 'remove_from_cart/:id', to: 'cart#remove_from_cart', as: 'remove_from_cart'
end
