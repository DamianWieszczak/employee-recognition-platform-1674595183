# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  
  namespace :employees do
    resources :kudos
    resources :rewards, only: [:index, :show]
    resources :orders, only: [:index, :create]
  end
  namespace :admins do
    get '/dashboard', to: 'pages#dashboard'
    
    get 'add_kudos_to_all', to: 'employees#edit_kudos_to_all'
    patch 'add_kudos_to_all', to: 'employees#add_kudos_to_all'
    resources :kudos
    resources :employees, only: [:index, :edit, :update, :destroy] do
      resources :orders, only: [:index, :update]
    end
    namespace :employees do
      resources :orders, only: [:index, :update]
    end
    resources :company_values
    resources :rewards
  end

  root 'employees/kudos#index'
  get 'home/index', to: 'home#index'
end
