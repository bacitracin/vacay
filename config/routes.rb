Rails.application.routes.draw do

  resources :attractions
  devise_for :users 

  root to: "welcome#index"
  resources :destinations

  resources :users do
    resources :trips, shallow: true
  end

end
