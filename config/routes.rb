# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :categories
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  get '/about' => 'abouts#index'
  get '/contact' => 'contacts#index'
  get '/search' => 'products#search', as: 'search_page'
  get 'cart', to: 'cart#index'
  get 'show/:id', to: 'products#show', as: 'show'
  get '/check_out', to: 'check_out#index', as: 'check_out_index'
  post '/add_quantity/:id', to: 'cart#add_quantity', as: 'add_quantity'
  post 'subtract_quantity/:id', to: 'cart#subtract_quantity', as: 'subtract_quantity'
  post 'products/add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
  post 'remove_from_cart/:id', to: 'cart#remove_from_cart', as: 'remove_from_cart'

  scope '/check_out' do
    post 'create', to: 'check_out#create', as: 'check_out_create'
    get 'cancel', to: 'check_out#cancel', as: 'check_out_cancel'
    get 'success', to: 'check_out#success', as: 'check_out_success'
  end
end
