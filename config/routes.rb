# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  resources :kudos

  root 'kudos#index'
  get 'home/index', to: 'home#index'

  namespace 'admins' do
    get '/dashboard', to: 'pages#dashboard'
  end
end
