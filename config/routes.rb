Rails.application.routes.draw do
  resources :listings
  mount_ember_app :frontend, to: "/"
end
