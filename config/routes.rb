# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :listings
      resources :swagger, only: [:index]
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  mount_ember_app :frontend, to: "/"
end
