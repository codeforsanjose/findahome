require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    resources :listings
  end

  mount Sidekiq::Web => '/sidekiq'
  mount_ember_app :frontend, to: "/"
end
