# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: :index

  mount ShopifyApp::Engine, at: '/'
  mount Sidekiq::Web, at: '/sidekiq'
end
