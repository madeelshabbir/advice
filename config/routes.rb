# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#show'

  resource :error, only: :show

  resources :customers, only: [] do
    resource :wishlist, only: %i(update show destroy)
  end

  mount ShopifyApp::Engine, at: '/'
  mount Sidekiq::Web, at: '/sidekiq'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  get ':error', to: redirect('/error')
end
