# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "home/index", to: "home#index"
  devise_for :employees
  
end
