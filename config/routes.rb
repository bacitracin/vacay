Rails.application.routes.draw do

  devise_for :users
  resources :trips
  resources :destinations

  root to: "welcome#index"

end
