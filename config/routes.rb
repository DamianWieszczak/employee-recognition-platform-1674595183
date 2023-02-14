# frozen_string_literal: true

Rails.application.routes.draw do
  root "kudos#index"
  get "home/index", to: "home#index"
  devise_for :employees
  resources :kudos
end
