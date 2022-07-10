# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources :products, only: :index
  mount ShopifyApp::Engine, at: '/'
end
