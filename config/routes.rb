Rails.application.routes.draw do
  namespace :api do
    resources :listings
  end

  mount_ember_app :frontend, to: "/"
end
